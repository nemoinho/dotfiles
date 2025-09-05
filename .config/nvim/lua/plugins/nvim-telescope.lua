return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		'nvim-lua/plenary.nvim',
		-- do not forget to install ripgrep!!!
		-- https://github.com/nvim-telescope/telescope.nvim/issues/522#issuecomment-1374795374
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	opts = {
		extensions = {
			fzf = {},
		},
	},
	config = function()
		local ts = require("telescope")
		ts.load_extension("fzf")
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<C-p>", builtin.find_files)
		vim.keymap.set("n", "<Leader>b", "<CMD>Telescope buffers<CR>")
		vim.keymap.set("n", "<Leader>fg", builtin.live_grep)
		vim.keymap.set("n", "<Leader>ff", builtin.oldfiles)
		vim.keymap.set("n", "<Leader>*", builtin.grep_string)
		vim.keymap.set("n", "<Leader>#", builtin.grep_string)
		vim.keymap.set("n", "<Leader>lf", builtin.git_bcommits)
		vim.keymap.set("n", "<Leader>ld", function () builtin.git_commits({ file_path = true, use_git_root = false }) end)
		vim.keymap.set("n", "<Leader>lb", builtin.git_branches)
	end,
}
