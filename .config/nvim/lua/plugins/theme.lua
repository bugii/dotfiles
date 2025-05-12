return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      transparent = true,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha",
      transparent_background = true,
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      transparent = true,
    },
  },
  {
    "rose-pine/neovim",
    lazy = true,
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
    lazy = true,
    -- priority = 1000,
    -- config = function(_, opts)
    --   require("nightfox").setup(opts)
    --   vim.api.nvim_create_autocmd("OptionSet", {
    --     pattern = "background",
    --     callback = function()
    --       if vim.o.background == "light" then vim.cmd.colorscheme("dayfox") end
    --       if vim.o.background == "dark" then vim.cmd.colorscheme("carbonfox") end
    --     end,
    --   })
    -- end,
    -- lazy = true,
  },
  {
    "sample-usr/rakis.nvim",
    lazy = true,
    opts = {
      transparent = true,
      italic_comments = true,
    },
  },
  {
    "Everblush/nvim",
    name = "everblush",
    lazy = true,
    opts = {
      transparent_background = true,
    },
  },
  {
    "uloco/bluloco.nvim",
    lazy = true,
    dependencies = { "rktjmp/lush.nvim" },
    opts = {
      transparent = true,
      italics = true,
    },
  },
  {
    "dasupradyumna/midnight.nvim",
    lazy = true,
    opts = {},
  },
  {
    "wtfox/jellybeans.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      transparent = false,
      italics = true,
      flat_ui = false,
      on_colors = function(c)
        local light_bg = "#ffffff"
        local dark_bg = "#000000"
        c.background = vim.o.background == "light" and light_bg or dark_bg
      end,
      on_highlights = function(hl, c) hl.NormalFloat = { bg = c.background } end,
    },
    config = function(_, opts)
      require("jellybeans").setup(opts)
      vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "background",
        callback = function()
          if vim.o.background == "light" then
            -- vim.cmd.colorscheme("jellybeans-muted-light")
            vim.cmd.colorscheme("jellybeans-light")
          else
            -- vim.cmd.colorscheme("jellybeans-muted")
            vim.cmd.colorscheme("jellybeans-mono")
          end
        end,
      })
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    opts = {},
  },
  {
    "S-Spektrum-M/odyssey.nvim",
    lazy = true,
    opts = {},
  },
  {
    "webhooked/kanso.nvim",
    lazy = true,
    -- priority = 1000,
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
