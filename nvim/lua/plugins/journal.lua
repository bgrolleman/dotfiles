return {
  "jakobkhansen/journal.nvim",
  config = function()
    require("journal").setup({
      filetype = "md", -- Filetype to use for new journal entries
      root = "~/Notes/Personal/journals", -- Root directory for journal entries
      date_format = "%Y-%m-%d", -- Date format for `:Journal <date-modifier>`
      autocomplete_date_modifier = "end", -- "always"|"never"|"end". Enable date modifier autocompletion

      -- Configuration for journal entries
      journal = {
        -- Default configuration for `:Journal <date-modifier>`
        format = "%Y_%m_%d",
        template = "# %A %B %d %Y\n",
        frequency = { day = 1 },

        -- Nested configurations for `:Journal <type> <type> ... <date-modifier>`
        entries = {
          day = {
            format = "%Y_%m_%d", -- Format of the journal entry in the filesystem.
            template = "# %A %B %d %Y\n", -- Optional. Template used when creating a new journal entry
            frequency = { day = 1 }, -- Optional. The frequency of the journal entry. Used for `:Journal next`, `:Journal -2` etc
          },
        },
      },
    })
  end,
}
