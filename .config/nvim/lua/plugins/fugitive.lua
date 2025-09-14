local cmd = function (cmd)
	return function () vim.cmd(cmd) end
end

return {
	{
		"tpope/vim-fugitive",
		lazy = false,
		keys = {
			{ "<Leader>gb", cmd("G blame"), desc = "Git blame" },
			{ "<Leader>gll", cmd("G log --graph --format='%h (%ar) %s :: %aN <%aE>'"), desc = "Git log" },
			{ "<Leader>glf", cmd("G log --graph --format='%h (%ar) %s :: %aN <%aE>' %"), desc = "Git log for current file" },
			{ "<Leader>glq", cmd("0Gclog -- %"), desc = "Quicklist revisions of the current file" },
			{ "<Leader>go", cmd("GBrowse"), desc = "Open file in Browser in Remote-Repo"}
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
