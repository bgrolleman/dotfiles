return {
  "neovim/nvim-lspconfig",
  config = function()
    require("lspconfig").lua_ls.setup({})
    require("lspconfig").marksman.setup({
      root_dir = require("lspconfig.util").root_pattern(".marksman.toml", ".git", "*.md"),
    })
    require("lspconfig").bashls.setup({})
    require("lspconfig").yamlls.setup({})
  end,
}
