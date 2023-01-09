local Hydra = require("hydra")
local toggle_inley_hints = function()
	if vim.g._rust_inlay_hint_enabled == true then
		vim.g._rust_inlay_hint_enabled = false
		require("rust-tools").inlay_hints.disable()
	else
		vim.g._rust_inlay_hint_enabled = true
		require("rust-tools").inlay_hints.enable()
	end
end

local toggle_hydra = Hydra({
	name = "Toggle",
	heads = {
		{ "h", toggle_inley_hints, { desc = "inley hints", exit = true } },
		{ "<Esc>", nil, { exit = true, nowait = true, desc = false } },
	},
})

Hydra({
	name = "Rust",
	hint = [[
 _c_: cargo               _u_: toggle
 _e_: expand
]],
	config = {
		on_key = false,
		buffer = true,
		invoke_on_body = true,
		-- color = "pink",
		hint = {
			border = "rounded",
		},
	},
	mode = "n",
	body = "<leader>m",
	heads = {
		{
			"u",
			function()
				toggle_hydra:activate()
			end,
			{ nowait = true, exit = true, desc = "Edit code block" },
		},
		{ "c", "<cmd>RustOpenCargo<cr>", exit =true },
		{ "e", "<cmd>lua require'rust-tools'.expand_macro.expand_macro()<cr>" },

		{ "<Esc>", nil, { exit = true, nowait = true, desc = false } },
	},
})

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"gK",
	"<cmd>lua require('rust-tools.external_docs').open_external_docs()<cr>",
	{ noremap = true, desc = "Back links" }
)

vim.api.nvim_buf_set_keymap(0, "n", "<bs>", [[:RustParentModule<CR>]], { noremap = true, desc = "Back links" })
