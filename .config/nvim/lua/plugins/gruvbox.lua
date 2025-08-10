return {
	{
	--	"lifepillar/vim-gruvbox8",
	--	priority = 1000, --ensure loading before other plugins
	--	opts = {},
	--	config = function()
	--		vim.g.gruvbox_contrast_dark = "hard"
	--		--vim.cmd("colorscheme gruvbox8")
	--	end,
	--}, {	
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		opts = {
			contrast = "hard",
		},
		config = function()
			vim.cmd("colorscheme gruvbox")
		end
	}
}
