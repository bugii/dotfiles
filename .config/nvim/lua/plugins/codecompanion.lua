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
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          show_result_in_chat = true, -- Show the mcp tool result in the chat buffer
          make_vars = true, -- make chat #variables from MCP server resources
          make_slash_commands = true, -- make /slash_commands from MCP server prompts
        },
      },
    },
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
