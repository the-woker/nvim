return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	opts = {
		config = {
			header = {
				"                   _             ",
				"    __      _____ | | _____ _ __ ",
				"    \\ \\ /\\ / / _ \\| |/ / _ \\ '__|",
				"     \\ V  V / (_) |   <  __/ |   ",
				"      \\_/\\_/ \\___/|_|\\_\\___|_|   ",
			},
		},
	},
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
