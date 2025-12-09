return {
  "nvim-neotest/neotest",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest",
    "nsidorenco/neotest-vstest",
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require("neotest-vitest"),
        require("neotest-vstest"),
      },
    })

    vim.keymap.set("n", "<leader>tt", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run File" })
    vim.keymap.set("n", "<leader>tr", function() neotest.run.run() end, { desc = "Run Nearest" })
    vim.keymap.set("n", "<leader>ts", function() neotest.summary.toggle() end, { desc = "Toggle Summary" })
    vim.keymap.set(
      "n",
      "<leader>to",
      function() neotest.output.open({ enter = true, auto_close = true }) end,
      { desc = "Show Output" }
    )
    vim.keymap.set("n", "<leader>tO", function() neotest.output_panel.toggle() end, { desc = "Toggle Output Panel" })
    vim.keymap.set("n", "<leader>tS", function() neotest.run.stop() end, { desc = "Stop" })

    vim.keymap.set(
      "n",
      "<leader>td",
      function() neotest.run.run({ strategy = "dap", suite = false }) end,
      { desc = "Debug Nearest" }
    )
  end,
}
