return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    -- opts = {},
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
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
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    -- opts = {},
  },
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = true,
    -- opts = {},
  },
  {
    "rose-pine/neovim",
    lazy = true,
    name = "rose-pine",
  },
  { "EdenEast/nightfox.nvim", lazy = true },
  {
    "sample-usr/rakis.nvim",
    lazy = true,
    -- opts = {},
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
    end,
  },
  {
    "embark-theme/vim",
    lazy = true,
    -- opts = {},
  },
  {
    "Everblush/nvim",
    name = "everblush",
    -- priority = 1000,
    -- config = function() vim.cmd("colorscheme everblush") end,
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = true,
  },
  {
    "uloco/bluloco.nvim",
    lazy = true,
    -- priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    -- config = function() vim.cmd("colorscheme bluloco-dark") end,
  },
  {
    "yorumicolors/yorumi.nvim",
    -- lazy = true,
    priority = 1000,
    opts = {},
    config = function() vim.cmd("colorscheme yorumi") end,
  },
  {
    "dasupradyumna/midnight.nvim",
    lazy = true,
    -- priority = 1000,
    -- opts = {},
    -- config = function() vim.cmd("colorscheme midnight") end,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
    -- opts = {},
  },
  {
    "wtfox/jellybeans.nvim",
    -- priority = 1000,
    lazy = true,
    -- opts = {},
    -- config = function() vim.cmd([[colorscheme jellybeans]]) end,
  },
  {
    "tiagovla/tokyodark.nvim",
    lazy = true,
    -- priority = 1000,
    -- opts = {},
    -- config = function() vim.cmd("colorscheme tokyodark") end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    -- opts = {}
  },
  {
    "S-Spektrum-M/odyssey.nvim",
    lazy = true,
    -- opts = {}
  },
}
