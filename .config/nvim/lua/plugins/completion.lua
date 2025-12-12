return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = {
    -- Optional: provides snippets for the snippet source
    "rafamadriz/friendly-snippets",
    "fang2hou/blink-copilot",
    "folke/lazydev.nvim",
  },
  -- Use a release tag to download pre-built binaries
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
      default = { "lsp", "path", "snippets", "buffer", "copilot", "lazydev" },
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
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },

    -- experimental signature help support
    -- i use noice for that
    signature = { enabled = false },

    completion = {
      keyword = { range = "full" },
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },

    cmdline = {
      keymap = {
        ["<C-l>"] = { "show", "hide" },
        ["<C-y>"] = { "accept" },
      },
      completion = { menu = { auto_show = true } },
    },
  },

  -- Allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" },
}
