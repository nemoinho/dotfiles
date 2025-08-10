return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		'nvim-tree/nvim-web-devicons'
	},
	opts = {
		sections = {
			lualine_c = { { "filename", path = 1 } },
		},
		inactive_sections = {
			lualine_c = { { 'filename', path = 1 } },
		},
	},
}

