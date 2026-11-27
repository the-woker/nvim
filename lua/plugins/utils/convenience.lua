vim.pack.add({
	{ src = "https://github.com/vladdoster/remember.nvim", name = "remember" },
	{ src = "https://github.com/folke/flash.nvim", name = "flash" },
})

-- enable remember
require("remember").setup({})
