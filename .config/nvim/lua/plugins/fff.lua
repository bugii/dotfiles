return {
  "dmtrKovalenko/fff.nvim",
  build = "cargo build --release",
  -- No need to lazy-load with lazy.nvim.
  -- This plugin initializes itself lazily.
  opts = {},
  lazy = false,
  keys = {
    {
      "<leader>ff", -- try it if you didn't it is a banger keybinding for a picker
      function() require("fff").find_files() end,
      desc = "FFFind files",
    },
  },
}
