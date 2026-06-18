-- local map = require("user.core.utils").define_sts_jump_keymap
-- map("a", { "parameter_list" }, "Parameter list")
-- map("m", { "def" }, "Function")
-- map("c", { "comment" }, "Comment")
--
--

local overseer = require "overseer"
local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
  "n",
  "<Leader>mtt",
  function() overseer.run_action(nil, "rspec - current spec") end,
  { desc = "Run current spec", buffer = bufnr }
)

-- local wk = require("which-key")
--
-- wk.register({
--   ["<leader>m"] = {
--     name = "+Ruby",
--     t = {
--       name = "+Tasks",
--       t = { "<cmd>lua require('neotest').run.run()<cr>", "Run current spec" },
--       f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run current file specs" },
--       a = { "<cmd>lua require('neotest').run.run(vim.fn.getcws())<cr>", "Run all specs" },
--       o = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Specs outline" },
--       e = { "<cmd>lua require('neotest').output.open({ enter = false })<cr>", "Specs output" },
--     },
--     d = {
--       name = "+Deubg",
--       d = { "<cmd>RustDebuggables<cr>", "Start" },
--       l = { "<cmd>RustLastDebug<cr>", "Last" },
--     },
--   },
-- }, { buffer = 0, mode = "n" })
