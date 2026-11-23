vim.opt.confirm = true

-- Autocommand to check git status
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.system({ "git", "rev-parse", "--is-inside-work-tree" }, { text = true }, function(res)
			if res.code ~= 0 then
				return
			end

			vim.system({ "git", "fetch" }, {
				env = { GIT_TERMINAL_PROMPT = "0" },
			}, function(fetch_res)
				if fetch_res.code ~= 0 then
					return
				end

				vim.system({ "git", "rev-list", "--count", "HEAD..@{u}" }, { text = true }, function(count_res)
					local count = tonumber((count_res.stdout or ""):gsub("%s+", ""))
					if count and count > 0 then
						vim.schedule(function()
							vim.notify(
								"   " .. count .. " new commit(s) available on remote.",
								vim.log.levels.INFO,
								{ title = "Git Status", icon = "  " }
							)
						end)
					end
				end)
			end)
		end)
	end,
})

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "svelte" },
-- 	callback = function()
-- 		vim.treesitter.start()
-- 	end,
-- })

local cursorline_group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = cursorline_group,
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave" }, {
	group = cursorline_group,
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

-- Center cursor on screen whenver insert mode is activated
-- (Stops fucky wucky shit with scrollEOF)
vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.cmd("normal! zz")
	end,
})
