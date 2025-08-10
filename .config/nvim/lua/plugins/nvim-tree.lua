local function my_attach_change(bufnr)
	local api = require "nvim-tree.api"
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	api.config.mappings.default_on_attach(bufnr)
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "I", api.tree.toggle_hidden_filter, opts("Toggle Filter: Dotfiles"))
	-- vim.keymap.set("n", "O", function()
	-- 	api.node.open.edit()
    --     current = api.tree.get_node_under_cursor()
    --     if current.type ~= "directory" then
    --         api.tree.close()
    --     end
	-- end, opts("Open and clode Tree"))
    -- vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))

	-- add my most used NERDTree mappings
	-- vim.keymap.set("n", "ma", api.fs.create, opts("NERDTree add a childnode"))
	-- vim.keymap.set("n", "mc", function() api.fs.copy.node(); api.fs.paste(); end, opts("NERDTree copy the current node"))
	-- vim.keymap.set("n", "md", api.fs.remove, opts("NERDTree delete the current node"))
	-- vim.keymap.set("n", "mm", api.fs.rename_full, opts("NERDTree move the current node"))
	-- vim.keymap.set("n", "mo", api.node.run.system, opts("NERDTree open the current node with system editor"))
end


return {
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		keys = {
			{ "<Leader>e", "<CMD>NvimTreeFindFile<CR>", desc = "NvimTree" },
			{ "<Leader>E", "<CMD>NvimTreeClose<CR>", desc = "Close NvimTree" },
		},
		opts = {
			on_attach = my_attach_change,
			filters = {
				dotfiles = true,
				git_ignored = false,
			},
			view = {
				signcolumn = "no",
				width = 40,
			},
			renderer = {
				-- root_folder_label = ":~",
				-- root_folder_label = ":.",
				root_folder_label = function(path)
					return vim.fn.fnamemodify(path, ":h:t") .. "/" .. vim.fn.fnamemodify(path, ":t") .. "/"
				end,
				group_empty = true,
				icons = {
					padding = {
						icon = "  ",
					},
					--padding = {
					--	folder_arrow = " ",
					--	icon = "",
					--},
					--show = {
					--	file = false,
					--	folder = false,
					--	folder_arrow = true,
					--},
					--glyphs = {
					--	folder = {
					--		arrow_closed = "▸ ",
					--		arrow_open = "▾ ",
					--	},
					--	git = {
					--		unstaged = "✗ ",
					--		staged = "✓ ",
					--		unmerged = " ",
					--		renamed = "➜ ",
					--		untracked = "★ ",
					--		deleted = " ",
					--		ignored = "◌ ",
					--	},
					--},
				},
			},
			diagnostics = {
				enable = true,
				icons = {
					hint = " ",
					info = " ",
					warning = " ",
					error = " ",
				},
			},
		},
		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
	-- {
	-- 	"scrooloose/nerdtree",
	-- 	init = function()
	-- 		vim.g.NERDTreeGitStatusShowIgnored = 1
	-- 		vim.cmd([[let NERDTreeMinimalUI=1]])
	-- 		vim.cmd([[let NERDTreeDirArrows=1]])
	-- 		vim.cmd([[let NERDTreeAutoDeleteBuffer=1]])
	-- 		-- vim.keymap.set("n", "<Leader>n", ":NERDTreeToggle<CR>")
	-- 	end,
	-- 	keys = {
	-- 		{ "<Leader>e", "<CMD>NERDTreeFocus<CR>", desc = "NERDTree" },
	-- 	},
	-- },
	-- {
	-- 	"Xuyuanp/nerdtree-git-plugin",
	-- },
}
