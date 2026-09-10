local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		cpp = { "clang-format" },
		hpp = { "clang-format" },
	},

	formatters = {
		["clang-format"] = {
			prepend_args = {
				"-style={ \
                        IndentWidth: 4, \
                        TabWidth: 4, \
                        UseTab: Always, \
                        AccessModifierOffset: 0, \
                        IndentAccessModifiers: true, \
                        PackConstructorInitializers: Never}",
			},
		},
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

require("conform").setup(options)
