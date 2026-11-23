local plugins = {}

-- 1. Setup paths
local lua_path = os.getenv("CONFIG_ROOT") .. "/lua"
local plugin_dir = lua_path .. "/plugins"

-- 2. Use ** to search recursively for all .lua files
local files = vim.fn.split(vim.fn.globpath(plugin_dir, "**/*.lua"), "\n")

for _, file in ipairs(files) do
	-- Get path relative to the 'lua' directory
	-- Example: /home/user/.config/nvim/lua/plugins/ui/statusline.lua
	-- Becomes: plugins/ui/statusline.lua
	local relative_path = file:sub(#lua_path + 2)

	-- Remove the .lua extension
	local module_path = relative_path:gsub("%.lua$", "")

	-- Convert path slashes to Lua dots (plugins/ui/statusline -> plugins.ui.statusline)
	module_path = module_path:gsub("/", ".")

	-- 3. The Guard: Don't require the current file (plugins.init)
 	if not module_path:match("%.init$") and module_path ~= "plugins" then
		local t0 = vim.uv.hrtime()
		local status_ok, module_content = pcall(require, module_path)
		local ms = (vim.uv.hrtime() - t0) / 1e6

		if ms > 50 then
			vim.schedule(function()
				vim.notify(string.format("%s took %.1f ms", module_path, ms), vim.log.levels.WARN)
			end)
		end

		if status_ok then
			table.insert(plugins, module_content)
		else
			vim.notify("Error loading " .. module_path .. ": " .. module_content, vim.log.levels.ERROR)
		end
	end

end

return plugins
