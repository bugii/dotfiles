return {
  "echasnovski/mini.nvim",
  version = false,
  lazy = false,
  config = function()
    local MiniIcons = require("mini.icons")
    require("mini.basics").setup()
    require("mini.bracketed").setup()
    require("mini.surround").setup()
    require("mini.diff").setup()
    require("mini.git").setup()
    local MiniVisits = require("mini.visits")
    local MiniHipatterns = require("mini.hipatterns")
    local MiniFiles = require("mini.files")
    local MiniBufremove = require("mini.bufremove")
    require("mini.notify").setup({
      lsp_progress = {
        -- I use noice for that
        enable = false,
      },
    })

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

    MiniVisits.setup({
      list = {
        filter = function(opts)
          if vim.startswith(opts.path, "fugitive:") then return false end
          if vim.fn.fnamemodify(opts.path, ":t") == "COMMIT_EDITMSG" then return false end
          return true
        end,
      },
    })

    vim.keymap.set("n", "-", function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, { desc = "Open Files" })
    MiniBufremove.setup()
    vim.keymap.set("n", "<C-x>", function() MiniBufremove.delete() end, { desc = "Open Files" })

    local sort_recent = MiniVisits.gen_sort.default({ recency_weight = 1 })
    vim.keymap.set(
      "n",
      "L",
      function() MiniVisits.iterate_paths("backward", nil, { sort = sort_recent, wrap = true }) end,
      { desc = "Go to last visited path" }
    )

    vim.keymap.set(
      "n",
      "H",
      function() MiniVisits.iterate_paths("forward", nil, { sort = sort_recent, wrap = true }) end,
      { desc = "Go to next visited path" }
    )

    vim.keymap.set(
      "n",
      "<leader>fv",
      function() MiniVisits.select_path(nil, { sort = sort_recent }) end,
      { desc = "Find Visits" }
    )
  end,
}
