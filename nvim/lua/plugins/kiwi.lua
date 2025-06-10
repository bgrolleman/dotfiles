return {
  "serenevoid/kiwi.nvim",
  opts = {
    {
      name = "notes",
      path = "Notes",
    },
  },
  keys = {
    { "T", ':lua require("kiwi").todo.toggle()<cr>', desc = "Toggle Markdown Task" },
  },
  lazy = true,
}
