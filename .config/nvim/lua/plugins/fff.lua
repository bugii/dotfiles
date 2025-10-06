return {
  {
    "dmtrKovalenko/fff.nvim",
    -- No need to lazy-load with lazy.nvim.
    -- This plugin initializes itself lazily.
    opts = {},
    lazy = false,
  },
  {
    "madmaxieee/fff-snacks.nvim",
    dependencies = {
      "dmtrKovalenko/fff.nvim",
      "folke/snacks.nvim",
    },
    cmd = "FFFSnacks",
    keys = {
      {
        "<leader>ff",
        "<cmd> FFFSnacks <cr>",
        desc = "FFF",
      },
    },
    config = true,
  },
}
