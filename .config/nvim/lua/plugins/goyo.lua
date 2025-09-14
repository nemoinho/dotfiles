return {
	"junegunn/goyo.vim",
	dependencies = {
		"junegunn/limelight.vim",
		"nvim-lualine/lualine.nvim",
	},
	lazy = false,
	config = function ()
		vim.keymap.set("n", "<Leader>gg", function()
			require('lualine').hide()
			vim.cmd([[Goyo]])
			vim.cmd([[Limelight!! 0.8]])
		end, { desc = "Switch to goyo view" })
	end
	-- "pocco81/true-zen.nvim",
	-- config = function ()
	-- 	vim.keymap.set("n", "<Leader>gwg", function()
	-- 		vim.cmd([[TZAtaraxis]])
	-- 	end)
	-- 	vim.keymap.set("n", "<Leader>gww", function()
	-- 		require('lualine').hide()
	-- 	end)
	-- end
}
