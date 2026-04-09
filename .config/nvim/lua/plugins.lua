vim.pack.add({
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.basics",
  "https://github.com/nvim-mini/mini.bracketed",
  "https://github.com/nvim-mini/mini.surround",
  "https://github.com/nvim-mini/mini.diff",
  "https://github.com/nvim-mini/mini-git",
  "https://github.com/nvim-mini/mini.hipatterns",
  "https://github.com/nvim-mini/mini.files",
  "https://github.com/nvim-mini/mini.bufremove",
  -- "https://github.com/nvim-mini/mini.notify",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/davidmh/mdx.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/seblyng/roslyn.nvim",
  "https://github.com/tpope/vim-dadbod",
  "https://github.com/kristijanhusak/vim-dadbod-completion",
  "https://github.com/kristijanhusak/vim-dadbod-ui",
  "https://github.com/mrjones2014/smart-splits.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/MagicDuck/grug-far.nvim",
  "https://github.com/marilari88/neotest-vitest",
  "https://github.com/nsidorenco/neotest-vstest",
  "https://github.com/nvim-neotest/neotest",
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/miroshQa/debugmaster.nvim",
  "https://github.com/lucaSartore/nvim-dap-exception-breakpoints",
})

-- Treesitter ---------------------------------------------------------------------------------------
local NvimTreesitter = require("nvim-treesitter")
local languages = {
  "bash",
  "lua",
  "vim",
  "javascript",
  "typescript",
  "jsx",
  "tsx",
  "html",
  "css",
  "json",
  "json5",
  "markdown",
  "markdown_inline",
  "c_sharp",
  "razor",
  "python",
  "regex",
  "sql",
  "yaml",
  "graphql",
  "styled",
}
NvimTreesitter.install(languages):wait(300000) -- wait max. 5 minutes

local filetypes = {
  -- NOTE: no parser exists, but the mdx plugin has captures etc and uses the markdown parser as a default for this filetype
  "mdx",
}
for _, lang in ipairs(languages) do
  for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
    table.insert(filetypes, ft)
  end
end
local ts_start = function(ev) vim.treesitter.start(ev.buf) end

vim.api.nvim_create_autocmd("FileType", {
  pattern = filetypes,
  callback = ts_start,
  desc = "Start tree-sitter",
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
  end,
})

-- Treesitter Text objects ------------------------------------------------------------------------------
require("nvim-treesitter-textobjects").setup({
  select = {
    enable = true,
    lookahead = true,
  },
})

vim.keymap.set(
  "o",
  "a=",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@assignment.outer", "textobjects") end,
  { desc = "Select outer part of an assignment" }
)
vim.keymap.set(
  "o",
  "i=",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@assignment.inner", "textobjects") end,
  { desc = "Select inner part of an assignment" }
)
vim.keymap.set(
  "o",
  "l=",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@assignment.lhs", "textobjects") end,
  { desc = "Select left hand side of an assignment" }
)
vim.keymap.set(
  "o",
  "r=",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@assignment.rhs", "textobjects") end,
  { desc = "Select right hand side of an assignment" }
)
vim.keymap.set(
  "o",
  "aa",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects") end,
  { desc = "Select outer part of a parameter/argument" }
)
vim.keymap.set(
  "o",
  "ia",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects") end,
  { desc = "Select inner part of a parameter/argument" }
)
vim.keymap.set(
  "o",
  "al",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects") end,
  { desc = "Select outer part of a loop" }
)
vim.keymap.set(
  "o",
  "il",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects") end,
  { desc = "Select inner part of a loop" }
)
vim.keymap.set(
  "o",
  "af",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@call.outer", "textobjects") end,
  { desc = "Select outer part of a function call" }
)
vim.keymap.set(
  "o",
  "if",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@call.inner", "textobjects") end,
  { desc = "Select inner part of a function call" }
)
vim.keymap.set(
  "o",
  "am",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end,
  { desc = "Select outer part of a method/function definition" }
)
vim.keymap.set(
  "o",
  "im",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end,
  { desc = "Select inner part of a method/function definition" }
)
vim.keymap.set(
  "o",
  "ac",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects") end,
  { desc = "Select outer part of a class" }
)
vim.keymap.set(
  "o",
  "ic",
  function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects") end,
  { desc = "Select inner part of a class" }
)

-- Lspconfig
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature documentation" })
    vim.keymap.set(
      "n",
      "<leader>wa",
      vim.lsp.buf.add_workspace_folder,
      { buffer = ev.buf, desc = "add workspace folder" }
    )
    vim.keymap.set(
      "n",
      "<leader>wr",
      vim.lsp.buf.remove_workspace_folder,
      { buffer = ev.buf, desc = "remove workspace folder" }
    )
    vim.keymap.set(
      "n",
      "<leader>wl",
      function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      { buffer = ev.buf, desc = "list workspace folders" }
    )
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename" })
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "code action" })
  end,
})

