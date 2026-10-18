local M = {}
local is_pending_single_match = false

local function accept_single_match()
	local info = vim.fn.complete_info({ "items" })
	if not is_pending_single_match or vim.fn.pumvisible() ~= 1 then
		return
	end

	if #info.items == 1 then
		is_pending_single_match = false
		vim.api.nvim_feedkeys(vim.keycode("<C-y>"), "n", false)
	elseif #info.items > 1 then
		is_pending_single_match = false
	end
end

function M.complete(key)
	is_pending_single_match = true
	vim.api.nvim_feedkeys(vim.keycode(key), "n", false)
	vim.schedule(accept_single_match)
end

vim.api.nvim_create_autocmd("CompleteChanged", {
	callback = accept_single_match,
})

vim.api.nvim_create_autocmd({ "CompleteDone", "InsertLeave" }, {
	callback = function()
		is_pending_single_match = false
	end,
})

vim.keymap.set("i", "<C-n>", function()
	M.complete("<C-n>")
end, { desc = "Complete next item" })

vim.keymap.set("i", "<C-x><C-o>", function()
	M.complete("<C-x><C-o>")
end, { desc = "Complete with LSP/omnifunc" })

return M
