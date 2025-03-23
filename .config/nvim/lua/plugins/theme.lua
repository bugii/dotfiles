return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("tokyonight").setup()
      -- vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        transparent_background = true, -- disables setting the background color.
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          noice = true,
          neotest = true,
          mason = true,
          -- which_key = true,
          -- leap = true,
          dap = true,
          dap_ui = true,
          -- notify = true,
          -- telescope = {
          -- 	enabled = true,
          -- },
          native_lsp = {
            enabled = true,
          },
          -- indent_blankline = {
          -- 	enabled = true,
          -- },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
        -- color_overrides = {
        -- 	mocha = {
        -- 		base = "#000000",
        -- 		mantle = "#000000",
        -- 		crust = "#000000",
        -- 	},
        -- },
        -- highlight_overrides = {
        -- 	mocha = function(C)
        -- 		return {
        -- 			TabLineSel = { bg = C.pink },
        -- 			CmpBorder = { fg = C.surface2 },
        -- 			Pmenu = { bg = C.none },
        -- 		}
        -- 	end,
        -- },
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
      })
    end,
  },
  {
    "rose-pine/neovim",
    priority = 1000,
    name = "rose-pine",
  },
  { "EdenEast/nightfox.nvim", priority = 1000 },
  {
    "sample-usr/rakis.nvim",
    priority = 1000,
    opts = {},
    config = function()
      require("rakis").setup({
        theme = {
          variant = "default",
          extensions = { mini = true },
          overrides = function(colors)
            return {
              MiniStatuslineModeNormal = { fg = colors.bg_solid, bg = colors.orange02, bold = true },
            }
          end,
        },
      })
      -- vim.cmd([[colorscheme rakis]])
    end,
  },
}
