-- Autocmds are automatically loaded on the VeryLazy event
-- By this point noice.nvim has already replaced vim.notify

-- Log warnings and errors to file for debugging
local log_path = vim.fn.stdpath("log") .. "/nvim_errors.log"
local _notify = vim.notify
vim.notify = function(msg, level, opts)
  if level and level >= vim.log.levels.WARN then
    local f = io.open(log_path, "a")
    if f then
      f:write(string.format(
        "[%s] %s: %s\n",
        os.date("%Y-%m-%d %H:%M:%S"),
        level == vim.log.levels.ERROR and "ERROR" or "WARN",
        tostring(msg)
      ))
      f:close()
    end
  end
  return _notify(msg, level, opts)
end
