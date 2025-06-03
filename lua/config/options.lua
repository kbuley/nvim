-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- disable providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Disable LSP logs
vim.lsp.set_log_level("off")

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- backspace
vim.opt.backspace = "indent,eol,start"
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Enable this option to avoid conflicts with Prettier.
vim.g.lazyvim_prettier_needs_config = true

vim.filetype.add({
  extension = {
    sls = "sls",
  },
})

-- Dashboard command
vim.api.nvim_create_user_command("Dashboard", function()
  Snacks.dashboard.open()
end, {})
