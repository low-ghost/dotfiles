-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "onedarker"

-- keymappings
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.keys.normal_mode["<Tab>"] = ":<C-U>call CountCommand('bnext')<CR>"
lvim.keys.normal_mode["<C-r>"] = ":<C-U>call CountCommand('redo')<CR>"
lvim.keys.normal_mode["<C-l>"] = ""
lvim.keys.normal_mode["<C-h>"] = ""
lvim.keys.normal_mode["<C-j>"] = ""
lvim.keys.normal_mode["<C-r>"] = "<C-r>"
lvim.keys.normal_mode["H"] = "^"
lvim.keys.normal_mode["L"] = "$"
lvim.keys.visual_mode["H"] = "^"
lvim.keys.visual_mode["L"] = "$"
lvim.keys.normal_mode["<S-Tab>"] = ":<C-U>call CountCommand('bprevious')<CR>"
lvim.keys.normal_mode[";"] = ":"
lvim.keys.normal_mode[":"] = "q:<CR>"

local function lsp_goto(direction, severity)
	return "<cmd>lua vim.lsp.diagnostic.goto_"
		.. direction
		.. "({severity='"
		.. severity
		.. "', popup_opts = {border = lvim.lsp.popup_border}})<cr>"
end

-- motions/fixes
vim.api.nvim_set_keymap("n", "ge", lsp_goto("next", "Error"), { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gE", lsp_goto("prev", "Error"), { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gw", lsp_goto("next", "Warning"), { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gW", lsp_goto("prev", "Warning"), { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gi", lsp_goto("next", "Info"), { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gI", lsp_goto("prev", "Info"), { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gvd", "<C-w>v:lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gsd", "<C-w>s:lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "zl", "zL", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "zh", "zH", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ".", ":normal .<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "j", "gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "k", "gk", { noremap = true, silent = true })

-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.treesitter.context_commentstring.enable = true

lvim.builtin.comment.on_config_done = function()
	require("nvim_comment").setup({
		comment_empty = false,
		hook = function()
			if vim.api.nvim_buf_get_option(0, "filetype") == "vue" then
				require("ts_context_commentstring.internal").update_commentstring()
			end
		end,
	})
end

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
lvim.lang.python.formatters = {
  { exe = "black", args = {} }
}
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "pylint",
--     args = {
--       "--from-stdin", "$FILENAME",
--       "-f", "json",
--       -- TODO: this breaks it, so ignoring import-error instead
--       -- "--init-hook", "import sys; sys.path.insert(0, '/Users/michaelbagwell/git/quotapath/app')",
--       "--good-names", "df,pd",
--       -- "--suggestion-mode", "yes",
--       "--load-plugins", "pylint_django",
--       "-d",
--         "missing-class-docstring," ..
--         " import-error," ..
--         " missing-function-docstring," ..
--         " missing-module-docstring," ..
--         " too-few-public-methods," ..
--         " missing-docstring," ..
--         " wrong-import-order," ..
--         " bad-continuation," ..
--         " no-self-use," ..
--         " too-many-ancestors"
--     },
--   }
-- }

lvim.lang.typescript.formatters = {{ exe = "prettier" } }
lvim.lang.typescriptreact.formatters = {{ exe = "prettier" } }
-- lvim.lang.typescript.linters = {{ exe = "eslint" } }
-- lvim.lang.typescriptreact.linters = {{ exe = "eslint" } }

-- Additional Plugins
lvim.plugins = {
	-- {"folke/tokyonight.nvim"},
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	config = function()
	-- 		require("lsp_signature").on_attach()
	-- 	end,
	-- 	event = "InsertEnter",
	-- },
	{
		"tpope/vim-surround",
		"tpope/vim-abolish",
		"wellle/targets.vim",
		"christoomey/vim-tmux-navigator",
		"tpope/vim-repeat",
	},
	{
		"justinmk/vim-sneak",
		event = "BufRead",
	},
	{
		"simnalamburt/vim-mundo",
		cmd = "MundoToggle",
	},
	{
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"Git",
			"Gdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"Gblame",
			"GBlame",
			"GBrowse",
			"Gbrowse",
			"GRemove",
			"GRename",
			"Glgrep",
			"Gedit",
		},
		requires = "tpope/vim-rhubarb",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "BufRead",
	},
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
--

vim.cmd([[
function! CountCommand(command, ...) abort
  let l:count = exists('a:1') && v:count == 0 ? a:1 : v:count1
  "execute a command like b or ll w/ a count
  if exists('a:2')
    exe '' . a:command . '' . l:count
  else
    exe a:command . l:count
  endif
endfunction
]])

-- Additional Leader bindings for WhichKey
local function q_and_l_keys(wkey, key, name)
	lvim.builtin.which_key.mappings[wkey] = {
		name = name,
		c = { "<cmd>" .. key .. "close<cr>", "Close" },
		C = { ":windo " .. key .. "close<cr>", "Close all in window" },
		o = { ":<C-U>call CountCommand('" .. key .. "open', 7)<cr>", "Open" },
		n = { ":<C-U>call CountCommand('" .. key .. "next')<cr>", "Next" },
		p = { ":<C-U>call CountCommand('" .. key .. "prev')<cr>", "Prev" },
		l = { ":<C-U>call CountCommand('" .. key .. "newer')<cr>", "Newer" },
		h = { ":<C-U>call CountCommand('" .. key .. "older')<cr>", "Older" },
		g = { ":<C-U>call CountCommand('" .. key .. key .. ")<cr>", "Go" },
	}
end

q_and_l_keys("c", "c", "Quickfix")
q_and_l_keys("C", "l", "Location") -- l is taken by lsp for now

lvim.builtin.which_key.mappings["w"] = {
	name = "Windows",
	v = { "<C-W>v:bn<cr>", "New vert split" },
	s = { "<C-W>s:bn<cr>", "New hori split" },
	o = { "<cmd>only<cr>", "Hide all others" },
	d = { "<cmd>hide<cr>", "Hide current" },
}

lvim.builtin.which_key.mappings["f"] = {
	name = "Files",
	["/"] = { "<cmd>Telescope find_files<cr>", "Find File" },
	r = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
	n = { "<cmd>NvimTreeFindFile<cr>", "NvimTreeFindFile" },
	v = { "<cmd>e ~/.config/lvim/config.lua<cr>", "Edit vim config" },
	-- w : silent w !sudo tee % /dev/null
}

vim.cmd('let g:sneak#prompt = "👟 "')

local buffer_mappings = {
	["/"] = { "<cmd>Telescope buffers<cr>", "Find buffer" },
	o = {
		"<cmd>BufferCloseAllButCurrent<cr>",
		"close all but current buffer",
	},
	H = { "<cmd>bfirst<cr>", "first buffer" },
	L = { ":blast<cr>", "last buffer" },
	d = { ":BufferClose<cr>", "delete buffer" },
	e = nil,
	s = {
		name = "Sort",
		l = {
			"<cmd>BufferOrderByLanguage<cr>",
			"sort BufferLines automatically by language",
		},
		d = {
			"<cmd>BufferOrderByDirectory<cr>",
			"sort BufferLines automatically by directory",
		},
	},
	r = { "<cmd>e! %<cr>", "refresh" },
	y = { 'gg"+yG<cr><c-o><c-o>', "Yank" },
}
for k, v in pairs(buffer_mappings) do
	lvim.builtin.which_key.mappings["b"][k] = v
end

local lsp_mappings = {
	n = {
		"<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
		"Next Diagnostic",
	},
	p = {
		"<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
		"Prev Diagnostic",
	},
}
for k, v in pairs(lsp_mappings) do
	lvim.builtin.which_key.mappings["l"][k] = v
end

lvim.builtin.which_key.mappings["<cr>"] = { ":w <cr>", "Save" }
-- TODO: hide galaxyline
lvim.builtin.which_key.mappings["u"] = { ":MundoToggle<cr>", "Undotree" }

lvim.builtin.which_key.mappings["/"] = {
	name = "Search",
	C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
	M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
	R = { "<cmd>Telescope registers<cr>", "Registers" },
	b = { "<cmd>Telescope buffers<cr>", "Find buffer" },
	c = { "<cmd>Telescope commands<cr>", "Commands" },
	f = { "<cmd>Telescope find_files<cr>", "Find File" },
	g = {
		name = "git",
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		C = {
			"<cmd>Telescope git_bcommits<cr>",
			"Checkout commit(for current file)",
		},
	},
	h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
	k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
  l = {
    name = "LSP",
    d = {"<cmd>Telescope lsp_definitions<cr>", "Definitions"},
    a = {"<cmd>Telescope lsp_code_actions<cr>", "Actions"},
    A = {"<cmd>Telescope lsp_range_code_actions<cr>", "Range Actions"},
    s = {"<cmd>Telescope lsp_document_symbols<cr>", "Symbols"},
    S = {"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols"},
    y = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diag"},
    Y = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diag"},
    i = {"<cmd>Telescope lsp_implementations<cr>", "Implementations"},
    r = {"<cmd>Telescope lsp_references<cr>", "References"},
  },
  p = { "<cmd>Telescope projects<cr>", "Projects"},
	r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
	t = { "<cmd>Telescope live_grep<cr>", "Text" },
  w = { "Grep Cur. Word"},
}

vim.cmd([[
  nnoremap <expr> <space>/w ':Telescope live_grep<cr>' . expand('<cword>')
]])

lvim.builtin.which_key.mappings["t"] = {
	name = "Toggle",
	["/"] = { "<cmd>set invhlsearch<cr>", "Search" },
	["s"] = { "<cmd>call sneak#cancel()<cr>", "Sneak" },
}

vim.cmd([[
  let g:sneak#label = 1
  let g:sneak#s_next = 1 

  let g:sneak#target_labels = "arstneowfpuymq/ARSTNEOWFPUYMQ123456789?()\\←↓→↑°±√✓∴∵"

  map f <Plug>Sneak_f
  map F <Plug>Sneak_F
  map t <Plug>Sneak_t
  map T <Plug>Sneak_T
]])

vim.cmd([[
  imap <expr> <C-l> vsnip#expandable() ? '<Plug>(vsnip-expand)' : ''
  smap <expr> <C-l> vsnip#expandable() ? '<Plug>(vsnip-expand)' : ''
  imap <expr> <C-h> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : ''
  smap <expr> <C-h> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : ''
]])

local sub_s = "///<Left><Left>"
local sub_w = sub_s .. "<C-r><C-w><Right>"
local sub_range_l = { key ="", text ="", name ="Line" }
local sub_range_a = { key="a", text ="%", name ="All" }
local sub_range_e = { key ="e", text =".,$", name ="End" }

for k, name in pairs({ s = "Sub", S = "Abolish" }) do
  for _, range in pairs({ sub_range_l, sub_range_a, sub_range_e }) do
    local new_map = {
      name = name,
      s = { ":" .. range.text .. k .. sub_s, "Sub" },
      w = { ":" .. range.text .. k .. sub_w, "Current word" },
    }
    if range.key == "" then
      lvim.builtin.which_key.mappings[k] = new_map
    else
      lvim.builtin.which_key.mappings[k][range.key] = new_map
      lvim.builtin.which_key.mappings[k][range.key]["name"] = range.name
    end
  end
end



-- local function build_sub(key, action, range_selection, range, is_correct, end_str)
--   local std_extra = action == '' && key != 'l' ? '<Left>' : ''
--   local arrows = '<Left><Left>' .. std_extra
--   local map_str = 'noremap <space>s' .. range_selection
--   local correct_extra = is_correct == true ? 'c<Left>' : ''
--   local sub_str = 's/' .. action .. '//g' .. correct_extra .. arrows
--   local full_command_except_mode = map_str .. key .. ' :' .. range .. sub_str .. end_str

--   'n' . full_command_except_mode

--   if range_selection !~# 'a\|e'
--     exe 'v' . l:full_command_except_mode
--   end
-- end

-- require('lint').linters.pylint.args = {
--     "-f", "json",
--     "--score", "no",
--     "--msg-template", "'{line}:{column}:{category}:{msg} ({msg_id}:{symbol})'",
--     "--init-hook", "import sys; sys.path.insert(0, '/Users/michaelbagwell/git/quotapath/app')",
--     "--good-names", "df,pd",
--     "--suggestion-mode", "yes",
--     "--load-plugins", "pylint_django",
--     "-d",
--       "missing-class-docstring," ..
--       " missing-function-docstring," ..
--       " missing-module-docstring," ..
--       " too-few-public-methods," ..
--       " missing-docstring," ..
--       " wrong-import-order," ..
--       " bad-continuation," ..
--       " no-self-use," ..
--       " too-many-ancestors"
-- }
