-- idea stolen from: https://vi.stackexchange.com/a/42370
local skelconfig = vim.api.nvim_create_augroup('SKEL_CONFIG', { clear = true })
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
	group = skelconfig,
	callback = function()
		-- another autocmd so it doesn't conflict 
		-- with other plugins that like to insert text on file open
		vim.api.nvim_create_autocmd("VimEnter", {
			group = skelconfig,
			callback = function()
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
			end
		})
	end,
})

return {
	"L3MON4D3/LuaSnip",
	version = "v2.*", -- just because the docs mention it
}
