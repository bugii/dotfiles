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
        rust = { "rustfmt" },
      },
      formatters = {
        csharpier = {
          command = "dotnet",
          args = { "csharpier", "format", "--write-stdout" },
          stdin = true,
          -- in order to respect the locally installed installation (using dotnet tools)
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

      format_after_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
    })

    vim.keymap.set(
      { "n", "v" },
      "<leader>f",
      function()
        conform.format({
          lsp_fallback = true,
          timeout_ms = 1000,
        })
      end,
      { desc = "Format file or range (in visual mode)" }
    )

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end,
}
