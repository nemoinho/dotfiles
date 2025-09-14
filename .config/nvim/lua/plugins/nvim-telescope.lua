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
		vim.keymap.set("n", "<C-p>", function ()
			builtin.find_files({ hidden = true })
		end, { desc = "Find files" })
		vim.keymap.set("n", "<Leader>ff", function ()
			builtin.find_files({ no_ignore = true, hidden = true })
		end, { desc = "Find all files" })
		vim.keymap.set("n", "<Leader>fb", function () vim.cmd("Telescope buffers") end, { desc = "Find buffers" })
		vim.keymap.set("n", "<Leader>fg", builtin.live_grep, { desc = "Grep files" })
		vim.keymap.set("n", "<Leader>fh", builtin.oldfiles, { desc = "Find recent files" })
		vim.keymap.set("n", "<Leader>*", builtin.grep_string, { desc = "Find current word" })
		vim.keymap.set("n", "<Leader>#", builtin.grep_string, { desc = "Find current word" })
		vim.keymap.set("n", "<Leader>gh", function ()
			builtin.git_bcommits({
				git_command = {"git", "log", "--format=%h %s (%ar) %aN <%aE>", "--abbrev-commit"}
			})
		end, { desc = "Git history of current file" })
		vim.keymap.set("n", "<Leader>glh", function ()
			builtin.git_commits({
				file_path = true,
				use_git_root = false,
				git_command = {"git", "log", "--format=%h %s %Cgreen(%ar) %aN <%aE>", "--abbrev-commit", "--", "."}
			})
		end, { desc = "Git history" })
		vim.keymap.set("n", "<Leader>gs", builtin.git_branches, { desc = "Git branches" })
	end,
}
