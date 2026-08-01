-- auto-dark-mode
return {
  {
    "f-person/auto-dark-mode.nvim",
    opts = {},
  },
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    ---@type solarized.config
    opts = {},
    config = function(_, opts)
      vim.o.termguicolors = true
      require("solarized").setup(opts)
      vim.cmd.colorscheme("solarized")
    end,
  },
}
