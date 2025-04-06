return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        python = { "autopep8" },
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        graphql = { "prettierd" },
        cs = { "csharpier" },
        sql = { "sqlfluff" },
        rust = { "rustfmt" },
      },
      formatters = {
        sqlfluff = {
          command = "sqlfluff",
          args = { "fix", "-" },
          stdin = true,
          cwd = require("conform.util").root_file({
            ".sqlfluff",
          }),
          require_cwd = false,
        },
        csharpier = {
          command = "dotnet",
          args = { "csharpier", "--write-stdout" },
          stdin = true,
          -- in order to respect the locally intalled installation (using dotnet tools)
          cwd = require("conform.util").root_file(".config"),
        },
      },

      format_after_save = {
        lsp_fallback = true,
      },
    })

    vim.keymap.set(
      { "n", "v" },
      "<leader>f",
      function()
        conform.format({
          lsp_fallback = true,
          timeout_ms = 500,
        })
      end,
      { desc = "Format file or range (in visual mode)" }
    )
  end,
}
