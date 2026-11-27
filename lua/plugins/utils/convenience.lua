vim.pack.add({
	{ src = "https://github.com/vladdoster/remember.nvim", name = "remember" },
	{ src = "https://github.com/Aasim-A/scrollEOF.nvim", name = "scrolleof" },
	{ src = "https://github.com/folke/flash.nvim", name = "flash" },
})

-- enable remember
require("remember").setup({})

-- enable scrolleof
require("scrollEOF").setup({
	pattern = "*",
	insert_mode = false,
	floating = false,
	disabled_filetypes = { "terminal", "flash_prompt" },
	disabled_modes = { "t", "nt" },
})
