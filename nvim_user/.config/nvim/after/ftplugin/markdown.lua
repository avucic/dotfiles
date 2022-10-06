local Hydra = require("hydra")

local table_hint = [[
   _r_: realig         _dr_: delete row     _dc_: delete column
  _mt_: tableize       _ms_: sort table     _ic_: insert column after
  _fa_: add formula    _fe_: eval formula   _iC_: insert column before ^ ^
  _lr_: renumber list  _?_: echo cell map
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

local hint = [[
 _t_: table        _d_: diagram
 _p_: preview
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
		{ "p", "<Cmd>MarkdownPreview<CR>", { nowait = true } },
		{ "<Esc>", "<Cmd>MarkdownPreviewStop<CR>", { exit = true, nowait = true, desc = false } },
	},
})
