return {
  "lucidph3nx/nvim-sops",
  event = { "BufEnter" },
  opts = {
    debug = true,
    defaults = {
      -- Faking awsProfile since the variable has spaces
      awsProfile = "Fake",
    },
  },
}
