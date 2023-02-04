local toggle_inley_hints = function()
	if vim.g._rust_inlay_hint_enabled ~= true then
		vim.g._rust_inlay_hint_enabled = true
		require("rust-tools").inlay_hints.enable()
	else
		vim.g._rust_inlay_hint_enabled = false
		require("rust-tools").inlay_hints.disable()
	end
end

local map = require("user.core.utils").define_sts_jump_keymap
map("m", { "fn" }, "Fumc")
map("i", { "use", "mod" }, "Use or mod")
map("c", { "comment" }, "Comment")

local wk = require("which-key")

wk.register({
	["<bs>"] = { "<cmd>RustParentModule<CR>", "Parent module" },
	["gK"] = { "<cmd>lua require('rust-tools.external_docs').open_external_docs()<cr>", "External docs" },
	K = { "<cmd>lua require('rust-tools').hover_actions.hover_actions()<cr>", "External docs" },
	["<leader>m"] = {
		name = "+Rust",
		u = {
			name = "+UI",
			h = { toggle_inley_hints, "Toggle hint" },
		},
		e = { "<cmd>lua require'rust-tools'.expand_macro.expand_macro()<cr>", "Expand macro" },
		c = { "<cmd>RustOpenCargo<cr>", "Open cargo" },
		t = {
			name = "+Tasks",
			t = { "<cmd>RustRunnable<cr>", "Pick" },
			l = { "<cmd>RustLastRun<cr>", "Last" },
		},
		d = {
			name = "+Deubg",
			d = { "<cmd>RustDebuggables<cr>", "Start" },
			l = { "<cmd>RustLastDebug<cr>", "Last" },
		},
	},
}, { buffer = 0, mode = "n" })

wk.register({
	["<leader>m"] = {
		name = "+Rust",
		o = { "diOption<<esc>pa><esc>", "Add option" },
		O = { "diOption<<esc>pa><esc>", "Remove option" },
		s = { "diSome(<esc>pa)<esc>", "Add some" },
	},
}, { buffer = 0, mode = "v" })
