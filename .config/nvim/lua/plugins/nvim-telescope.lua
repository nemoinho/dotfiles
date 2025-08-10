return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		'nvim-lua/plenary.nvim'
		-- do not forget to install ripgrep!!!
		-- https://github.com/nvim-telescope/telescope.nvim/issues/522#issuecomment-1374795374
	},
	opts = {
	},
	config = function()
		local ts = require("telescope.builtin")
		vim.keymap.set("n", "<C-p>", ts.find_files)
		vim.keymap.set("n", "<Leader>fg", ts.live_grep)
		vim.keymap.set("n", "<Leader>ff", ts.oldfiles)
	end,
}
