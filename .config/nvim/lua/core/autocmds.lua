vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "help",
	callback = function()
		vim.notify("hello")
		vim.cmd("wincmd L")
		vim.cmd("vertical resize 80")
		vim.wo.winfixheight = true
	end,
})

-- vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
-- 	callback = function()
-- 		if vim.bo.buftype == "help" then
-- 			vim.cmd("wincmd L")
-- 			vim.cmd("vertical resize 80")
-- 			vim.bo.winfixheight = true
-- 		end
-- 	end,
-- })
