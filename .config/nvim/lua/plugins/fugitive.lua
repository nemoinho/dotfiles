return {
	{
		"tpope/vim-fugitive",
		lazy = false,
		keys = {
			-- replaced by telescope
			-- { "<Leader>gg", "<Cmd>Ggrep ", desc = "Git grep" },
			{ "<Leader>gb", "<Cmd>G blame<CR>", desc = "Git blame" },
			{ "<Leader>gll", "<Cmd>G log --graph --format='%h (%ar) %s :: %aN <%aE>'<CR>", desc = "Git blame" },
			{ "<Leader>glx", "<Cmd>Gclog -- %<CR>" },
			{ "<Leader>gl0", "<Cmd>0Gclog -- %<CR>" },
		},
	},
	-- Github integration for :GBrowse
	{ "tpope/vim-rhubarb" },
	-- Gitea integration for :GBrowse
	{ "borissov/fugitive-gitea" },
	-- Gitlab integration for :GBrowse
	{ "shumphrey/fugitive-gitlab.vim" },
	-- Bitbucket integration for :GBrowse
	{ "tommcdo/vim-fubitive" },
}