-- Lualine -------------------------------------------------------------------------------------------
require("lualine").setup({
  options = {
    theme = "auto",
    globalstatus = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      { "diff", diff_color = { added = "DiffAdd", modified = "DiffChange", removed = "DiffDelete" } },
      "diagnostics",
    },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

-- Completion ----------------------------------------------------------------------------------------
require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<C-l>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-k>"] = { "snippet_forward", "fallback" },
    ["<C-j>"] = { "snippet_backward", "fallback" },
  },
  appearance = {
    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = "mono",
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer", "lazydev" },
    per_filetype = {
      sql = { "snippets", "dadbod", "buffer" },
    },
    providers = {
      dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },

  signature = { enabled = true },

  completion = {
    keyword = { range = "full" },
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },

  cmdline = {
    keymap = {
      ["<C-l>"] = { "show", "hide" },
      ["<C-y>"] = { "accept" },
    },
    completion = { menu = { auto_show = true } },
  },
})

-- Mini ----------------------------------------------------------------------------------------------
local MiniIcons = require("mini.icons")
MiniIcons.setup()
MiniIcons.mock_nvim_web_devicons()

require("mini.basics").setup()
require("mini.bracketed").setup()
require("mini.surround").setup()
require("mini.diff").setup()
require("mini.git").setup()
require("mini.hipatterns").setup({
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
  },
})

local MiniFiles = require("mini.files")
MiniFiles.setup({ mappings = { close = "<ESC>" } })
vim.keymap.set("n", "-", function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, { desc = "Open Files" })

local MiniBufremove = require("mini.bufremove")
MiniBufremove.setup()
vim.keymap.set("n", "<C-x>", function() MiniBufremove.delete() end, { desc = "Open Files" })

-- require("mini.notify").setup({
--   lsp_progress = {
--     -- some lsps (roslyn for ex) do not seem to properly work
--     enable = false,
--   },
-- })

-- Flash
vim.keymap.set({ "n", "x", "o" }, "<CR>", function()
  if not vim.tbl_contains({ vim.bo.filetype }, "vim") then
    require("flash").jump()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
  end
end, { desc = "Flash" })

vim.keymap.set(
  { "n", "x", "o" },
  "<leader><CR>",
  function() require("flash").treesitter() end,
  { desc = "Flash Treesitter" }
)

-- Mason -----------------------------------------------------------------------------------------
require("mason").setup({
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  },
})

require("mason-lspconfig").setup({
  automatic_enable = {
    exclude = { "mdx_analyzer" },
  },
  ensure_installed = {
    "tsgo",
    "lua_ls",
    "pyright",
    "bashls",
    "cssls",
    "emmet_ls",
    "html",
    "jsonls",
    "tailwindcss",
    "rust_analyzer",
    "typos_lsp",
    "yamlls",
    "mdx_analyzer",
    -- "graphql",
    -- "eslint",
    "oxlint",
  },
})

require("mason-tool-installer").setup({
  ensure_installed = {
    -- formatters
    -- "prettierd",
    "stylua",
    -- "black",
    "csharpier",
    -- linters
    -- "eslint_d",
    -- "pylint",
    -- lsps
    -- find all versions here: https://github.com/Crashdummyy/roslynLanguageServer
    -- { "roslyn", version = "5.3.0-2.25571.4" },
    "roslyn",
    "oxfmt",
  },
})

vim.lsp.config("mdx_analyzer", {
  init_options = {
    typescript = {
      enabled = true,
    },
  },
})

vim.lsp.enable("mdx_analyzer")

-- Dadbod ---------------------------------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>b", function() vim.cmd("DBUIToggle") end, { desc = "Toggle DBUI" })

-- Conform -----------------------------------------------------------------------------------------------------------
local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "oxfmt" },
    typescript = { "oxfmt" },
    javascriptreact = { "oxfmt" },
    typescriptreact = { "oxfmt" },
    python = { "black" },
    css = { "oxfmt" },
    html = { "oxfmt" },
    json = { "oxfmt" },
    yaml = { "oxfmt" },
    markdown = { "oxfmt" },
    graphql = { "oxfmt" },
    cs = { "csharpier" },
    rust = { "rustfmt" },
  },
  formatters = {
    csharpier = {
      command = "dotnet",
      args = { "csharpier", "format", "--write-stdout" },
      stdin = true,
      -- in order to respect the locally installed installation (using dotnet tools)
      cwd = require("conform.util").root_file(".config"),
    },
    black = {
      command = require("conform.util").find_executable({ ".venv/bin/black" }, "black"),
      args = {
        "--stdin-filename",
        "$FILENAME",
        "--quiet",
        "-",
      },
      cwd = require("conform.util").root_file({
        -- https://black.readthedocs.io/en/stable/usage_and_configuration/the_basics.html#configuration-via-a-file
        "pyproject.toml",
      }),
    },
  },

  format_after_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
})

vim.keymap.set(
  { "n", "v" },
  "<leader>f",
  function()
    conform.format({
      lsp_fallback = true,
      timeout_ms = 1000,
    })
  end,
  { desc = "Format file or range (in visual mode)" }
)

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

