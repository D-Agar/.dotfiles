-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.ignorecase = false
vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.relativenumber = true

vim.g.maplocalleader = ";"
vim.g.lazyvim_python_lsp = "basedpyright"

-- Markdown Preview
vim.g.mkdp_echo_preview_url = 1
vim.g.mkdp_browser = "/usr/bin/google-chrome"

-- Point to the uv-managed tool environment for molten (pynvim)
vim.g.python3_host_prog = vim.fn.exepath("pynvim")

-- LaTeX options
vim.g.vimtex_view_method = "sioyek"
vim.g.vimtex_view_sioyek_exe = "$HOME//Applications/sioyek.appimage"
