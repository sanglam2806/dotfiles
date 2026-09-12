return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,

	opts = {
		flavour = "mocha", -- matches @catppuccin_flavor "mocha" in .tmux.conf
		transparent_background = true,
		integrations = {
			treesitter = true,
			native_lsp = { enabled = true },
			telescope = true,
			neotree = true,
		},
	},

	config = function(_, opts)
		require("catppuccin").setup(opts)
	end,
}
