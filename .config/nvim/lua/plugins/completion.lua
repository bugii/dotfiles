return {
  "saghen/blink.cmp",
  Event = "InsertEnter",
  dependencies = {
    -- optional: provides snippets for the snippet source
    "rafamadriz/friendly-snippets",
    "xzbdmw/colorful-menu.nvim",
    "fang2hou/blink-copilot",
    "moyiz/blink-emoji.nvim",
    "MahanRahmati/blink-nerdfont.nvim",
    "folke/lazydev.nvim",
    "brenoprata10/nvim-highlight-colors",
  },
  -- use a release tag to download pre-built binaries
  version = "v1.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
      ["<C-l>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-k>"] = { "snippet_forward", "fallback" },
      ["<C-j>"] = { "snippet_backward", "fallback" },
    },
    appearance = {
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer", "copilot", "emoji", "nerdfont", "lazydev" },
      per_filetype = {
        sql = { "snippets", "dadbod", "buffer" },
      },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          async = true,
          opts = {
            max_completions = 3,
          },
        },
        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15,
        },
        nerdfont = {
          module = "blink-nerdfont",
          name = "Nerd Fonts",
          score_offset = 15,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },

    -- experimental signature help support
    signature = { enabled = true },

    completion = {
      keyword = { range = "full" },
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      menu = {
        draw = {
          -- We don't need label_description now because label and label_description are already
          -- combined together in label by colorful-menu.nvim.
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx) return require("colorful-menu").blink_components_text(ctx) end,
              highlight = function(ctx) return require("colorful-menu").blink_components_highlight(ctx) end,
            },
            kind_icon = {
              text = function(ctx)
                -- default kind icon
                local icon = ctx.kind_icon
                -- if LSP source, check for color derived from documentation
                if ctx.item.source_name == "LSP" then
                  local item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                  if item.abbr ~= "" then icon = item.abbr end
                end
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                -- default highlight group
                local highlight = "BlinkCmpKind" .. ctx.kind
                -- if LSP source, check for color derived from documentation
                if ctx.item.source_name == "LSP" then
                  local item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                  if item.abbr ~= "" then highlight = item.abbr_hl_group end
                end
                return highlight
              end,
            },
          },
        },
      },
    },
    cmdline = {
      keymap = {
        ["<C-l>"] = { "show", "hide" },
        ["<C-y>"] = { "accept" },
      },
      completion = { menu = { auto_show = true } },
    },
  },

  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" },
}
