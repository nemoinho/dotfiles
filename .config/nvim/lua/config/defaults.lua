vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- look for modifier-lines in files and apply them
vim.opt.modeline = true
vim.opt.modelineexpr = true

-- do no enter a linebreak at end of files (not unix-like, since it makes text-files binary for unix!)
vim.opt.fixendofline = false

-- improve line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- highlight current line
vim.opt.cursorline = true

-- show meaningful chars for non-printable situations, e.g. nbsp or wrappings
vim.opt.list = true
vim.opt.listchars = "tab:› ,trail:·,nbsp:␣,extends:»,precedes:«"

-- highlight search results
vim.opt.hlsearch = true
vim.cmd([[highlight LineNr ctermfg=7]])
vim.cmd([[highlight CursorLineNr ctermbg=green]])
vim.cmd([[highlight CursorLine ctermbg=green]])

-- do not wrap long lines
vim.opt.wrap = false

-- break lines at words, not chars
vim.opt.linebreak = true

-- indent by 2 chars by default, make tabstops also 2 chars and expand tabs to spaces
vim.opt.tabstop = 8
vim.opt.softtabstop = 2
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- fold code after some nesting
vim.opt.foldlevel = 100

-- make backspace behave like in other applications
vim.opt.backspace = "indent,eol,start"

-- simply clear search
vim.keymap.set("n", "<Leader>/", "<Cmd>nohlsearch<CR>")

-- add some quickfix shortcuts for easier navigation
vim.keymap.set("n", "<Leader>cn", "<Cmd>cnext<CR>")
vim.keymap.set("n", "<Leader>n", "<Cmd>cnext<CR>")
vim.keymap.set("n", "<Leader>cp", "<Cmd>cprevious<CR>")
vim.keymap.set("n", "<Leader>p", "<Cmd>cprevious<CR>")
vim.keymap.set("n", "<Leader>cc", "<Cmd>cclose<CR>")
vim.keymap.set("n", "<Leader>co", "<Cmd>copen<CR>")
vim.keymap.set("n", "<Leader>cf", "<Cmd>cfirst<CR>")
vim.keymap.set("n", "<Leader>cl", "<Cmd>clast<CR>")

-- simple spellchecks
vim.keymap.set("n", "<Leader>ss", "<Cmd>set spell!<CR>")
vim.keymap.set("n", "<Leader>sd", "<Cmd>set spelllang=de_de<CR>")
vim.keymap.set("n", "<Leader>se", "<Cmd>set spelllang=en_us<CR>")

-- make navigation easer on a german keyboard!
vim.keymap.set("n", "ä", "]")
vim.keymap.set("n", "ö", "[")
vim.keymap.set("n", "<C-ä>", "<C-]>")
vim.keymap.set("n", "<C-ö>", "<C-[>")
vim.keymap.set("n", ",", ";")
vim.keymap.set("n", ";", ",")

-- simpler navigation in diffs
if vim.api.nvim_win_get_option(0, "diff") then
	vim.keymap.set("n", "<Leader>1", "<Cmd>diffget LOCAL<CR>")
	vim.keymap.set("n", "<Leader>2", "<Cmd>diffget BASE<CR>")
	vim.keymap.set("n", "<Leader>3", "<Cmd>diffget REMOTE<CR>")
	vim.keymap.set("n", "<Leader>n", "]c")
	vim.keymap.set("n", "<Leader>p", "[c")
end

-- autocommands for specific files
local configgroup = vim.api.nvim_create_augroup('MY_DEFAULTS', { clear = true })

function fix_filetype(pattern, filetype)
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = pattern,
		group = configgroup,
		callback = function()
			vim.opt.filetype = filetype
		end,
	})
end

-- fix filetypes
fix_filetype("*Containerfile", "dockerfile")
fix_filetype("~/.config/git/*", "gitconfig")

-- adjust settings per filetype
-- git
vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitconfig",
	group = configgroup,
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
	end,
})
-- lua
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	group = configgroup,
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
	end,
})
-- i3config
vim.api.nvim_create_autocmd("FileType", {
	pattern = "i3config",
	group = configgroup,
	callback = function()
		vim.opt_local.foldlevel = 0
		vim.opt_local.foldmethod = "marker"
	end,
})
-- snippets
vim.api.nvim_create_autocmd("FileType", {
	pattern = "snippets",
	group = configgroup,
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 4
	end,
})
