-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ADHD medication for the mouse
vim.keymap.set("n", "<LeftMouse>", "ma<LeftMouse>`a", { noremap = true })

-- -- disable Window keymaps
vim.keymap.del("n", "<C-h>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-l>")
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set("n", "<S-A-Left>", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<S-A-Down>", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<S-A-Up>", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<S-A-Right>", require("smart-splits").swap_buf_right)
-- --
-- Open the terminal in the current directory
vim.keymap.del("n", "<C-/>")
vim.keymap.set("n", "<C-/>", function()
  Snacks.terminal()
end, { desc = "Terminal (cwd)" })
