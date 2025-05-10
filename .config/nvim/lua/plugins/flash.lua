return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<CR>",
      mode = { "n", "x", "o" },
      function()
        if not vim.tbl_contains({ vim.bo.filetype }, "vim") then
          require("flash").jump()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
        end
      end,
      desc = "Flash",
    },
    {
      "<leader><CR>",
      mode = { "n", "x", "o" },
      function() require("flash").treesitter() end,
      desc = "Flash Treesitter",
    },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  },
}
