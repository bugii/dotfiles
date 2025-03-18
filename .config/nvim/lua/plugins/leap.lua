return {
  "ggandor/leap.nvim",
  config = function()
    vim.keymap.set({ "n", "x", "o" }, "<CR>", "<Plug>(leap-forward)")
    vim.keymap.set({ "n", "x", "o" }, "<leader><CR>", "<Plug>(leap-backward)")
  end,
}
