return {
  "ravitemer/mcphub.nvim",
  build = "bundled_build.lua", -- Bundles `mcp-hub` binary along with the neovim plugin
  priority = 1000,
  config = function()
    require("mcphub").setup({
      -- Default configuration options
      auto_accept = true, -- Automatically accept file modifications
      auto_approve = true, -- Automatically approve MCP prompts
      auto_toggle_mcp_servers = true, -- Automatically toggle MCP servers based on context
      show_diffs = true, -- Show diff before applying changes
      use_bundled_binary = true, -- Use the bundled mcp-hub binary
      allow_file_write = true, -- Enable direct file writing from Copilot Chat
      allow_file_read = true, -- Enable reading files
      allow_command_execution = true, -- Enable running commands
      allow_filesystem_operations = true, -- Enable file system operations like mkdir, rm, etc.
      config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Path to the configuration file
      port = 37373, -- Port for the mcp-hub server,
      workspace = {
        enable = true, -- Enable workspace management
      },
    })
  end,
}
