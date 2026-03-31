return {
  "gbprod/yanky.nvim",
  opts = {},
  dependencies = {
    "folke/snacks.nvim",
  },
  keys = {
    {
      "p",
      "<Plug>(YankyPutAfter)",
      mode = { "n", "x" },
    },
    {
      "<leader>fy",
      function() Snacks.picker.yanky() end,
      mode = { "n", "x" },
      desc = "[F]ind [Y]ank History",
    },
    {
      "P",
      "<Plug>(YankyPutBefore)",
      mode = { "n", "x" },
    },
    {
      "gp",
      "<Plug>(YankyGPutAfter)",
      mode = { "n", "x" },
    },
    {
      "gP",
      "<Plug>(YankyGPutBefore)",
      mode = { "n", "x" },
    },
    {
      "<C-p>",
      "<Plug>(YankyPreviousEntry)",
      mode = { "n" },
    },
    {
      "<C-n>",
      "<Plug>(YankyNextEntry)",
      mode = { "n" },
    },
  },
}
