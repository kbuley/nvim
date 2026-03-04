--------------------------------------------------------------------------------
-- PATH HELPERS
--------------------------------------------------------------------------------
local function get_ai_base_path()
  local xdg_config = os.getenv("XDG_CONFIG_HOME")
  local base = xdg_config and xdg_config or (os.getenv("HOME") .. "/.config")
  return base .. "/ai/"
end

local function read_ai_file(subpath)
  local f = io.open(get_ai_base_path() .. subpath, "r")
  if not f then
    return nil
  end
  local content = f:read("*all")
  f:close()
  return content
end

-- No custom prompt loader needed: prompts are loaded via the native markdown
-- directory feature (prompt_library.markdown.dirs) configured below.
-- Prompt files in ~/.config/ai/prompts/ use ${context.*} placeholders
-- natively and the `rules` frontmatter opt for language-specific rule loading.

--------------------------------------------------------------------------------
-- AGENT RULES TOOL
-- Reads language-specific AGENTS_*.md files from ~/.config/ai/context/.
-- Files must contain an "APPLIES-TO: <lang>" header in the first 15 lines.
--
-- Registered inline in interactions.chat.tools using the current v18 API:
-- https://codecompanion.olimorris.dev/extending/tools
--------------------------------------------------------------------------------

--- Resolve the filename for a given language target by scanning AGENTS_*.md
--- files for a matching APPLIES-TO header, falling back to AGENTS_<LANG>.md.
---@param target string Lowercase language name, e.g. "go"
---@return string|nil content File contents, or nil if not found
local function resolve_agent_rules(target)
  local context_path = get_ai_base_path() .. "context/"
  local files = vim.fn.globpath(context_path, "AGENTS_*.md", false, true)
  local matched_file = nil

  for _, filepath in ipairs(files) do
    local f = io.open(filepath, "r")
    if f then
      for _ = 1, 15 do
        local line = f:read("*l")
        if not line then
          break
        end
        local applies = line:match("APPLIES%-TO:%s*(.*)")
        if applies then
          for lang in string.gmatch(applies, "([^,%s]+)") do
            if lang:lower() == target then
              matched_file = filepath:match("^.+/(.+)$")
              break
            end
          end
        end
      end
      f:close()
    end
    if matched_file then
      break
    end
  end

  local filename = matched_file or ("AGENTS_" .. target:upper() .. ".md")
  return read_ai_file("context/" .. filename)
end

-- Tool definition table — registered under interactions.chat.tools below.
local agent_reader_tool = {
  description = "Load coding rules for a specific language from the local agent rules files",
  callback = {
    name = "agent_rules",

    -- OpenAI function-calling schema: describes the arguments the LLM must
    -- provide when invoking this tool.
    schema = {
      type = "function",
      ["function"] = {
        name = "agent_rules",
        description = "Load the coding rules and conventions for a given programming language",
        parameters = {
          type = "object",
          properties = {
            language = {
              type = "string",
              description = "The programming language to load rules for, e.g. 'go', 'typescript', 'vue'",
            },
          },
          required = { "language" },
          additionalProperties = false,
        },
        strict = true,
      },
    },

    system_prompt = [[## Agent Rules Tool (`agent_rules`)

### CONTEXT
You have access to a tool that loads language-specific coding rules and conventions
from the local development environment.

### OBJECTIVE
Call this tool before writing or reviewing code when the user's language has
established rules in this project. The tool will return the full ruleset to apply.

### USAGE
- Invoke with the lowercase language name, e.g. "go", "typescript", "vue"
- Apply every rule returned to your subsequent responses
]],

    -- Function-based cmd: receives args.language from the LLM's tool call.
    -- Returns { status = "success"|"error", data = string }.
    cmds = {
      ---@param self table The tool instance
      ---@param args table Arguments from the LLM: { language: string }
      ---@return { status: "success"|"error", data: string }
      function(self, args)
        local target = (args.language or ""):lower()
        if target == "" then
          return { status = "error", data = "No language specified" }
        end

        local content = resolve_agent_rules(target)
        if content then
          return { status = "success", data = "RULES LOADED:\n\n" .. content }
        else
          return { status = "error", data = "No rules found for language: " .. target }
        end
      end,
    },

    output = {
      ---@param self table
      ---@param tools CodeCompanion.Tools
      ---@param cmd table
      ---@param stdout table Results from the cmd function
      success = function(self, tools, cmd, stdout)
        return tools.chat:add_tool_output(self, stdout[1])
      end,

      ---@param self table
      ---@param tools CodeCompanion.Tools
      ---@param cmd table
      ---@param stderr table
      error = function(self, tools, cmd, stderr)
        return tools.chat:add_tool_output(self, stderr[1] or "agent_rules: unknown error")
      end,
    },
  },
}

