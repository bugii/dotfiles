return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "VeryLazy",
  opts = {
    suggestion = {
      enabled = false,
    },
    panel = { enabled = false },
    filetypes = {
      yaml = true,
      markdown = true,
      help = true,
      ["."] = false,
    },
  },
}
