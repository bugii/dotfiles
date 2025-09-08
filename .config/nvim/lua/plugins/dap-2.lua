return {
  "miroshQa/debugmaster.nvim",
  -- osv is needed if you want to debug neovim lua code. Also can be used
  -- as a way to quickly test-drive the plugin without configuring debug adapters
  dependencies = { "mfussenegger/nvim-dap", "jbyuki/one-small-step-for-vimkind" },
  event = "VeryLazy",
  enable = true,
  config = function()
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

    local netcoredbg_adapter = {
      type = "executable",
      -- NOTE: on apple silicon you have to build it yourself, thus the path to the binary. Check their github for build instructions
      command = "/usr/local/netcoredbg",
      args = { "--interpreter=vscode" },
    }
    dap.adapters.netcoredbg = netcoredbg_adapter -- needed for normal debugging
    dap.adapters.coreclr = netcoredbg_adapter -- needed for unit test debugging

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "Run",
        request = "launch",
        program = function() return require("../nvim-dap-dotnet").build_dll_path() end,
      },
      {
        type = "coreclr",
        name = "Attach",
        request = "attach",
        processId = require("dap.utils").pick_process,
      },
    }
  end,
}
