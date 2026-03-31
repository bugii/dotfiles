return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  branch = "main",
  config = function()
    require("nvim-treesitter").setup()
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
    require("nvim-treesitter").install(languages):wait(300000) -- wait max. 5 minutes

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
  end,
}