-- Smart splits ---------------------------------------------------------------------------------
local smartsplits = require("smart-splits")
vim.keymap.set("n", "<C-h>", smartsplits.move_cursor_left)
vim.keymap.set("n", "<C-j>", smartsplits.move_cursor_down)
vim.keymap.set("n", "<C-k>", smartsplits.move_cursor_up)
vim.keymap.set("n", "<C-l>", smartsplits.move_cursor_right)

-- Snacks
require("snacks").setup({
  scratch = {},
  image = {},
  gitbrowse = {},
  picker = {},
  input = {},
  quickfile = {},
  gh = {},
})

vim.keymap.set("n", "<leader>b", function() vim.cmd("DBUIToggle") end, { desc = "Toggle DBUI" })
vim.keymap.set("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
vim.keymap.set(
  "n",
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
  { desc = "Select Scratch Buffer" }
)

vim.keymap.set(
  "n",
  "<leader>fg",
  function()
    Snacks.picker.grep({
      hidden = true,
      exclude = { "node_modules" },
    })
  end,
  { desc = "Find Grep" }
)

vim.keymap.set(
  "n",
  "<leader>ff",
  function() Snacks.picker.files({ hidden = true, ignored = true, exclude = { "node_modules", ".local" } }) end,
  { desc = "Files" }
)

vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
vim.keymap.set("n", "<leader>fq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>fR", function() Snacks.picker.resume() end, { desc = "Resume" })
vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })
vim.keymap.set(
  { "n", "x" },
  "<leader>fw",
  function()
    Snacks.picker.grep_word({
      opts = {
        hidden = true,
      },
    })
  end,
  { desc = "Find Word" }
)
vim.keymap.set("n", "<leader>fib", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>fk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fc", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
vim.keymap.set("n", "<leader>fm", function() Snacks.picker.marks() end, { desc = "Marks" })
vim.keymap.set("n", "<leader>fd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>fn", function() Snacks.picker.notifications() end, { desc = "Notifications" })
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
vim.keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
vim.keymap.set("n", "gt", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto [T]ype Definition" })
vim.keymap.set("n", "<leader>fs", function() Snacks.picker.lsp_symbols() end, { desc = "[F]ind [S]ymbols" })
vim.keymap.set("n", "<leader>fH", function() Snacks.picker.highlights() end, { desc = "[F]ind [H]ighlights" })

vim.keymap.set("n", "<leader>gx", function() Snacks.gitbrowse.open() end, { desc = "Open gitbrowse for current file" })

vim.keymap.set("n", "<leader>gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub Issues (open)" })
vim.keymap.set(
  "n",
  "<leader>gI",
  function() Snacks.picker.gh_issue({ state = "all" }) end,
  { desc = "GitHub Issues (all)" }
)
vim.keymap.set("n", "<leader>gp", function() Snacks.picker.gh_pr() end, { desc = "GitHub Pull Requests (open)" })
vim.keymap.set(
  "n",
  "<leader>gP",
  function() Snacks.picker.gh_pr({ state = "all" }) end,
  { desc = "GitHub Pull Requests (all)" }
)

-- Grug-far ------------------------------------------------------------------------

vim.keymap.set("n", "<leader>sr", ":GrugFar <CR>", { desc = "Search and Replace" })

-- Neotest -------------------------------------------------------------------------
local neotest = require("neotest")

neotest.setup({
  adapters = {
    require("neotest-vitest"),
    require("neotest-vstest"),
    -- require("neotest-dotnet"),
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

-- DAP --------------------------------------------------------------------------------

local dm = require("debugmaster")
-- make sure you don't have any other keymaps that starts with "<leader>d" to avoid delay
-- Alternative keybindings to "<leader>d" could be: "<leader>m", "<leader>;"
vim.keymap.set({ "n", "v" }, "<leader>d", dm.mode.toggle, { nowait = true })
-- If you want to disable debug mode in addition to leader+d using the Escape key:
-- vim.keymap.set("n", "<Esc>", dm.mode.disable)
-- This might be unwanted if you already use Esc for ":noh"
vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

dm.plugins.osv_integration.enabled = true -- needed if you want to debug neovim lua code
local dap = require("dap")

-- Configure your debug adapters here
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "js-debug-adapter",
    args = {
      "${port}",
    },
  },
}

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      skipFiles = { "<node_internals>/**", "**/node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
      skipFiles = { "<node_internals>/**", "**/node_modules/**" },
    },
  }
end

dap.adapters.netcoredbg = {
  type = "executable",
  -- NOTE: on apple silicon you have to build it yourself, thus the path to the binary. Check their github for build instructions
  command = "/usr/local/netcoredbg",
  args = { "--interpreter=vscode" },
}

dap.configurations.cs = dap.configurations.cs or {}

table.insert(dap.configurations.cs, {
  type = "netcoredbg",
  name = "Attach",
  request = "attach",
  processId = require("dap.utils").pick_process,
})

local set_exception_breakpoints = require("nvim-dap-exception-breakpoints")
require("debugmaster").keys.add({ key = "de", action = set_exception_breakpoints })
