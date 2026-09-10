require("nvim-treesitter").setup({
	ensure_installed = {
		"bash",
		"c",
		"cmake",
		"cpp",
		"fish",
		"lua",
		"luadoc",
		"markdown",
		"printf",
		"toml",
		"vim",
		"vimdoc",
		"yaml",
	},

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = { enable = true },
})
