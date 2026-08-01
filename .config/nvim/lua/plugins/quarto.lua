-- This is a config that can be merged with your
-- existing LazyVim config.
--
-- It configures all plugins necessary for quarto-nvim,
-- such as adding its code completion source to the
-- completion engine nvim-cmp.
-- Thus, instead of having to change your configuration entirely,
-- this takes your existings config and adds on top where necessary.

return {

  -- this taps into vim.ui.select and vim.ui.input
  -- and in doing so currently breaks renaming in otter.nvim
  -- { "stevearc/dressing.nvim", enabled = false },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "nvim-treesitter/nvim-treesitter",
      "jmbuhr/otter.nvim",
    },

    opts = {
      lspFeatures = {
        enabled = true,
        languages = { "r", "python", "julia", "bash", "html", "lua" },
      },
      keymap = {
        hover = "K", -- default
        definition = "gd", -- default
        type_definition = "gD", -- default
        -- rename = "<leader>lR", -- default
        rename = "<leader>cr",
        -- format = "<leader>lf", -- default
        references = "gr", -- default
        document_symbols = "gS", -- default
      },
    },
    ft = "quarto",
    keys = {
      { "<localleader>qa", ":QuartoActivate<cr>", desc = "quarto activate" },
      { "<localleader>qp", ":lua require'quarto'.quartoPreview()<cr>", desc = "quarto preview" },
      { "<localleader>qq", ":lua require'quarto'.quartoClosePreview()<cr>", desc = "quarto close" },
      { "<localleader>qh", ":QuartoHelp ", desc = "quarto help" },
      { "<localleader>qe", ":lua require'otter'.export()<cr>", desc = "quarto export" },
      { "<localleader>qE", ":lua require'otter'.export(true)<cr>", desc = "quarto export overwrite" },
      { "<localleader>qrr", ":QuartoSendAbove<cr>", desc = "quarto run to cursor" },
      { "<localleader>qra", ":QuartoSendAll<cr>", desc = "quarto run all" },
      { "<leader>ctr", ":split term://R<cr>", desc = "terminal: R" },
      { "<leader>cti", ":split term://ipython<cr>", desc = "terminal: ipython" },
      { "<leader>ctp", ":split term://python<cr>", desc = "terminal: python" },
      { "<leader>ctj", ":split term://julia<cr>", desc = "terminal: julia" },
    },
  },
  { ------------------------------------------------------------------------
    "jmbuhr/otter.nvim",
    opts = {
      buffers = {
        set_filetype = true,
      },
    },
  },
  { ------------------------------------------------------------------------
    "hrsh7th/nvim-cmp",
    dependencies = { "jmbuhr/otter.nvim" },
    opts = function(_, opts)
      ---@param opts cmp.ConfigSchema
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "otter" } }))
    end,
  },
  { ------------------------------------------------------------------------
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {
          filetypes = { "python", "quarto" },
          settings = {
            python = {
              analysis = {
                extraPaths = { "." },
              },
            },
          },
        },
        r_language_server = {},
        -- julials = {},
        marksman = {
          -- also needs:
          -- $home/.config/marksman/config.toml :
          -- [core]
          -- markdown.file_extensions = ["md", "markdown", "qmd"]
          filetypes = { "markdown", "quarto" },
          root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
        },
      },
    },
  },
  { -- directly open ipynb files as quarto docuements
    -- and convert back behind the scenes
    "GCBallesteros/jupytext.nvim",
    opts = {
      custom_language_formatting = {
        python = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
        r = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
      },
    },
  },
}
