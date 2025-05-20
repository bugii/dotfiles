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
        python = { "black" },
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
          args = { "csharpier", "format", "--write-stdout" },
          stdin = true,
          -- in order to respect the locally intalled installation (using dotnet tools)
          cwd = require("conform.util").root_file(".config"),
        },
        black = {
          command = require("conform.util").find_executable({ ".venv/bin/black" }, "black"),
          args = {
            "--stdin-filename",
            "$FILENAME",
            "--quiet",
            "-",
          },
          cwd = require("conform.util").root_file({
            -- https://black.readthedocs.io/en/stable/usage_and_configuration/the_basics.html#configuration-via-a-file
            "pyproject.toml",
          }),
        },
      },

      format_after_save = {
        lsp_fallback = false,
      },
    })

    vim.keymap.set(
      { "n", "v" },
      "<leader>f",
      function()
        conform.format({
          lsp_fallback = false,
          timeout_ms = 1000,
        })
      end,
      { desc = "Format file or range (in visual mode)" }
    )
  end,
}
