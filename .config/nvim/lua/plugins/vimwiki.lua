local wikipath = "~/Development/nemoinho/gitea.nehrke.info/nemoinho/vimwiki/"
--vim.cmd("let g:vimwiki_list = [{'path': '~/Development/nemoinho/gitea.nehrke.info/nemoinho/vimwiki/' }]")
vim.g.vimwiki_table_mappings = 0
vim.g.vimwiki_list = { { path = wikipath, auto_export = 1 } }
vim.g.vimwiki_autowriteall = 0
vim.g.vimwiki_url_maxsave = 0

local vimwikiconfig = vim.api.nvim_create_augroup('VIMWIKI_CONFIG', { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "diary.wiki",
	group = vimwikiconfig,
	callback = function() vim.cmd([[VimwikiDiaryGenerateLinks]]) end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "vimwiki",
	group = vimwikiconfig,
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.keymap.set("n", "<Leader>ws", function()
			vim.cmd("call system('sleep 2 && cd " .. wikipath .. " && git add . && git commit -m " .. '"Auto commit"' .. " && git push')")
		end)
		vim.keymap.set("n", "<Leader>we", "<Cmd>VimwikiMakeDiaryNote<CR>")
	end,
})

return {
	"vimwiki/vimwiki",
	config = function() end,
}
