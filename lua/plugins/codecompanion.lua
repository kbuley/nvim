return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
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
  opts = {
    default_context = { "files" },
    adapters = {
      copilot = function()
        local adapters = require("codecompanion.adapters")
        return adapters.extend("copilot", {
          schema = {
            model = {
              default = "claude-3.7-sonnet",
            },
          },
        })
      end,
    },
    contexts = {
      files = {
        always_include_current_buffer = true,
        enable_buffer_match_scoring = true,
      },
    },
  },
}
