return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    local function lint_with_lsp_root_as_cwd()
      --NOTE: vtsls / roslyn are the only two lsps i currently need to figure out the root path to lint at. could be made nicer for sure.
      local vtsls = vim.lsp.get_clients({ bufnr = 0, name = "vtsls" })[1]
      local tsgo = vim.lsp.get_clients({ bufnr = 0, name = "tsgo" })[1]
      local roslyn = vim.lsp.get_clients({ bufnr = 0, name = "roslyn" })[1]
      local client = vtsls or tsgo or roslyn or {}
      -- NOTE: this is actually a very nice solution taken from https://github.com/mfussenegger/nvim-lint/issues/482#issuecomment-1999185606 to make linting work when project root is not opened in nvim
      lint.try_lint(nil, { cwd = client.root_dir })
    end

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function() lint_with_lsp_root_as_cwd() end,
    })

    vim.keymap.set(
      "n",
      "<leader>l",
      function() lint_with_lsp_root_as_cwd() end,
      { desc = "Trigger linting for current file" }
    )
  end,
}
