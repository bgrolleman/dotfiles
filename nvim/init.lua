require("config.lazy")

vim.opt.compatible = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.MyCustomFoldExpr()"
vim.diagnostic.config({ virtual_text = true })

function _G.MyCustomFoldExpr()
  local line = vim.fn.getline(vim.v.lnum)
  if line:match("::$") then
    return "="
  end
  local ok, result = pcall(vim.treesitter.foldexpr)
  return ok and result or "0"
end
