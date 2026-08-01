-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

map("i", "kj", "<Esc>")
map("i", "jk", "<Esc>")
map("t", "<Esc>", [[<C-\><C-n>]])
