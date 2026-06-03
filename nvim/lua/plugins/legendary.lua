return {
  "mrjones2014/legendary.nvim",
  priority = 10000,
  lazy = false,
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    telescope = { auto_register_which_key = false },
    keymaps = {
      { "<leader>cc", description = "Claude Code: Toggle terminal" },
      { "<leader>cf", description = "Claude Code: Focus terminal" },
    },
  },
  keys = {
    { "<leader><leader>", "<cmd>Legendary<CR>", desc = "Command Palette" },
    { "<C-p>", "<cmd>Legendary<CR>", desc = "Command Palette", mode = { "n", "i" } },
  },
}