--------------------------------------------------------------------------------
-- MAIN PLUGIN CONFIG (v18.7.0)
--------------------------------------------------------------------------------
return {
  "olimorris/codecompanion.nvim",
  version = "^18.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
    "ravitemer/mcphub.nvim",
    "nvim-mini/mini.diff",
  },
  event = "VeryLazy",
  opts = {
    -- Disable built-in rules discovery (CLAUDE.md / .cursor/rules auto-loading)
    rules = {
      opts = {
        enabled = false,
      },
    },

    --------------------------------------------------------------------------
    -- INTERACTIONS (v18: was "strategies")
    --------------------------------------------------------------------------
    interactions = {
      chat = {
        -- Default: Copilot (model set via adapters.http.copilot below)
        -- Switch adapters in-session with `ga` in the chat buffer.
        adapter = "copilot",
        default_tool_group = "default",
        opts = {
          auto_submit_errors = true,
          auto_submit_success = true,
          stop_context_insertion = true,
          -- v18: system_prompt moved from top-level opts to interactions.chat.opts
          -- Receives ctx table; extend ctx.default_system_prompt so the LLM
          -- retains all built-in CodeCompanion instructions.
          ---@param ctx CodeCompanion.SystemPrompt.Context
          ---@return string
          system_prompt = function(ctx)
            local custom = read_ai_file("context/SYSTEM.md")
            if custom and custom ~= "" then
              return ctx.default_system_prompt .. "\n\n" .. custom
            end
            return ctx.default_system_prompt
          end,
        },
        tools = {
          "tavily",
          "files",
          "grep_search",
          "neovim",
          "read_file",
          "create_file",
          "insert_edit_into_file",
          "file_search",
          "grep_search",
          "list_code_usages",
          "neovim",
          "fetch_webpage",
          "cmd_runner",
          "web_search",
          -- MCPhub tools/slash commands are injected via the extension below.
          -- Custom inline tool: loads language rules from ~/.config/ai/context/
          agent_rules = agent_reader_tool,

          -- delete_file is registered but requires approval even in yolo mode
          delete_file = {
            opts = {
              allowed_in_yolo_mode = false,
            },
          },
          groups = {
            default = {
              description = "Default tools for code-related interactions",
              tools = {
                "read_file",
                "create_file",
                "insert_edit_into_file",
                "file_search",
                "grep_search",
                "list_code_usages",
                "neovim",
                "fetch_webpage",
                "delete_file",
                "agent_rules",
                "cmd_runner",
                "web_search",
              },
            },
          },
        },
        keymaps = {
          options = {
            modes = {
              n = "?",
            },
            callback = function()
              require("which-key").show({ global = false })
            end,
            description = "CodeCompanion keymaps",
            hide = true,
          },
        },
      },
      inline = {
        adapter = "copilot",
        opts = {
          stop_context_insertion = true,
        },
        diff = {
          enabled = true,
          provider = "mini_diff",
        },
      },
      cmd = {
        -- Ollama is a good lightweight choice for command generation
        adapter = "copilot",
      },
    },

    --------------------------------------------------------------------------
    -- ADAPTERS
    -- v18: http adapters -> adapters.http.*
    --      acp adapters  -> adapters.acp.*
    --------------------------------------------------------------------------
    adapters = {
      http = {
        -- GitHub Copilot (default)
        -- Requires: copilot.vim or copilot.lua, run `:Copilot setup`
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-sonnet-4.6",
              },
            },
          })
        end,

        -- Ollama (local, default port 11434)
        -- Assumes Ollama is running at http://127.0.0.1:11434 (the default).
        -- Change the model below to match whatever you have pulled locally.
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "deepseek-coder-v2:16b",
                -- With this turned off, it will list all the available models
                -- choices = {
                --   "deepseek-coder-v2:16b",
                --   "qwen2.5-coder:14b",
                --   "qwen2.5-coder:32b-base-q5_K_M",
                -- },
              },
            },
          })
        end,

        -- Tavily (web search tool adapter)
        -- Requires: TAVILY_API_KEY environment variable
        tavily = function()
          return require("codecompanion.adapters").extend("tavily", {
            env = {
              api_key = "TAVILY_API_KEY", -- reads from $TAVILY_API_KEY
            },
          })
        end,
      },

      acp = {
        -- Claude Code (ACP agent via Zed's claude-code-acp adapter)
        -- Requires:
        --   1. `npm install -g @anthropic-ai/claude-code` (Claude Code CLI)
        --   2. `npm install -g @zed-industries/claude-code-acp` (ACP adapter)
        --   3. Auth: run `claude setup-token` for Pro, or set ANTHROPIC_API_KEY
        --
        -- Model names are short identifiers passed to the Claude Code CLI.
        -- Valid values: "sonnet", "opus", "haiku" (or versioned variants the
        -- CLI accepts, e.g. "claude-sonnet-4-5"). Check `claude --help` for
        -- the exact strings your installed version supports.
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            defaults = {
              model = "sonnet", -- targets Claude Sonnet; pin version if needed
            },
            -- If using an API key instead of OAuth:
            -- env = {
            --   ANTHROPIC_API_KEY = "ANTHROPIC_API_KEY",
            -- },
            --
            -- If using OAuth (Claude Pro subscription):
            -- env = {
            --   CLAUDE_CODE_OAUTH_TOKEN = "CLAUDE_CODE_OAUTH_TOKEN",
            -- },
          })
        end,
      },
    },

    --------------------------------------------------------------------------
    -- EXTENSIONS
    -- MCPhub moved from interactions.chat.tools to extensions in v18.
    --------------------------------------------------------------------------
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
    },

    --------------------------------------------------------------------------
    -- PROMPT LIBRARY
    -- Markdown files in ~/.config/ai/prompts/ are loaded natively.
    -- Files use ${context.filetype}, ${context.code} etc. as placeholders.
    -- Frontmatter `opts.alias` sets the slash command name.
    -- Frontmatter `opts.rules` loads a rule group into the chat buffer.
    --------------------------------------------------------------------------
    prompt_library = {
      markdown = {
        dirs = {
          get_ai_base_path() .. "prompts",
        },
      },
    },

    --------------------------------------------------------------------------
    -- UI
    --------------------------------------------------------------------------
    display = {
      diff = {
        provider = "mini_diff",
      },
      chat = {
        show_settings = false,
        window = {
          width = 0.45,
          height = 0.8,
        },
      },
    },
  },

  --------------------------------------------------------------------------
  -- CONFIG FUNCTION
  -- MCPhub must be initialised before CodeCompanion so the extension can
  -- register its tools and slash commands correctly.
  --------------------------------------------------------------------------
  config = function(_, opts)
    require("mcphub").setup({
      port = 3000,
      config = vim.fn.expand("~/.config/mcphub/servers.json"),
    })
    require("codecompanion").setup(opts)
  end,
}
