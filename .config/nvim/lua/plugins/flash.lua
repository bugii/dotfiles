return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    { "<CR>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    {
      "<leader><CR>",
      mode = { "n", "x", "o" },
      function() require("flash").treesitter() end,
      desc = "Flash Treesitter",
    },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  },
}
