return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "zbirenbaum/copilot.lua",
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  opts = {
    ignore_warnings = true,
    display = {
      action_palette = {
        provider = "snacks",
      },
      chat = {
        auto_scroll = false,
      },
    },
    interactions = {
      chat = {
        slash_commands = {
          ["file"] = {
            opts = {
              provider = "snacks",
            },
          },
          ["buffer"] = {
            opts = {
              provider = "snacks",
            },
          },
        },
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
