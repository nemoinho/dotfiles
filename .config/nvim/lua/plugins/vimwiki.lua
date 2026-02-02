local wikipath = "~/Development/nemoinho/gitea.nehrke.info/nemoinho/vimwiki/"
--vim.cmd("let g:vimwiki_list = [{'path': '~/Development/nemoinho/gitea.nehrke.info/nemoinho/vimwiki/' }]")
vim.g.vimwiki_table_mappings = 0
vim.g.vimwiki_list = { { path = wikipath, auto_export = 1 } }
vim.g.vimwiki_ext2syntax = { my_very_own_nonsense = "markdown" }
vim.g.vimwiki_autowriteall = 0
vim.g.vimwiki_url_maxsave = 0
vim.keymap.set("n", "<Leader>we", function()
	vim.cmd("VimwikiMakeDiaryNote")
	-- stop if buffer is not empty!
	if vim.fn.line("$") ~= 1 or vim.fn.getline(1) ~= "" then
		return
	end
	local ls = require('luasnip')
	local snippets = ls.get_snippets(vim.bo.ft)
	for _, snippet in ipairs(snippets) do
		if snippet["name"] == "_skeleton" then
			ls.snip_expand(snippet)
			return true
		end
	end
end, { desc = "VimwikiMakeDiaryNote" })

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
		vim.keymap.set("n", "<Leader>ws", "<Cmd>Gw | G commit-and-push<CR>", { desc = "Save, commit & push" })
	end,
})

return {
	"vimwiki/vimwiki",
	config = function() end,
}
