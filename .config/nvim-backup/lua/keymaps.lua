vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Remove highlight after search" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostic: open float" })

-- NOTE: helpful when debugging treesitter captures, calling this on a treesitter node will print out all the metadata etc.
vim.keymap.set("n", "<leader><leader>tsn", function()
  local winnr = 0
  local bufnr = vim.api.nvim_win_get_buf(winnr)
  local cursor = vim.api.nvim_win_get_cursor(winnr)

  local data = vim.treesitter.get_captures_at_pos(bufnr, cursor[1] - 1, cursor[2])

  local captures = {}

  for _, capture in ipairs(data) do
    table.insert(captures, capture)
  end

  print(vim.inspect(captures))
end, { desc = "Print treesitter node" })
