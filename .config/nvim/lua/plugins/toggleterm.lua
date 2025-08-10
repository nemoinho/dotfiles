vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], {})
vim.keymap.set('t', '<C-d>', [[<C-\><C-n><Cmd>ToggleTerm<CR>]], {})

return {
	"akinsho/toggleterm.nvim",
	opts = {},
    keys = {
        { "<C-d>", [[<Cmd>ToggleTerm<CR>]] },
    },
}
