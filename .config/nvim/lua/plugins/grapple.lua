return {
  "cbochs/grapple.nvim",
  enabled = false,
  config = function()
    vim.keymap.set("n", "<leader>m", require("grapple").toggle)
    vim.keymap.set("n", "<leader>M", require("grapple").toggle_tags)

    vim.keymap.set("n", "H", function() require("grapple").cycle_tags("previous") end)
    vim.keymap.set("n", "L", function() require("grapple").cycle_tags("next") end)

    require("grapple").setup({
      icons = false,
    })
  end,
}
