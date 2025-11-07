return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  config = function()
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
  end,
}
