local Hydra = require("hydra")

local table_hydra_normal = Hydra({
	name = "Table",
	hint = [[
   _r_: realign         _dr_: delete row     _dc_: delete column
  _mt_: tabelize        _ms_: sort table     _dC_: delete cell
  _fa_: add formula     _fe_: eval formula   _ic_: insert column after
   _?_: echo cell map   _iC_: insert column before ^ ^

  ^   _K_   ^
  _H_     _L_
  ^   _J_   ^
]],

	config = {
		on_key = false,
		invoke_on_body = true,
		hint = {
			border = "rounded",
			type = "window",
		},
	},
	heads = {
		{ "r", "<Plug>(table-mode-realign)", { desc = "realign", exit = true } },
		{ "dr", "<Plug>(table-mode-delete-row)", { desc = "delete row", exit = true } },
		{ "dc", "<Plug>(table-mode-delete-column)", { desc = "delete column", exit = true } },
		{ "dC", "<Plug>(table-mode-delete-cell)", { desc = "delete cell", exit = true } },
		{ "mt", "<Plug>(table-mode-tableize)", { desc = "tableize", exit = true } },
		{ "ms", "<Plug>(table-mode-sort)", { desc = "sort", exit = true } },
		{ "ic", "<Plug>(table-mode-insert-column-after)", { desc = "insert column after", exit = true } },
		{ "iC", "<Plug>(table-mode-insert-column-before)", { desc = "insert column before", exit = true } },
		{ "fa", "<Plug>(table-mode-add-formula)", { desc = "add formula", exit = true } },
		{ "fe", "<Plug>(table-mode-eval-formula)", { desc = "eval formula", exit = true } },
		{ "K", "<Plug>(table-mode-motion-up)", { desc = "up" } },
		{ "J", "<Plug>(table-mode-motion-down)", { desc = "down" } },
		{ "L", "<Plug>(table-mode-motion-right)", { desc = "right" } },
		{ "H", "<Plug>(table-mode-motion-left)", { desc = "left" } },
		{ "?", "<Plug>(table-mode-echo-cell-map)", { desc = "Echo cell map", exit = true } },
		{ "<Esc>", nil, { exit = true, nowait = true, desc = false } },
	},
})

local code_hydra = Hydra({
	name = "Code",
	config = {
		on_key = false,
		invoke_on_body = true,
		hint = {
			border = "rounded",
			type = "window",
		},
	},
	heads = {
		{ "e", "<cmd>FeMaco<cr>", { desc = "edit", exit = true } },
		{ "x", "<cmd>lua require 'mdeval'.eval_code_block()<cr>", { desc = "eval", exit = true } },
		{ "<Esc>", nil, { exit = true, nowait = true, desc = false } },
	},
})

local diagram_hydra = Hydra({
	name = "Draw Diagram",
	hint = [[
 Arrow^^^^^^   Select region with <C-v>
 ^ ^ _K_ ^ ^   _f_: surround it with box
 _H_ ^ ^ _L_
 ^ ^ _J_ ^ ^
]],
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

local header_hydra = Hydra({
	name = "Header",
	hint = [[
 _>_: denote            _<_: promote
]],
	config = {
		buffer = true,
		invoke_on_body = true,
		color = "teal",
		hint = {
			border = "rounded",
		},
	},
	heads = {
		{ ">", "<ESC>^a#<esc>", { exit = false, desc = "header" } },
		{ "<", "<ESC>^x", { exit= false, desc = "header" } },
		{ "<Esc>", "<Cmd>MarkdownPreviewStop<CR>", { exit = true, nowait = true, desc = false } },
	},
})

local text_hydra = Hydra({
	name = "Markdown",
	config = {
		buffer = true,
		invoke_on_body = true,
	},
	heads = {
		{ "l", "I- <esc>", { desc = "make list", exit = true } },
		{
			"h",
			function()
				header_hydra:activate()
			end,
			{ nowait = true, exit = true, desc = "header" },
		},
		{ "<Esc>", nil, { exit = true, nowait = true, desc = false } },
	},
})

Hydra({
	name = "Markdown",
	hint = [[
 _t_: table        _d_: diagram
 _p_: preview      _s_: server
 _i_: paste link   _c_: code ^
 _x_: text

 <c-r> toggle list type (insert)
]],
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
		{
			"t",
			function()
				table_hydra_normal:activate()
			end,
		},
		{
			"d",
			function()
				diagram_hydra:activate()
			end,
		},
		{ "i", ":PasteMDLink<cr>", { nowait = true, exit = true, desc = "Insert link" } },
		{
			"c",
			function()
				code_hydra:activate()
			end,
			{ nowait = true, exit = true, desc = "Edit code block" },
		},
		{ "p", "<Cmd>MarkdownPreview<CR>", { nowait = true } },
		{
			"s",
			"<cmd>lua require('user.core.utils').toggle_term_cmd('cd $ZK_NOTEBOOK_DIR && markserv', {direction = 'horizontal'})<CR>",
			{ desc = false, nowait = true, exit = true },
		},
		{
			"x",
			function()
				text_hydra:activate()
			end,
			{ exit = true },
		},
		{ "<Esc>", "<Cmd>MarkdownPreviewStop<CR>", { exit = true, nowait = true, desc = false } },
	},
})

Hydra({
	name = "Markdown",
	hint = [[
 _b_: bold            _i_: italic
 _c_: code            _s_: strikethrough
 _t_: to ascii tree   _u_: from ascii tree ^
 _l_: make list

]],
	config = {
		buffer = true,
		invoke_on_body = true,
		color = "teal",
		hint = {
			border = "rounded",
		},
	},
	mode = { "v" },
	body = "<leader>m",
	heads = {
		{ "b", "di**<esc>pa**<esc>", { nowait = true, exit = true, desc = "bold" } },
		{ "i", "di_<esc>pa_<esc>", { nowait = true, exit = true, desc = "italic" } },
		{ "c", "di`<esc>pa`<esc>", { nowait = true, exit = true, desc = "code" } },
		{ "s", "di~~<esc>pa~~<esc>", { nowait = true, exit = true, desc = "strikethrough" } },
		{ "t", ":AsciiTree<cr>", { desc = "ascii tree", exit = true } },
		{ "u", ":AsciiTreeUndo<cr>", { desc = "ascii tree", exit = true } },
		{ "l", "I- <esc>", { desc = "make list", exit = true } },
		{ "<Esc>", "<Cmd>MarkdownPreviewStop<CR>", { exit = true, nowait = true, desc = false } },
	},
})

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<cr>",
	[[:lua vim.lsp.buf.definition()<CR>]],
	{ noremap = true, desc = "Go to Declaration" }
)

vim.api.nvim_buf_set_keymap(0, "n", "<bs>", [[:ZkBacklinks<CR>]], { noremap = true, desc = "Back links" })
