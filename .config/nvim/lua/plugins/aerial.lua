return {
  "stevearc/aerial.nvim",
  -- The 'init' function runs before the plugin loads
  init = function()
    -- This tells Neovim: "When you see a Quarto file, use the Markdown parser"
    -- This allows Aerial to find headers like #, ##, etc.
    vim.treesitter.language.register("markdown", "quarto")
  end,
  opts = {
    -- Optional: Ensure Treesitter is the preferred backend for Quarto
    backends = { "treesitter", "lsp", "markdown", "man" },
    show_guides = true,
    layout = {
      max_width = { 40, 0.2 },
      min_width = 20,
    },
  },
}
