vim.bo.shiftwidth = 2
vim.bo.formatprg = "stylua -"

vim.api.nvim_create_autocmd("BufWritePre", {
	buffer = 0,
	callback = function()
		if vim.fn.executable("stylua") == 0 then
			vim.notify("stylua not found, skipping formatting.", vim.log.levels.WARN)
			return
		end

		local view = vim.fn.winsaveview()
		---@diagnostic disable-next-line: param-type-mismatch
		local ok, err = pcall(vim.cmd, "%!stylua -")
		vim.fn.winrestview(view)
		if not ok then
			vim.notify(err, vim.log.levels.ERROR)
		end
	end,
})
