return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
	init = function()
		-- VimTeX configuration goes here, e.g.
		vim.g.vimtex_view_method = "sioyek"
		vim.g.vimtex_view_sioyek_exe = "sioyek"
		vim.g.vimtex_syntax_enabled = false -- let Treesitter handle it
		vim.g.maplocalleader = " "
		vim.g.vimtex_imaps_enabled = 1
	end,
}
