-- Build blink.cmp ONLY when installed or updated via vim.pack
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "blink" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("blink")
			end
			require("blink.cmp").build():pwait()
		end
	end,
})

vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig", name = "lspconfig" },
	{ src = "https://github.com/saghen/blink.cmp", name = "blink" },
	{ src = "https://github.com/saghen/blink.lib", name = "blink-lib" },
})

local hostname = vim.uv.os_gethostname()
local lowerHostname = string.lower(hostname)

vim.lsp.config("nixd", {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = "import <nixpkgs> { }",
			},
			formatting = {
				command = { "alejandra" },
			},
			options = {
				nixos = {
					expr = '(builtins.getFlake "~/.dotfiles/.nixos").nixosConfigurations.'
						.. lowerHostname
						.. ".options",
				},
			},
		},
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			runtime = {
				version = "LuaJIT",
			},
		},
	},
})

vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"cssls",
	"svelte",
	"nixd",
	"rust_analyzer",
	"emmet_language_server",
})

vim.o.winborder = "rounded"
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#89b4fa" })

require("blink.cmp").setup({
	fuzzy = { implementation = "rust" },
	appearance = { use_nvim_cmp_as_default = true },

	keymap = {
		["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
	},

	signature = {
		enabled = false,
	},

	completion = {
		trigger = {
			show_on_insert = true,
			show_on_trigger_character = true,
			show_on_keyword = true,
			show_on_backspace = true,
		},
		list = {
			selection = {
				preselect = false,
				auto_insert = true,
			},
		},
		menu = {
			auto_show = true,
			border = "rounded",
			min_width = 35,
			auto_show_delay_ms = 100,
		},
	},

	sources = {
		default = {
			"lsp",
			"snippets",
			"buffer",
			"path",
		},
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	once = true, -- Only load and configure lazydev once
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/folke/lazydev.nvim", name = "lazydev" },
		})
		require("lazydev").setup()
		require("blink.cmp").setup({
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
		})
	end,
})
