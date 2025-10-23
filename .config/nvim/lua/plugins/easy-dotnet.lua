return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("easy-dotnet").setup({
      debugger = {
        -- NOTE: on apple silicon build the binary yourself, the mason install does not work
        bin_path = "/usr/local/netcoredbg",
      },
    })
  end,
}
