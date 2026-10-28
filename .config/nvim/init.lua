vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("core.options")
require("core.completion")

-- Core keymaps
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")
vim.keymap.set("i", "<A-BS>", "<C-w>")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "p", '"_dP')
-- window
vim.keymap.set("n", "<C-left>", "<Cmd>wincmd h<CR>")
vim.keymap.set("n", "<C-down>", "<Cmd>wincmd j<CR>")
vim.keymap.set("n", "<C-up>", "<Cmd>wincmd k<CR>")
vim.keymap.set("n", "<C-right>", "<Cmd>wincmd l<CR>")
-- scrolling
vim.keymap.set("n", "<C-e>", function()
	return math.max(1, math.floor(vim.fn.winheight(0) / 10)) .. "<C-e>"
end, { expr = true })
vim.keymap.set("n", "<C-y>", function()
	return math.max(1, math.floor(vim.fn.winheight(0) / 10)) .. "<C-y>"
end, { expr = true })
-- diagnostics
vim.keymap.set("n", "[e", function()
	vim.diagnostic.jump({ count = 1, float = true, severtity = vim.diagnostic.severity.ERROR })
end, { desc = "Jump to next error" })
vim.keymap.set("n", "]e", function()
	vim.diagnostic.jump({ count = -1, float = true, severtity = vim.diagnostic.severity.ERROR })
end, { desc = "Jump to previous error" })

-- Always open help files on the right
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "help",
	callback = function()
		vim.cmd("wincmd L")
		vim.cmd("vertical resize 80")
		vim.wo.winfixheight = true
	end,
})

vim.diagnostic.config({ virtual_text = true })

-- Core plugins
vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim.git" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/folke/flash.nvim.git" },
	{ src = "https://github.com/LudoPinelli/comment-box.nvim.git" },
})

vim.cmd("colorscheme catppuccin-mocha")

vim.lsp.enable({ "lua_ls", "ruff", "ty" })

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.keymap.set("n", "<Leader>fF", "<Cmd>FzfLua<CR>")
vim.keymap.set("n", "<Leader>ff", "<Cmd>FzfLua files<CR>")
vim.keymap.set("n", "<Leader>fh", "<Cmd>FzfLua helptags<CR>")
vim.keymap.set("n", "<Leader>fc", "<Cmd>FzfLua commands<CR>")
vim.keymap.set("n", "<Leader><Leader>", "<Cmd>FzfLua combine pickers=git_files;lsp_workspace_symbols<CR>")

require("oil").setup()
vim.keymap.set("n", "<Leader>e", "<Cmd>Oil<CR>")

vim.keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })

require("ibl").setup()
