return {
  "echasnovski/mini.nvim",
  version = "*",
  lazy = false,
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-treesitter/nvim-treesitter-textobjects" },
  config = function()
    local MiniIcons = require("mini.icons")
    require("mini.basics").setup()
    require("mini.bracketed").setup()
    require("mini.surround").setup()
    require("mini.indentscope").setup()
    require("mini.diff").setup()
    require("mini.sessions").setup()
    local MiniHipatterns = require("mini.hipatterns")
    local MiniAi = require("mini.ai")
    local MiniFiles = require("mini.files")
    require("mini.extra").setup()
    local MiniBufremove = require("mini.bufremove")
    local MiniStatusline = require("mini.statusline")

    vim.keymap.set("n", "[t", ":tabprevious<CR>", { silent = true, desc = "Previous tab" })
    vim.keymap.set("n", "]t", ":tabnext<CR>", { silent = true, desc = "Next tab" })

    MiniIcons.setup()
    MiniIcons.mock_nvim_web_devicons()

    MiniFiles.setup({
      mappings = {
        close = "<ESC>",
      },
    })

    MiniAi.setup({
      search_method = "cover_or_next",
      -- with a smaller value (default is 50...) many times it wont work (even if "cover" would be enough) properly
      -- n_lines = 500,
      custom_textobjects = {
        -- Function definition (needs treesitter queries with these captures)
        m = MiniAi.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
        c = MiniAi.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
      },
    })

    MiniHipatterns.setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
      },
    })

    vim.keymap.set("n", "-", function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, { desc = "Open Files" })
    MiniBufremove.setup()
    vim.keymap.set("n", "<C-x>", function() MiniBufremove.delete() end, { desc = "Open Files" })

    MiniStatusline.setup({
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diff = MiniStatusline.section_diff({ trunc_width = 75 })
          local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
            "%<", -- Mark general truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- End left alignment
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl, strings = { search } },
          })
        end,
      },
    })
  end,
}
