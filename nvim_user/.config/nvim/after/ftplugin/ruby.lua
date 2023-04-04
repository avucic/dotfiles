local map = require("user.core.utils").define_sts_jump_keymap
map("a", { "parameter_list" }, "Parameter list")
map("m", { "def" }, "Function")
map("c", { "comment" }, "Comment")

local wk = require("which-key")

wk.register({
	["<leader>m"] = {
		name = "+Rust",
		t = {
			name = "+Tasks",
			t = { "<cmd>lua require('neotest').run.run()<cr>", "Run current spec" },
			f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run current file specs" },
			a = { "<cmd>lua require('neotest').run.run(vim.fn.getcws())<cr>", "Run all specs" },
			o = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Specs outline" },
		},
		d = {
			name = "+Deubg",
			d = { "<cmd>RustDebuggables<cr>", "Start" },
			l = { "<cmd>RustLastDebug<cr>", "Last" },
		},
	},
}, { buffer = 0, mode = "n" })

-- local M = {}
--
-- M.configurations = function()
--   return {
--     {
--       type = "ruby",
--       name = "Attach with rdbg",
--       request = "attach",
--       localfs = true,
--     },
--     {
--       type = "ruby",
--       name = "Debug current file",
--       request = "launch",
--       localfs = true,
--       command = "ruby",
--       script = "${file}",
--     },
--     {
--       type = "ruby",
--       name = "Run spec current file",
--       request = "launch",
--       localfs = true,
--       command = "rspec",
--       script = "${file}",
--     },
--     {
--       type = "ruby",
--       name = "Run current spec",
--       request = "launch",
--       localfs = true,
--       command = "rspec",
--       script = "${file}",
--       current_line = true,
--     },
--   }
-- end
--
-- M.adapter = function()
--   return function(callback, config)
--     if config.request == "attach" then
--       callback({
--         type = "server",
--         port = "12345",
--       })
--     else
--       local script
--       if config.current_line then
--         script = config.script .. ":" .. vim.fn.line(".")
--       else
--         script = config.script
--       end
--       callback({
--         type = "server",
--         port = "${port}",
--         executable = {
--           command = "bundle",
--           args = {
--             "exec",
--             "rdbg",
--             "--stop-at-load",
--             "--open",
--             "--host",
--             "127.0.0.1",
--             "--port",
--             "${port}",
--             "--command",
--             "--",
--             "bundle",
--             "exec",
--             config.command,
--             script,
--           },
--         },
--       })
--     end
--   end
-- end
--
-- return M
