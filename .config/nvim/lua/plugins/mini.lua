return {
  "echasnovski/mini.nvim",
  version = "*",
  lazy = false,
  config = function()
    local MiniIcons = require("mini.icons")
    require("mini.basics").setup()
    require("mini.bracketed").setup()
    require("mini.surround").setup()
    require("mini.diff").setup()
    require("mini.sessions").setup({ autoread = true })
    require("mini.git").setup()
    local MiniHipatterns = require("mini.hipatterns")
    local MiniFiles = require("mini.files")
    local MiniBufremove = require("mini.bufremove")
    local MiniStatusline = require("mini.statusline")
    require("mini.notify").setup()

    vim.keymap.set("n", "[t", ":tabprevious<CR>", { silent = true, desc = "Previous tab" })
    vim.keymap.set("n", "]t", ":tabnext<CR>", { silent = true, desc = "Next tab" })

    MiniIcons.setup()
    MiniIcons.mock_nvim_web_devicons()

    MiniFiles.setup({
      mappings = {
        close = "<ESC>",
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
