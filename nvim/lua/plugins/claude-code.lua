return {
  "greggh/claude-code.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("claude-code").setup({
      window = {
        position = "vertical",
        split_ratio = 0.4,
      },
    })
  end,
  keys = {
    { "<leader>cc", "<cmd>ClaudeCode<CR>", desc = "Claude Code: Toggle" },
    { "<leader>cf", "<cmd>ClaudeCodeFocus<CR>", desc = "Claude Code: Focus" },
  },
}
