local cmd = function (cmd)
	return function () vim.cmd(cmd) end
end

return {
	'Wansmer/treesj',
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
	config = function()
		require('treesj').setup({
			use_default_keymaps = false,
		})
		vim.keymap.set("n", "<Leader>bm", cmd("TSJToggle"), { desc = "Toggle expand/collapse block" })
		vim.keymap.set("n", "<Leader>bj", cmd("TSJJoin"), { desc = "Collapse block" })
		vim.keymap.set("n", "<Leader>bs", cmd("TSJSplit"), { desc = "Expand block" })
	end,
}
