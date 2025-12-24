-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
vim.keymap.set("n", "<leader><CR>", "<cmd>so $MYVIMRC<CR>", { desc = "Reload VIMRC" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>x", "<cmd>x<CR>", { desc = "[X]it file" })

vim.keymap.set("i", "kj", "<Esc>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Resize windows
vim.keymap.set("n", "<M-h>", "5<C-w><", { desc = "Decrease window width" })
vim.keymap.set("n", "<M-l>", "5<C-w>>", { desc = "Increase window width" })
vim.keymap.set("n", "<M-k>", "2<C-w>+", { desc = "Increase window height" })
vim.keymap.set("n", "<M-j>", "2<C-w>-", { desc = "Decrease window height" })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
--

-- Quarto keymaps
vim.keymap.set("n", "<leader>qa", "<cmd>QuartoActivate<CR>", { desc = "[a]ctivate" })
vim.keymap.set("n", "<leader>qe", "<cmd>lua require'otter'.export<CR>", { desc = "[e]xport" })
vim.keymap.set("n", "<leader>qh", "<cmd>QuartoHelp<CR>", { desc = "[h]elp" })
vim.keymap.set("n", "<leader>qp", "<cmd>lua require'quarto'.quartoPreview()<CR>", { desc = "[p]review" })
vim.keymap.set("n", "<leader>qu", "<cmd>lua require'quarto'.quartoUpdatePreview()<CR>", { desc = "[u]pdate preview" })
vim.keymap.set("n", "<leader>qq", "<cmd>lua require'quarto'.quartoClosePreview()<CR>", { desc = "[q]uit preview" })
vim.keymap.set("n", "<leader>qq", "<cmd>lua require'quarto'.quartoClosePreview()<CR>", { desc = "[q]uit preview" })
