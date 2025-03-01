return {
	"folke/snacks.nvim",
	---@type snacks.Config
	lazy = false,
	opts = {
		scratch = {},
		image = {},
		gitbrowse = {},
	},
	keys = {
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
	},
}
