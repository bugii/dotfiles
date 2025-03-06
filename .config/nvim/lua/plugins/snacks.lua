return {
  "folke/snacks.nvim",
  lazy = false,
  opts = {
    scratch = {},
    image = {},
    gitbrowse = {},
    picker = {},
    statuscolumn = {},
    rename = {},
  },
  keys = {
    {
      "<leader>.",
      function() Snacks.scratch() end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>sf",
      function() Snacks.scratch.select() end,
      desc = "Select Scratch Buffer",
    },
    {
      "<C-p>",
      function() Snacks.picker.smart() end,
      desc = "Smart Find Files",
    },
    {
      "<C-_>",
      function() Snacks.picker.grep() end,
      desc = "Grep",
    },
    {
      "<leader>fb",
      function() Snacks.picker.buffers() end,
      desc = "Buffers",
    },
    {
      "<leader>fg",
      function() Snacks.picker.git_files() end,
      desc = "Find Git Files",
    },
    {
      "<leader>fr",
      function() Snacks.picker.recent() end,
      desc = "Recent",
    },

    -- git
    {
      "<leader>gb",
      function() Snacks.picker.git_branches() end,
      desc = "Git Branches",
    },
    {
      "<leader>gl",
      function() Snacks.picker.git_log() end,
      desc = "Git Log",
    },
    {
      "<leader>gf",
      function() Snacks.picker.git_log_file() end,
      desc = "Git Log File",
    },

    -- Find
    {
      "<leader>fib",
      function() Snacks.picker.lines() end,
      desc = "Buffer Lines",
    },
    {
      "<leader>fh",
      function() Snacks.picker.help() end,
      desc = "Help Pages",
    },
    {
      "<leader>fk",
      function() Snacks.picker.keymaps() end,
      desc = "Keymaps",
    },

    -- Lsp
    {
      "<leader>fd",
      function() Snacks.picker.diagnostics() end,
      desc = "Diagnostics",
    },
    {
      "gd",
      function() Snacks.picker.lsp_definitions() end,
      desc = "Goto Definition",
    },
    {
      "gD",
      function() Snacks.picker.lsp_declarations() end,
      desc = "Goto Declaration",
    },
    {
      "gr",
      function() Snacks.picker.lsp_references() end,
      nowait = true,
      desc = "References",
    },
    {
      "gi",
      function() Snacks.picker.lsp_implementations() end,
      desc = "Goto Implementation",
    },
    {
      "gt",
      function() Snacks.picker.lsp_type_definitions() end,
      desc = "Goto [T]ype Definition",
    },
  },
}
