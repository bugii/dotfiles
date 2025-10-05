return {
  "dmtrKovalenko/fff.nvim",
  -- No need to lazy-load with lazy.nvim.
  -- This plugin initializes itself lazily.
  opts = {},
  lazy = false,
  keys = {
    {
      "<leader>ff", -- try it if you didn't it is a banger keybinding for a picker
      function() require("../fff-snacks-adapter").fff() end,
      desc = "FFFind files",
    },
  },
}
