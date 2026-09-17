vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.diagnostic")

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	-- { src = "https://github.com/lervag/vimtex" },
})

vim.cmd("colorscheme catppuccin-mocha")

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

vim.lsp.enable({ "lua_ls", "ruff", "ty" })

vim.keymap.set("n", "<Leader>fF", "<Cmd>FzfLua<CR>")
vim.keymap.set("n", "<Leader>ff", "<Cmd>FzfLua files<CR>")
vim.keymap.set("n", "<Leader>fh", "<Cmd>FzfLua helptags<CR>")
vim.keymap.set("n", "<Leader>fc", "<Cmd>FzfLua commands<CR>")
vim.keymap.set("n", "<Leader><Leader>", "<Cmd>FzfLua combine pickers=git_files;lsp_workspace_symbols<CR>")

require("oil").setup()
vim.keymap.set("n", "<Leader>e", "<Cmd>Oil<CR>")
