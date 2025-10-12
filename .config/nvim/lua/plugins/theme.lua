return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      light_style = "day",
    },
    -- config = function(_, opts)
    --   require("tokyonight").setup(opts)
    --   vim.cmd.colorscheme("tokyonight")
    -- end,
  },
  {
    -- NOTE: since i have compile=true, run KanagawaCompile after a change to the config below!
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      compile = true,
      background = {
        dark = "dragon",
        light = "lotus",
      },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
    },
    -- config = function(_, opts)
    --   require("kanagawa").setup(opts)
    --   vim.cmd.colorscheme("kanagawa")
    -- end,
  },
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    name = "rose-pine",
    opts = {
      styles = {
        bold = true,
        italic = true,
        -- transparency = true,
      },
      -- highlight_groups = {
      --   Normal = { bg = "black" },
      --   StatusLine = { bg = "black" },
      -- },
      palette = {
        main = {
          base = "#000000",
          overlay = "#000000",
          surface = "#000000",
        },
        moon = {
          base = "#000000",
          overlay = "#000000",
          surface = "#000000",
        },
        dawn = {
          base = "#FFFFFF",
          overlay = "#FFFFFF",
          surface = "#FFFFFF",
        },
      },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd.colorscheme("rose-pine")
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        styles = {
          keywords = "bold",
          types = "italic,bold",
          comments = "italic",
        },
      },
    },
  },
  {
    "Everblush/nvim",
    name = "everblush",
    lazy = false,
    priority = 1000,
  },
  {
    "dasupradyumna/midnight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      italics = true,
      flat_ui = false,
    },
    -- config = function(_, opts)
    --   require("jellybeans").setup(opts)
    --   vim.cmd.colorscheme("jellybeans")
    -- end,
  },
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- background = { -- map the value of 'background' option to a theme
      --   dark = "zen",
      --   light = "pearl",
      -- },
      -- colors = {
      --   palette = {
      --     zen0 = "#000000",
      --     fujiWhite = "#FFFFFF",
      --   },
      -- },
    },
  },
}
