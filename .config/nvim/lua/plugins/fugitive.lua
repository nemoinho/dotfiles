return {
	{
		"tpope/vim-fugitive",
		lazy = false,
		keys = {
			{ "<Leader>gb", "<Cmd>G blame<CR>", desc = "Git blame" },
			{ "<Leader>gll", "<Cmd>G log --graph --format='%h (%ar) %s :: %aN <%aE>'<CR>", desc = "Git log" },
			{ "<Leader>glf", "<Cmd>G log --graph --format='%h (%ar) %s :: %aN <%aE>' %<CR>", desc = "Git log for current file" },
			{ "<Leader>glc", "<Cmd>Gclog -- %<CR>", desc = "Quicklist commits affecting the current file" },
			{ "<Leader>glh", "<Cmd>0Gclog -- %<CR>", desc = "Quicklist revisions of the current file" },
		},
	},
	-- Github integration for :GBrowse
	{ "tpope/vim-rhubarb" },
	-- Gitea integration for :GBrowse
	{
		"borissov/fugitive-gitea",
		config = function()
			vim.g.fugitive_gitea_domains = { "https://gitea.nehrke.info" }
		end
	},
	-- Gitlab integration for :GBrowse
	{ "shumphrey/fugitive-gitlab.vim" },
	-- Bitbucket integration for :GBrowse
	{ "tommcdo/vim-fubitive" },
}
