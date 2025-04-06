return {
  "rcarriga/nvim-dap-ui",
  event = "VeryLazy",
  dependencies = {
    "mfussenegger/nvim-dap",
    "theHamsta/nvim-dap-virtual-text",
    "williamboman/mason.nvim",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap, dapui, mason_registry, virtual_text =
      require("dap"), require("dapui"), require("mason-registry"), require("nvim-dap-virtual-text")

    dapui.setup()
    virtual_text.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = {
          mason_registry.get_package("js-debug-adapter"):get_install_path() .. "/js-debug/src/dapDebugServer.js",
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
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end

    dap.adapters.netcoredbg = {
      type = "executable",
      command = mason_registry.get_package("netcoredbg"):get_install_path() .. "/netcoredbg",
      args = { "--interpreter=vscode" },
    }

    local function get_processes()
      local processes = require("dap.utils").get_processes() -- Get a list of running processes
      local formatted_processes = {}

      for _, proc in ipairs(processes) do
        -- Create a formatted string with a shorter name
        local short_name = proc.name -- Use the process name directly or modify it for brevity
        -- You could also consider including the PID or other info for context
        table.insert(formatted_processes, {
          pid = proc.pid,
          name = short_name,
          display = string.format("%s (PID: %d)", short_name, proc.pid), -- Format for display
        })
      end

      return formatted_processes
    end

    dap.configurations.cs = {
      {
        type = "netcoredbg",
        name = "Attach",
        request = "attach",
        processId = function()
          return coroutine.create(function(dap_run_co)
            local processes = get_processes()

            if #processes > 0 then
              local items = vim.tbl_map(
                function(entry)
                  return {
                    id = entry.pid,
                    label = entry.display,
                  }
                end,
                processes
              )

              require("mini.pick").start({
                source = {
                  items = items,
                  choose = function(item)
                    if item then
                      print("Attaching to process:", item.label)
                      coroutine.resume(dap_run_co, item.id)
                    else
                      print("No process selected")
                      coroutine.resume(dap_run_co, nil)
                    end
                  end,
                },
              })
            else
              print("No processes found")
              coroutine.resume(dap_run_co, nil)
            end
          end)
        end,
      },
    }

    vim.keymap.set("n", "<F1>", function() dap.continue() end, { desc = "Continue" })
    vim.keymap.set("n", "<F2>", function() dap.step_over() end, { desc = "Step Over" })
    vim.keymap.set("n", "<F3>", function() dap.step_into() end, { desc = "Step Into" })
    vim.keymap.set("n", "<F4>", function() dap.step_out() end, { desc = "Step Out" })
    vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
  end,
}
