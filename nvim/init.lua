print("advent of neovim")

require("config.lazy")
--
-- local o = vim.opt
-- o.compatible = false
-- o.number = true
-- o.cmdheight = 2
-- o.expandtab = true
-- o.smarttab = true
-- o.shiftwidth = 4
-- o.tabstop = 4
-- o.ai = true
-- o.si = true
--
-- nvim_create_user_command("InsertTodayHeader", ':pu=strftime("# %a %d %b %Y")', {})
--
vim.opt.compatible = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.MyCustomFoldExpr()"
vim.diagnostic.config({ virtual_text = true })

function _G.MyCustomFoldExpr()
  local line = vim.fn.getline(vim.v.lnum)
  if line:match("::$") then
    return "=" -- keep the same fold level as the previous line
  end
  return vim.treesitter.foldexpr()
end
