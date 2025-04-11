return {
  "folke/snacks.nvim",
  lazy = false,
  ---@type snacks.Config
  opts = {
    scratch = {},
    image = {},
    git = {},
    gitbrowse = {},
    picker = {},
    statuscolumn = {},
    rename = {},
    input = {},
    quickfile = {},
    dashboard = {
      sections = {
        { section = "terminal", cmd = "fortune -s | cowsay", hl = "header", padding = 1, indent = 8 },
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function() return Snacks.git.get_root() ~= nil end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    },
  },
  keys = {
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>sf", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep({
          hidden = true,
          -- ignored = true
        })
      end,
      desc = "Find Grep",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files({
          hidden = true,
          -- ignored = true,
        })
      end,
      desc = "Find Files",
    },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>fq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>fR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    { "<leader>fib", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>fc", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    { "<leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto [T]ype Definition" },
    { "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "[F]ind [S]ymbols" },
  },
}
