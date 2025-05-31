return {
  "nvim-neorg/neorg",
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.ui.calendar"] = {},
        ["core.completion"] = { config = { engine = { module_name = "external.lsp-completion" }, name = "[Norg]" } },
        ["core.esupports.metagen"] = { config = { type = "auto", update_date = true } },
        ["core.qol.toc"] = {},
        ["core.qol.todo_items"] = {},
        ["core.looking-glass"] = {},
        ["core.presenter"] = { config = { zen_mode = "zen-mode" } },
        ["core.export"] = {},
        ["core.export.markdown"] = { config = { extensions = "all" } },
        ["core.summary"] = {},
        ["core.tangle"] = { config = { report_on_empty = false } },
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/Notes.neorg",
            },
            default_workspace = "notes",
          },
        },
        ["external.interim-ls"] = {
          config = {
            -- default config shown
            completion_provider = {
              -- Enable or disable the completion provider
              enable = true,

              -- Show file contents as documentation when you complete a file name
              documentation = true,

              -- Try to complete categories provided by Neorg Query. Requires `benlubas/neorg-query`
              categories = false,

              -- suggest heading completions from the given file for `{@x|}` where `|` is your cursor
              -- and `x` is an alphanumeric character. `{@name}` expands to `[name]{:$/people:# name}`
              people = {
                enable = false,

                -- path to the file you're like to use with the `{@x` syntax, relative to the
                -- workspace root, without the `.norg` at the end.
                -- ie. `folder/people` results in searching `$/folder/people.norg` for headings.
                -- Note that this will change with your workspace, so it fails silently if the file
                -- doesn't exist
                path = "people",
              },
            },
          },
        },
        ["core.keybinds"] = {
          config = {
            default_keybinds = true,
            neorg_leader = "<Leader>n", -- Change this to whatever you want
          },
        },
      },
    })
  end,
}
