-- TODO: replace telescope functions with mini.pick
return {
	"rcarriga/nvim-dap-ui",
	event = { "VeryLazy" },
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

		dap.adapters.netcoredbg = {
			type = "executable",
			command = mason_registry.get_package("netcoredbg"):get_install_path() .. "/netcoredbg",
			args = { "--interpreter=vscode" },
		}

		-- local function search_dlls()
		-- 	local current_dir = vim.fn.expand("%:p:h") -- Start from the current buffer's directory
		-- 	local found_dlls = {}
		--
		-- 	while current_dir ~= "/" do
		-- 		print("Searching in directory:", current_dir) -- Print the directory being searched
		-- 		local dlls = vim.fn.glob(current_dir .. "/bin/{Debug,Release}/**/*.dll", false, true)
		--
		-- 		if #dlls > 0 then
		-- 			for _, dll in ipairs(dlls) do
		-- 				table.insert(found_dlls, dll) -- Collect found DLLs
		-- 			end
		--
		-- 			return found_dlls -- Return as soon as DLLs are found
		-- 		end
		--
		-- 		-- Move up one directory level
		-- 		current_dir = vim.fn.fnamemodify(current_dir, ":h")
		-- 	end
		--
		-- 	return nil
		-- end
		--
		-- local function format_dlls(dlls)
		-- 	local formatted = {}
		-- 	for _, dll in ipairs(dlls) do
		-- 		local name = vim.fn.fnamemodify(dll, ":t") -- Get just the file name
		-- 		-- Format as "name (path)" and add it to the list
		-- 		table.insert(formatted, { name = name, path = dll, display = string.format("%s (%s)", name, dll) })
		-- 	end
		-- 	return formatted
		-- end

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
			-- INFO: this is disabled because netcoredbg does not seem to take launchSettings json into account, thus many env variables are missing
			-- Keep an eye on: https://github.com/Samsung/netcoredbg/issues/163
			-- {
			-- 	type = "netcoredbg",
			-- 	name = "Launch",
			-- 	request = "launch",
			-- 	program = function()
			-- 		return coroutine.create(function(dap_run_co)
			-- 			local dlls = search_dlls() -- Search for DLLs
			-- 			if dlls and #dlls > 0 then
			-- 				local formatted_dlls = format_dlls(dlls) -- Format DLLs for display in Telescope
			--
			-- 				-- Use Telescope to select a DLL
			-- 				require("telescope.pickers")
			-- 					.new({}, {
			-- 						prompt_title = "Select a DLL",
			-- 						finder = require("telescope.finders").new_table({
			-- 							results = formatted_dlls,
			-- 							entry_maker = function(entry)
			-- 								return {
			-- 									value = entry.path, -- The full path will be used when selected
			-- 									display = entry.display, -- What will be shown in the picker
			-- 									ordinal = entry.name, -- For sorting
			-- 								}
			-- 							end,
			-- 						}),
			-- 						sorter = require("telescope.sorters").get_generic_fuzzy_sorter(),
			-- 						attach_mappings = function(_, map)
			-- 							map("i", "<CR>", function(prompt_bufnr)
			-- 								local selection = require("telescope.actions.state").get_selected_entry()
			-- 								if selection then
			-- 									print("Using DLL for debugging:", selection.value) -- Print the selected DLL path
			-- 									coroutine.resume(dap_run_co, selection.value) -- Resume the dap_run coroutine with the selected DLL
			-- 								else
			-- 									print("No DLL selected")
			-- 									coroutine.resume(dap_run_co, nil) -- Resume with nil if no selection
			-- 								end
			-- 								require("telescope.actions").close(prompt_bufnr) -- Close the picker
			-- 							end)
			-- 							return true
			-- 						end,
			-- 					})
			-- 					:find()
			-- 			else
			-- 				print("No DLLs found")
			-- 				coroutine.resume(dap_run_co, nil) -- Resume with nil if no DLLs found
			-- 			end
			-- 		end)
			-- 	end,
			-- },
			{
				type = "netcoredbg",
				name = "Attach",
				request = "attach",
				processId = function()
					return coroutine.create(function(dap_run_co)
						local processes = get_processes() -- Get the list of processes

						if #processes > 0 then
							-- Use Telescope to select a process
							require("telescope.pickers")
								.new({}, {
									prompt_title = "Select a Process",
									finder = require("telescope.finders").new_table({
										results = processes,
										entry_maker = function(entry)
											return {
												value = entry.pid, -- The PID will be used for attaching
												display = entry.display, -- What will be shown in the picker
												ordinal = entry.name, -- For sorting
											}
										end,
									}),
									sorter = require("telescope.sorters").get_generic_fuzzy_sorter(),
									attach_mappings = function(_, map)
										map("i", "<CR>", function(prompt_bufnr)
											local selection = require("telescope.actions.state").get_selected_entry()
											if selection then
												print("Attaching to process:", selection.display) -- Print the selected process
												coroutine.resume(dap_run_co, selection.value) -- Resume with the selected PID
											else
												print("No process selected")
												coroutine.resume(dap_run_co, nil) -- Resume with nil if no selection
											end
											require("telescope.actions").close(prompt_bufnr) -- Close the picker
										end)
										return true
									end,
								})
								:find()
						else
							print("No processes found")
							coroutine.resume(dap_run_co, nil) -- Resume with nil if no processes found
						end
					end)
				end,
			},
		}

		vim.keymap.set("n", "<F1>", function()
			dap.continue()
		end, { desc = "Continue" })
		vim.keymap.set("n", "<F2>", function()
			dap.step_over()
		end, { desc = "Step Over" })
		vim.keymap.set("n", "<F3>", function()
			dap.step_into()
		end, { desc = "Step Into" })
		vim.keymap.set("n", "<F4>", function()
			dap.step_out()
		end, { desc = "Step Out" })
		vim.keymap.set("n", "<leader>b", function()
			dap.toggle_breakpoint()
		end, { desc = "Toggle Breakpoint" })
	end,
}
