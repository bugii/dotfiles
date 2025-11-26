return {
  "folke/snacks.nvim",
  lazy = false,
  ---@type snacks.Config
  opts = {
    scratch = {},
    image = {},
    gitbrowse = {},
    picker = {},
    input = {},
    quickfile = {},
  },
  keys = {
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    {
      "<leader>f.",
      function()
        Snacks.picker.scratch({
          win = {
            input = {
              keys = {
                ["<c-x>"] = { "scratch_delete", mode = { "n", "i" } },
                ["<c-n>"] = { "list_down", mode = { "n", "i" } },
              },
            },
          },
        })
      end,
      desc = "Select Scratch Buffer",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep({
          hidden = true,
          exclude = { "node_modules" },
        })
      end,
      desc = "Find Grep",
    },
    {
      "<leader>ff",
      function() Snacks.picker.files({ hidden = true, ignored = true, exclude = { "node_modules", ".local" } }) end,
      desc = "Files",
    },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>fq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>fR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    {
      "<leader>fw",
      function()
        Snacks.picker.grep_word({
          opts = {
            hidden = true,
          },
        })
      end,
      desc = "Find Word",
      mode = { "n", "x" },
    },
    { "<leader>fib", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>fc", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    { "<leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>fn", function() Snacks.picker.notifications() end, desc = "Notifications" },
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto [T]ype Definition" },
    { "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "[F]ind [S]ymbols" },
    { "<leader>fH", function() Snacks.picker.highlights() end, desc = "[F]ind [H]ighlights" },
    { "<leader>fp", function() Snacks.picker.lazy() end, desc = "[F]ind [P]lugin" },

    -- git browse, like gx (open url under cursor, but prefixed with leader)
    { "<leader>gx", function() Snacks.gitbrowse.open() end, desc = "Open gitbrowse for current file" },
  },
}
