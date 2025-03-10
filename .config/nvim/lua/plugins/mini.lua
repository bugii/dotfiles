return {
  "echasnovski/mini.nvim",
  version = "*",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-treesitter/nvim-treesitter-textobjects" },
  config = function()
    require("mini.icons").setup()
    local MiniBasics = require("mini.basics")
    require("mini.bracketed").setup()
    -- require("mini.pairs").setup()
    require("mini.surround").setup()
    require("mini.indentscope").setup()
    require("mini.statusline").setup()
    require("mini.diff").setup()
    local MiniSessions = require("mini.sessions")
    local MiniVisits = require("mini.visits")
    local MiniHipatterns = require("mini.hipatterns")
    local MiniAi = require("mini.ai")
    local MiniFiles = require("mini.files")
    local MiniExtra = require("mini.extra")
    local MiniPick = require("mini.pick")
    MiniFiles.setup({
      mappings = {
        close = "<ESC>",
      },
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesActionRename",
      callback = function(event) Snacks.rename.on_rename_file(event.data.from, event.data.to) end,
    })

    MiniExtra.setup()
    MiniPick.setup()
    MiniVisits.setup()
    MiniSessions.setup({
      autoread = true,
    })

    MiniBasics.setup({
      autocommands = {
        -- highlight on yank is done by glimmer plugin (and i dont really care about the terminal one that's part of the same config option 'basic')
        basic = false,
      },
    })

    MiniAi.setup({
      search_method = "cover_or_next",
      -- with a smaller value (default is 50...) many times it wont work (even if "cover" would be enough) properly
      n_lines = 500,
      custom_textobjects = {
        -- Function definition (needs treesitter queries with these captures)
        m = MiniAi.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
      },
    })

    MiniHipatterns.setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = MiniHipatterns.gen_highlighter.hex_color(),
      },
    })

    vim.keymap.set("n", "-", function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, { desc = "Open Files" })

    local sort_recent = MiniVisits.gen_sort.default({ recency_weight = 1 })
    vim.keymap.set(
      "n",
      "L",
      function() MiniVisits.iterate_paths("backward", nil, { sort = sort_recent }) end,
      { desc = "Go to last visited path" }
    )

    vim.keymap.set(
      "n",
      "H",
      function() MiniVisits.iterate_paths("forward", nil, { sort = sort_recent }) end,
      { desc = "Go to next visited path" }
    )
  end,
}
