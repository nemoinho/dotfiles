return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = "all",
			ignore_install = { "ipkg" },
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		--vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
		vim.opt.foldmethod = "expr"
	end,
}


