return {
  "folke/noice.nvim",
  event = "VeryLazy",
  enabled = true,
  dependencies = {
    "MunifTanjim/nui.nvim",
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      signature = {
        enabled = false,
      },
      hover = {
        silent = true,
      },
      progress = {
        -- NOTE: does not work with roslyn for some reason
        enabled = false,
      },
    },
    cmdline = {
      enabled = false,
    },
    messages = {
      enabled = false,
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      long_message_to_split = true, -- long messages will be sent to a split
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },
}
