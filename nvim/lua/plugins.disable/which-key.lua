return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      { "<leader>N", group = "Neorg" },
      { "<leader>Nt", ":Neorg journal today<CR>", desc = "Today" },
    },
  },
}
--{ "<leader>c", group = "ChatGPT" },
--{ "<leader>cc", ":ChatGPT<CR>", desc = "ChatGPT" },
--{ "<leader>ce", ":ChatGPTEditWithInstructions<CR>", desc = "ChatGPT Edit Selection with Instructions" },
