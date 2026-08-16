-- auto-dark-mode
return {
  {
    "f-person/auto-dark-mode.nvim",
    opts = {},
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      terminal_colors = true, -- I use kitty's solarized-osaka
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help" }, -- darker on sidebar-like windows ["dark", "qf", "vista_kind", "terminal", "packer"]
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized-osaka",
    },
  },
}
