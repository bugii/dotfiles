return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    opts = {
      transparent = true,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    enabled = false,
    opts = {
      flavour = "mocha",
      transparent_background = true,
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    opts = {
      transparent = true,
    },
  },
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    enabled = false,
    name = "rose-pine",
    opts = {
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    },
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    opts = {
      options = {
        -- transparent = true,
        styles = {
          keywords = "bold",
          types = "italic,bold",
          comments = "italic",
        },
      },
      palettes = {
        carbonfox = {
          bg1 = "black",
        },
      },
    },
    config = function(_, opts)
      require("nightfox").setup(opts)
      vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "background",
        callback = function()
          if vim.o.background == "light" then vim.cmd.colorscheme("dayfox") end
          if vim.o.background == "dark" then vim.cmd.colorscheme("carbonfox") end
        end,
      })
    end,
  },
  {
    "sample-usr/rakis.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    opts = {
      transparent = true,
      italic_comments = true,
    },
  },
  {
    "Everblush/nvim",
    name = "everblush",
    lazy = false,
    priority = 1000,
    enabled = false,
    opts = {
      transparent_background = true,
    },
  },
  {
    "uloco/bluloco.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    dependencies = { "rktjmp/lush.nvim" },
    opts = {
      transparent = true,
      italics = true,
    },
  },
  {
    "dasupradyumna/midnight.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    opts = {},
  },
  {
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      italics = true,
      flat_ui = false,
      -- on_colors = function(c)
      --   local light_bg = "#ffffff"
      --   local dark_bg = "#000000"
      --   c.background = vim.o.background == "light" and light_bg or dark_bg
      -- end,
      -- on_highlights = function(hl, c) hl.NormalFloat = { bg = c.background } end,
    },
    config = function(_, opts)
      require("jellybeans").setup(opts)
      if vim.o.background == "light" then
        -- vim.cmd.colorscheme("jellybeans-muted-light")
        vim.cmd.colorscheme("jellybeans-mono-light")
      else
        -- vim.cmd.colorscheme("jellybeans-muted")
        vim.cmd.colorscheme("jellybeans-mono")
      end
      -- require("jellybeans").setup(opts)
      -- vim.api.nvim_create_autocmd("OptionSet", {
      --   pattern = "background",
      --   callback = function()
      --     if vim.o.background == "light" then
      --       -- vim.cmd.colorscheme("jellybeans-muted-light")
      --       vim.cmd.colorscheme("jellybeans-light")
      --     else
      --       -- vim.cmd.colorscheme("jellybeans-muted")
      --       vim.cmd.colorscheme("jellybeans-mono")
      --     end
      --   end,
      -- })
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    opts = {},
  },
  {
    "S-Spektrum-M/odyssey.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    opts = {},
  },
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    opts = {
      background = { -- map the value of 'background' option to a theme
        dark = "zen",
        light = "pearl",
      },
      colors = {
        palette = {
          zen0 = "#000000",
          fujiWhite = "#FFFFFF",
        },
      },
    },
    config = function(_, opts)
      require("kanso").setup(opts)
      vim.cmd("colorscheme kanso")
    end,
  },
}
