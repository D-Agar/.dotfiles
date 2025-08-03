local ui_opts = require("config.lazy-ui")

require("lazy").setup({
	{ import = "plugins" },
}, ui_opts)
