return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = { "js-debug-adapter", "netcoredbg" },
			},
		},
	},
	config = function()
		local dap, dapui, mason_registry, virtual_text =
			require("dap"), require("dapui"), require("mason-registry"), require("nvim-dap-virtual-text")

		dapui.setup()
		virtual_text.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = {
					mason_registry.get_package("js-debug-adapter"):get_install_path()
						.. "/js-debug/src/dapDebugServer.js",
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

		dap.adapters["netcoredbg"] = {
			type = "executable",
			command = mason_registry.get_package("netcoredbg"):get_install_path() .. "/netcoredbg",
			args = { "--interpreter=vscode" },
		}

		vim.g.dotnet_build_project = function()
			local default_path = vim.fn.getcwd() .. "/"
			if vim.g["dotnet_last_proj_path"] ~= nil then
				default_path = vim.g["dotnet_last_proj_path"]
			end
			local path = vim.fn.input("Path to your *proj file", default_path, "file")
			vim.g["dotnet_last_proj_path"] = path
			local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
			print("")
			print("Cmd to execute: " .. cmd)
			local f = os.execute(cmd)
			if f == 0 then
				print("\nBuild: ✔️ ")
			else
				print("\nBuild: ❌ (code: " .. f .. ")")
			end
		end

		vim.g.dotnet_get_dll_path = function()
			local request = function()
				return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
			end

			if vim.g["dotnet_last_dll_path"] == nil then
				vim.g["dotnet_last_dll_path"] = request()
			else
				if
					vim.fn.confirm(
						"Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"],
						"&yes\n&no",
						2
					) == 1
				then
					vim.g["dotnet_last_dll_path"] = request()
				end
			end

			return vim.g["dotnet_last_dll_path"]
		end

		local config = {
			{
				type = "netcoredbg",
				name = "launch - netcoredbg",
				request = "launch",
				program = function()
					if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
						vim.g.dotnet_build_project()
					end
					return vim.g.dotnet_get_dll_path()
				end,
			},
		}

		dap.configurations.cs = config
		dap.configurations.fsharp = config

		vim.keymap.set("n", "<F5>", function()
			dap.continue()
		end, { desc = "Continue" })
		vim.keymap.set("n", "<F10>", function()
			dap.step_over()
		end, { desc = "Step Over" })
		vim.keymap.set("n", "<F11>", function()
			dap.step_into()
		end, { desc = "Step Into" })
		vim.keymap.set("n", "<F12>", function()
			dap.step_out()
		end, { desc = "Step Out" })
		vim.keymap.set("n", "<leader>b", function()
			dap.toggle_breakpoint()
		end, { desc = "Toggle Breakpoint" })
	end,
}
