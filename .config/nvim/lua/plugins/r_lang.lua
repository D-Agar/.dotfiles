return {
	{
		"R-nvim/R.nvim",
		-- R.nvim is still young and we may make some breaking changes from time
		-- to time (but also bug fixes all the time). If configuration stability
		-- is a high priority for you, pin to the latest minor version, but unpin
		-- it and try the latest version before reporting an issue:
		-- version = "~0.1.0"
		config = function()
			-- Create a table with the options to be passed to setup()
			---@type RConfigUserOpts
			local opts = {
				hook = {
					on_filetype = function()
						vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
						vim.api.nvim_buf_set_keymap(0, "n", "<Shift><Enter>", "<Plug>RDSendChunk", {})
						vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
					end,
				},
				-- R_app = "/home/daniel/.local/bin/radian",
				-- R_cmd = "R",
				-- R_hl_term = 0,
				R_args = {},
				R_bracketed_paste = 1,
				-- R_args = { "--quiet", "--no-save" },
				min_editor_width = 18,
				external_term = "", -- ""/"kitty" to use neovim's builtin terminal emulator
				rconsole_width = 57,
				objbr_place = "console, above",
				-- rconsole_height = 15,
				setwd = "nvim", -- I can open the project directory in neovim, may help with renv
				objbr_mappings = { -- Object browser keymap
					c = "class", -- Call R functions
					["<leader>h"] = "head({object}, n = 5)", -- Use {object} notation to write arbitrary R code.
					v = function()
						-- Run lua functions
						require("r.browser").toggle_view()
					end,
				},
			}
			-- Check if the environment variable "R_AUTO_START" exists.
			-- If using fish shell, you could put in your config.fish:
			-- alias r "R_AUTO_START=true nvim"
			if vim.env.R_AUTO_START == "true" then
				opts.auto_start = "on startup"
				opts.objbr_auto_start = true
			end
			require("r").setup(opts)
		end,
	},
}
