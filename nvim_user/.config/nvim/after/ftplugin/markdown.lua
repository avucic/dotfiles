local Hydra = require("hydra")

local table_hint = [[
   _r_: realig         _dr_: delete row     _dc_: delete column
  _mt_: tableize       _ms_: sort table     _ic_: insert column after
  _fa_: add formula    _fe_: eval formula   _iC_: insert column before ^ ^
  _lr_: renumber list  _?_: echo cell map

  ^   _k_   ^
  _h_     _l_
  ^   _j_   ^

]]

local table_hydra_normal = Hydra({
	name = "Table",
	hint = table_hint,
	config = {
		on_key = false,
		invoke_on_body = true,
		hint = {
			border = "rounded",
			type = "window",
		},
	},
	heads = {
		-- {"t", "<cmd>TableModeEnable<CR>",{exit = true}},
		{ "r", "<Plug>(table-mode-realign)", { desc = "realign", exit = true } },
		{ "dr", "<Plug>(table-mode-delete-row)", { desc = "delete row", exit = true } },
		{ "dc", "<Plug>(table-mode-delete-cell)", { desc = "delete cell", exit = true } },
		{ "mt", "<Plug>(table-mode-tableize)", { desc = "tableize", exit = true } },
		{ "ms", "<Plug>(table-mode-sort)", { desc = "sort", exit = true } },
		{ "ic", "<Plug>(table-mode-insert-column-after)", { desc = "insert column after", exit = true } },
		{ "iC", "<Plug>(table-mode-insert-column-before)", { desc = "insert column before", exit = true } },
		{ "fa", "<Plug>(table-mode-add-formula)", { desc = "add formula", exit = true } },
		{ "fe", "<Plug>(table-mode-eval-formula)", { desc = "eval formula", exit = true } },
		{ "lr", "<cmd>RenumberList<cr>", { desc = "renumber list", exit = true } },
		{ "k", "<Plug>(table-mode-motion-up)", { desc = "up" } },
		{ "j", "<Plug>(table-mode-motion-down)", { desc = "down" } },
		{ "l", "<Plug>(table-mode-motion-right)", { desc = "right" } },
		{ "h", "<Plug>(table-mode-motion-left)", { desc = "left" } },
		{ "?", "<Plug>(table-mode-echo-cell-map)", { desc = "Echo cell map", exit = true } },
		{ "<Esc>", nil, { exit = true, nowait = true, desc = false } },
	},
})

local function choose_table_hydra()
	table_hydra_normal:activate()
end

local diagram_hint = [[
 Arrow^^^^^^   Select region with <C-v>
 ^ ^ _K_ ^ ^   _f_: surround it with box
 _H_ ^ ^ _L_
 ^ ^ _J_ ^ ^
]]

local diagram_hydra = Hydra({
	name = "Draw Diagram",
	hint = diagram_hint,
	config = {
		buffer = true,
		color = "pink",
		invoke_on_body = true,
		hint = {
			border = "rounded",
		},
		on_enter = function()
			vim.o.virtualedit = "all"
		end,
	},
	heads = {
		{ "H", "<C-v>h:VBox<CR>" },
		{ "J", "<C-v>j:VBox<CR>" },
		{ "K", "<C-v>k:VBox<CR>" },
		{ "L", "<C-v>l:VBox<CR>" },
		{ "f", ":VBox<CR>", { mode = "v" } },
		{ "<Esc>", nil, { exit = true, nowait = true, desc = false } },
	},
})

local function choose_diagram_hydra()
	diagram_hydra:activate()
end

local bullet_hint = [[
_l_: demote           _h_: promote
_x_: toggle checkbox  _n_: renumber
]]

local bullet_hydra = Hydra({
	name = "Draw Diagram",
	hint = bullet_hint,
	config = {
		buffer = true,
		invoke_on_body = true,
		hint = {
			border = "rounded",
		},
		on_enter = function()
			vim.o.virtualedit = "all"
		end,
	},
	heads = {
		{ "l", "<cmd>BulletDemote<cr>", { exit = false } },
		{ "h", "<cmd>BulletPromote<cr>", { exit = false } },
		{ "x", "<Plug>(bullets-toggle-checkbox)", { exit = false } },
		{ "n", "<Plug>(bullets-renumber)", { exit = true } },
		{ "<Esc>", nil, { exit = true, nowait = true, desc = false } },
	},
})

local function choose_bullet_hydra()
	bullet_hydra:activate()
end

local hint = [[
 _t_: table        _d_: diagram
 _p_: preview      _s_: server
 _b_: bullet       _i_: paste link
]]

Hydra({
	name = "Markdown",
	hint = hint,
	config = {
		buffer = true,
		color = "pink",
		invoke_on_body = true,
		hint = {
			border = "rounded",
		},
		on_enter = function()
			vim.o.virtualedit = "all"
		end,
	},
	mode = "n",
	body = "<leader>m",
	heads = {
		{ "t", choose_table_hydra },
		{ "d", choose_diagram_hydra },
		{ "b", choose_bullet_hydra },
		{ "i", ":PasteMDLink<cr>", { nowait = true, exit = true, desc = "Insert link" } },
		{ "p", "<Cmd>MarkdownPreview<CR>", { nowait = true } },
		{
			"s",
			"<cmd>lua require('user.core.utils').toggle_term_cmd('cd $ZK_NOTEBOOK_DIR && markserv', {direction = 'horizontal'})<CR>",
			{ desc = false, nowait = true, exit = true },
		},
		{ "<Esc>", "<Cmd>MarkdownPreviewStop<CR>", { exit = true, nowait = true, desc = false } },
	},
})

vim.api.nvim_win_set_option(0, "wrap", true)
vim.api.nvim_win_set_option(0, "conceallevel", 2)
vim.api.nvim_win_set_option(0, "foldlevel", 99)
vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<cr>",
	[[:lua vim.lsp.buf.definition()<CR>]],
	{ noremap = true, desc = "Go to Declaration" }
)

vim.api.nvim_buf_set_keymap(0, "n", "<bs>", [[:ZkBacklinks<CR>]], { noremap = true, desc = "Back links" })
vim.api.nvim_buf_set_keymap(0, "n", "<bs>", [[:ZkBacklinks<CR>]], { noremap = true, desc = "Back links" })

-- bullets
vim.api.nvim_buf_set_keymap(0, "i", "<C-CR>", "<Plug>(bullets-newline)", { noremap = true, desc = "New line" })
vim.api.nvim_buf_set_keymap(0, "i", "<CR>", "<Plug>(bullets-newline)", { noremap = true, desc = "New line" })
vim.api.nvim_buf_set_keymap(0, "n", "o", "<Plug>(bullets-newline)", { noremap = true, desc = "New line" })
vim.api.nvim_buf_set_keymap(0, "v", ">", "<cmd>BulletDemote<cr>", { noremap = true, desc = "Bullet demote" })
vim.api.nvim_buf_set_keymap(0, "v", "<", "<cmd>BulletPromote<cr>", { noremap = true, desc = "Bullet promote" })
vim.api.nvim_buf_set_keymap(0, "v", "gN", "<Plug>(bullets-renumber)", { noremap = true, desc = "Bullet renumber" })
