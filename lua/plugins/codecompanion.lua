return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
    "ravitemer/mcphub.nvim",
  },
  config = true,
  event = "VeryLazy", -- Load when needed
  cmd = {
    "CodeCompanion",
    "CodeCompanionChat",
    "CodeCompanionCmd",
    "CodeCompanionActions",
  },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat", mode = { "n", "v" } },
    { "<leader>ap", "<cmd>CodeCompanionActions<cr>", desc = "Prompt Actions", mode = { "n", "v" } },
  },
  enabled = true,
  opts = {
    default_context = { "buffers" },
    default_actions = { "files", "buffers" },
    display = {
      diff = {
        provider = "mini_diff", -- <-- This enables mini.diff
      },
    },
    strategies = {
      chat = {
        tools = {
          opts = {
            default_tools = {
              "neovim",
              --              "files",
              --              "grep_search",
            },
          },
        },
      },
    },
    adapters = {
      copilot = function()
        local adapters = require("codecompanion.adapters")
        return adapters.extend("copilot", {
          schema = {
            model = {
              -- default = "claude-3.7-sonnet",
              default = "gpt-4.1",
            },
          },
        })
      end,
      tavily = function()
        return require("codecompanion.adapters").extend("tavily", {
          env = {
            api_key = "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",
          },
        })
      end,
    },
    tools = {},
    contexts = {
      files = {
        always_include_current_buffer = true,
        enable_buffer_match_scoring = true,
        include_current_buffer = true,
      },
      buffers = {
        enable = true,
        include_current_buffer = true,
      },
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          show_result_in_chat = true, -- Show the MCP result in chat
          make_vars = true, -- Show MCP server resources as #variables
          make_slash_commands = true, -- Show MCP prompts as /slash commands
          auto_approve = true, -- Automatically approve MCP prompts
          auto_toggle_mcp_servers = true, -- Automatically toggle MCP servers based on context
        },
      },
    },
    system_prompt = [[
       When you encounter an error modifying a file because it has changed since you last read it:
       1. Inform the user about the issue
       2. Automatically re-read the current content of the file using read_file
       3. Adjust your changes to work with the updated content
       4. Try applying the modification again
       
       Only give up if the second attempt fails or if you can't reconcile the changes.
       This approach ensures you're working with the most current version of files.

      -- When you need to delete a file:
      -- 1. Ask for explicit confirmation before deleting the file
      -- 2. Use run_command with "rm <filename>" to delete the file when confirmed
      -- 3. Confirm to the user that the file has been deleted
      -- 4. If this is part of a file rename operation, make sure to create the new file with the content from the original before deleting the original
      --
      Always follow these safeguards when performing operations:
      1. Describe what you're about to do before using any tool
      2. When creating a file, show the content you're planning to create before using create_file
      3. Wait for explicit approval before proceeding with any operation that modifies the filesystem
      4. After receiving approval, then execute the operation and confirm when it's completed
      5. When making changes to code, ask for explicit confirmation before modifying files
      6. For code changes, clearly explain what will be changed and why

      My default Azure username is "kbuley@catmktg.com"
      When I ask about resources in a subscription and I don't specify a resource group, I want you to automatically check all resource groups in the subscription automatically without prompting for approval

     ]],
  },
}
