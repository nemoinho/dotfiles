local on_attach = function(_, bufnr)
	local desc = function (desc)
		return { noremap = true, silent = true, buffer = bufnr, desc = desc }
	end
	local ts = require("telescope.builtin")
	vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, desc("Rename identifier"))
	vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, desc("Code actions"))
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, desc("Jump to definition"))
	vim.keymap.set("n", "ge", vim.diagnostic.open_float, desc("Open diagnostics, show errors"))
	vim.keymap.set("n", "gf", function() vim.lsp.buf.format { async = true } end, desc("Format code"))
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, desc("Jump to implementation"))
	vim.keymap.set("n", "gk", vim.lsp.buf.hover, desc("Show quick-docs"))
	vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, desc("Show signature"))
	vim.keymap.set("n", "gn", function() vim.diagnostic.jump({ count = 1, float = true }) end, desc("Jump to next occurence"))
	vim.keymap.set("n", "gN", function() vim.diagnostic.jump({ count = -1, float = true }) end, desc("Jump to previous occurence"))
	vim.keymap.set("n", "gr", ts.lsp_references, desc("Search references"))
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
		"nvim-telescope/telescope.nvim",
		"hrsh7th/nvim-cmp", -- IMPORTANT: autocomplete must be configured correctly!
		-- {
		-- 	'stevearc/dressing.nvim',
		-- 	opts = {},
		-- 	event='VeryLazy'
		-- }
	},
	opts = {},
	config = function()
		local masonlsp = require("mason-lspconfig")
		masonlsp.setup({
			-- possibilities: https://mason-registry.dev/registry/list
			ensure_installed = {
				"bashls",
				"cssls",
				"docker_language_server",
				"eslint",
				"gopls",
				"harper_ls",
				"html",
				"jsonls",
				"lua_ls",
				"terraformls",
				"ts_ls",
				"vue_ls",
			},
		})
		local vue_language_server_path = vim.fn.expand '$MASON/packages' ..
			'/vue-language-server' .. '/node_modules/@vue/language-server'
		local vue_plugin = {
			name = '@vue/typescript-plugin',
			location = vue_language_server_path,
			languages = { 'vue' },
			configNamespace = 'typescript',
		}
		local home_dir = os.getenv('HOME')
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		local opts = {
			on_attach = on_attach,
			capabilities = capabilities,
		}
		-- A list of language-server-configs https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
		vim.lsp.config("bashls", opts)
		vim.lsp.config("cssls", opts)
		vim.lsp.config("docker_language_server", opts)
		vim.lsp.config("eslint", {
			on_attach = function(client, bufnr)
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						if vim.bo.filetype == "typescript" then
							vim.lsp.buf.format()
						end
					end,
				})
			end,
		})
		vim.lsp.config("gopls", opts)
		vim.lsp.config("harper_ls", { -- spelling and grammer checks
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "markdown", "asciidoc", "text", "vimwiki" },
		})
		vim.lsp.config("html", opts)
		vim.lsp.config("jsonls", opts)
		vim.lsp.config("lua_ls", {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" }
					},
					telemetry = { enable = false },
				}
			}
		})
		vim.lsp.config("terraformls", opts)
		vim.lsp.config("ts_ls", {
			on_attach = on_attach,
			capabilities = capabilities,
			init_options = {
				plugins = {
					vue_plugin,
				},
			},
			filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
		})
		vim.lsp.config('vue_ls', opts)
		vim.lsp.enable({
			"cssls",
			"eslint",
			"html",
			"harper_ls",
			"jsonls",
			"lua_ls",
			"terraformls",
			"ts_ls",
			"vue_ls",
		})
	end,
}
