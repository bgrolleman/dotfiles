-- Configuration Documentation https://github.com/jakewvincent/mkdnflow.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
return {
  "jakewvincent/mkdnflow.nvim",
  config = function()
    require("mkdnflow").setup({
      -- Config goes here; leave blank for defaults
      perspective = {
        priority = "first",
        root_tell = false,
      },
      new_file_template = {
        use_template = true,
        placeholders = {
          before = {
            title = "link_title",
            date = "os_date",
          },
          after = {},
        },
        template = "# {{ title }}",
      },
      links = {
        style = "markdown",
        name_is_source = false,
        conceal = false,
        context = 0,
        implicit_extension = nil,
        transform_implicit = false,
        transform_explicit = function(text)
          text = text:gsub(" ", "-")
          text = text:lower()
          return text
        end,
        create_on_follow_failure = true,
      },
    })
  end,
}
