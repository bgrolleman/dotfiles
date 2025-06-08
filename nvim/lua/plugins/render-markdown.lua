return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  ft = { "markdown" },
  config = function()
    require("render-markdown").setup({
      completions = { lsp = { enabled = true } },
      preset = "lazy",
      heading = {
        enabled = true,
      },
      checkbox = {
        enabled = true,
      },
      wikilinks = {
        enabled = true,
      },
    })
  end,
}
