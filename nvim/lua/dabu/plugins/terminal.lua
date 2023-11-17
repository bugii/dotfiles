return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<F2>]],
				direction = "float",
			})
			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

			local function lazygit_toggle()
				lazygit:toggle()
			end

			vim.keymap.set("n", "<leader>gl", lazygit_toggle, {
				noremap = true,
				silent = true,
				desc = "Toggle Lazy Git",
			})
		end,
	},
}
