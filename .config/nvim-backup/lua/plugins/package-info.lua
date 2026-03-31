return {
  "vuki656/package-info.nvim",
  ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  config = function()
    require("package-info").setup()

    vim.keymap.set({ "n" }, "<leader>nt", require("package-info").toggle, { silent = true, noremap = true })
    vim.keymap.set({ "n" }, "<leader>nu", require("package-info").update, { silent = true, noremap = true })
    vim.keymap.set({ "n" }, "<leader>nd", require("package-info").delete, { silent = true, noremap = true })
    vim.keymap.set({ "n" }, "<leader>ni", require("package-info").install, { silent = true, noremap = true })
    vim.keymap.set({ "n" }, "<leader>np", require("package-info").change_version, { silent = true, noremap = true })
  end,
}
