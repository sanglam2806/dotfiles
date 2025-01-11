return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"c",
				"java",
				"go",
				"lua",
				"vim",
				"zig",
				"javascript",
				"typescript",
				"json",
				"html",
				"gowork",
				"gosum",
				"gomod",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end
}
