vim.bo.formatprg = "ruff format -"

vim.api.nvim_create_autocmd("BufWritePre", {
	buffer = 0,
	callback = function()
		local view = vim.fn.winsaveview()
		---@diagnostic disable-next-line: param-type-mismatch
		local ok, err = pcall(vim.cmd, "%!ruff format -")
		vim.fn.winrestview(view)
		if not ok then
			vim.notify(err, vim.log.levels.ERROR)
		end
	end,
})
