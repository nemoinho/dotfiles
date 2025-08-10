local function my_attach_change(bufnr)
	local gs = require "gitsigns"
	vim.keymap.set("n", "<Leader>tb", gs.toggle_current_line_blame, { buffer = bufnr })
end

return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	opts = {
		on_attach = my_attach_change,
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "-" },
			topdelete = { text = "-" },
		},
		signs_staged = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "-" },
			topdelete = { text = "-" },
		},
		word_diff = false
	},
}
