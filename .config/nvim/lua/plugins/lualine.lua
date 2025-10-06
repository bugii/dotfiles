return {
  "nvim-lualine/lualine.nvim",
  -- mini.icons for the icons
  enabled = false,
  dependencies = { "echasnovski/mini.nvim", "bwpge/lualine-pretty-path" },
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = "",
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = { "snacks_dashboard" },
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = true,
      globalstatus = true,
      refresh = {
        statusline = 100,
        tabline = 100,
        winbar = 100,
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        "diff",
        "diagnostics",
        {
          require("noice").api.status.mode.get,
          cond = require("noice").api.status.mode.has,
          color = { fg = "#ff9e64" },
        },
        {
          require("noice").api.status.search.get,
          cond = require("noice").api.status.search.has,
          color = { fg = "#ff9e64" },
        },
      },
      lualine_c = {
        "pretty_path",
      },
      lualine_x = {
        {
          function() return require("nvim-navic").get_location() end,
          cond = function() return require("nvim-navic").is_available() end,
        },
        "encoding",
        "fileformat",
        "filetype",
      },
      -- lualine_y = {
      --   "grapple",
      -- },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  },
}
