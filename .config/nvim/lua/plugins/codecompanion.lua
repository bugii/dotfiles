return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "zbirenbaum/copilot.lua",
    "ravitemer/mcphub.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  event = "VeryLazy",
  opts = {
    display = {
      action_palette = {
        provider = "snacks",
      },
      chat = {
        auto_scroll = false,
      },
    },
  },
  keys = {
    {
      "<leader>at",
      function() vim.cmd("CodeCompanionChat Toggle") end,
      desc = "Toggle CodeCompanionChat",
    },
    {
      "<leader>an",
      function() vim.cmd("CodeCompanionChat") end,
      desc = "New CodeCompanionChat",
    },
    {
      "<leader>aa",
      function() vim.cmd("CodeCompanionActions") end,
      desc = "CodeCompanionActions",
    },
  },
}
