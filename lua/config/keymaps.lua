-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Don't yank when deleting
vim.keymap.set("n", "x", '"_x', { remap = false })
vim.keymap.set("n", "d", '"_d', { remap = false })
vim.keymap.set("n", "D", '"_D', { remap = false })
vim.keymap.set("v", "d", '"_d', { remap = false })

-- don't yank when pasting
vim.keymap.set("x", "p", "P")

-- ADHD medication for the mouse
vim.keymap.set("n", "<LeftMouse>", "ma<LeftMouse>`a", { noremap = true })

-- disable Window keymaps
vim.keymap.del("n", "<C-h>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-l>")
vim.keymap.set("n", "<C-h>", [[<cmd>lua require'tmux'.move_left()<cr>]], { remap = false })
vim.keymap.set("n", "<C-j>", [[<cmd>lua require'tmux'.move_bottom()<cr>]], { remap = false })
vim.keymap.set("n", "<C-k>", [[<cmd>lua require'tmux'.move_top()<cr>]], { remap = false })
vim.keymap.set("n", "<C-l>", [[<cmd>lua require'tmux'.move_right()<cr>]], { remap = false })
