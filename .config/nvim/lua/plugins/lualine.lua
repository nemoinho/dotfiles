return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		'nvim-tree/nvim-web-devicons'
	},
	opts = {
		sections = {
			lualine_c = { { "filename", path = 1 } },
			lualine_z = { '%o b', '%l:%c' }
		},
		inactive_sections = {
			lualine_c = { { 'filename', path = 1 } },
		},
	},
}

