--------------------------------------------------------------------------------
-- AVANTE.NVIM CONFIG
-- Mirrors codecompanion setup:
--   - Copilot (claude-sonnet-4.6) as default
--   - Ollama (deepseek-coder-v2:16b) as secondary
--   - MCPhub integration via custom_tools + system_prompt
--   - System prompt from ~/.config/ai/context/SYSTEM.md
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

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- NOTE: never set to "*" — always track latest commit
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-mini/mini.icons",
    "ravitemer/mcphub.nvim", -- already set up in codecompanion.lua
    {
      -- Image paste support
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = { insert_mode = true },
        },
      },
    },
    {
      -- Markdown rendering in avante sidebar
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },

  opts = {
    --------------------------------------------------------------------------
    -- PROVIDER
    -- Default: Copilot with claude-sonnet-4.6 (matches codecompanion default)
    -- Switch with :AvanteModels or the provider picker
    --------------------------------------------------------------------------
    provider = "copilot",

    providers = {
      copilot = {
        model = "claude-sonnet-4.6",
        extra_request_body = {
          max_tokens = 16384,
        },
      },

      -- Ollama: available as a secondary provider
      -- Switch to it with :AvanteModels and selecting "ollama"
      ollama = {
        model = "deepseek-coder-v2:16b",
        endpoint = "http://127.0.0.1:11434",
        -- Avante needs this to know Ollama doesn't require an API key
        is_env_set = function()
          return require("avante.providers.ollama").check_endpoint_alive
        end,
      },
    },

    --------------------------------------------------------------------------
    -- MODE
    -- "agentic": uses tools to read/write files automatically (Cursor-style)
    -- "legacy":  planning-only, no autonomous tool use
    --------------------------------------------------------------------------
    mode = "agentic",

    --------------------------------------------------------------------------
    -- BEHAVIOUR
    --------------------------------------------------------------------------
    behaviour = {
      auto_suggestions = false, -- inline ghost-text suggestions (slow with local models)
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false, -- require manual accept/reject
      support_paste_from_clipboard = true,
      enable_cursor_planning_mode = false,
    },

    --------------------------------------------------------------------------
    -- SYSTEM PROMPT
    -- Combines MCPhub active server context with your SYSTEM.md, exactly
    -- as codecompanion does with ctx.default_system_prompt + custom.
    --------------------------------------------------------------------------
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      local mcp_prompt = hub and hub:get_active_servers_prompt() or ""
      local custom = read_ai_file("context/SYSTEM.md") or ""

      local parts = {}
      if mcp_prompt ~= "" then
        table.insert(parts, mcp_prompt)
      end
      if custom ~= "" then
        table.insert(parts, custom)
      end

      return table.concat(parts, "\n\n")
    end,

    --------------------------------------------------------------------------
    -- MCP TOOLS
    -- Injects MCPhub's mcp_tool() so avante can call your MCP servers.
    -- Using a function here prevents requiring mcphub before it's loaded.
    --------------------------------------------------------------------------
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,

    --------------------------------------------------------------------------
    -- UI
    --------------------------------------------------------------------------
    windows = {
      position = "right",
      width = 45, -- percent of editor width (mirrors codecompanion's 0.45)
      wrap = true,
      sidebar_header = {
        enabled = true,
        align = "center",
        rounded = true,
      },
    },

    --------------------------------------------------------------------------
    -- DIFF
    -- Uses mini.diff provider to stay consistent with codecompanion inline diffs
    --------------------------------------------------------------------------
    diff = {
      autojump = true,
      list_opener = "copen",
    },

    --------------------------------------------------------------------------
    -- MAPPINGS
    -- Avante auto-sets keymaps inside its buffers. The <leader>a* global
    -- keymaps are set below in the keys table.
    -- Diff conflict mappings mirror common conventions.
    --------------------------------------------------------------------------
    mappings = {
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
    },
  },

  --------------------------------------------------------------------------
  -- GLOBAL KEYMAPS
  -- <leader>a prefix mirrors your codecompanion keymaps so both plugins
  -- live under the same which-key group.
  --
  --   <leader>ac  → CodeCompanion chat toggle  (codecompanion)
  --   <leader>aa  → Avante toggle sidebar      (avante)
  --   <leader>ae  → Avante edit selection      (avante, visual)
  --   <leader>ar  → Avante refresh             (avante)
  --   <leader>af  → Avante focus sidebar       (avante)
  --------------------------------------------------------------------------
  keys = {
    {
      "<leader>aa",
      function()
        require("avante.api").toggle()
      end,
      desc = "Avante: Toggle sidebar",
      mode = { "n", "v" },
    },
    {
      "<leader>ae",
      function()
        require("avante.api").edit()
      end,
      desc = "Avante: Edit selection",
      mode = "v",
    },
    {
      "<leader>ar",
      function()
        require("avante.api").refresh()
      end,
      desc = "Avante: Refresh",
    },
    {
      "<leader>af",
      function()
        require("avante.api").focus()
      end,
      desc = "Avante: Focus sidebar",
    },
  },
}
