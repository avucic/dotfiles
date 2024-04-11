local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>dc", function()
  vim.cmd.RustLsp("debuggables")
  -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })

vim.keymap.set("n", "gD", "<cmd>Glance definitions<cr>", { silent = true, buffer = bufnr, desc = "Glance definitions" })
vim.keymap.set(
  "n",
  "gd",
  "<cmd>lua vim.lsp.buf.declaration()<cr>",
  { silent = true, buffer = bufnr, desc = "Declaration" }
)

-- local toggle_inley_hints = function()
--   if vim.g._rust_inlay_hint_enabled ~= true then
--     vim.g._rust_inlay_hint_enabled = true
--     require("rust-tools").inlay_hints.enable()
--   else
--     vim.g._rust_inlay_hint_enabled = false
--     require("rust-tools").inlay_hints.disable()
--   end
-- end

local map = require("user.core.utils").define_sts_jump_keymap
map("m", { "fn" }, "Fumc")
map("i", { "use", "mod" }, "Use or mod")
map("c", { "comment" }, "Comment")

local wk = require("which-key")

wk.register({
  -- ["<bs>"] = { "<cmd>RustParentModule<CR>", "Parent module" },
  -- ["gK"] = { "<cmd>lua require('rust-tools.external_docs').open_external_docs()<cr>", "External docs" },
  -- K = { "<cmd>lua require('rust-tools').hover_actions.hover_actions()<cr>", "External docs" },
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
      -- r = { "<cmd>RustRun<cr>", "Run" },
      t = { "<cmd>lua require('neotest').run.run()<cr>", "Run current spec" },
    },
    -- d = {
    --   name = "+Deubg",
    --   c = { "<cmd>RustDebuggables<cr>", "Start" },
    --   d = { "<cmd>RustDebuggables<cr>", "Start" },
    --   l = { "<cmd>RustLastDebug<cr>", "Last" },
    -- },
    --
    x = {
      name = "+Text",
      j = { "<cmd>RustMoveItemDown<cr>", "Move item down" },
      k = { "<cmd>RustMoveItemUp<cr>", "Move item up" },
    },
  },
}, { buffer = 0, mode = "n" })

wk.register({
  ["<leader>m"] = {
    name = "+Rust",
    o = { "diOption<<esc>pa><esc>", "Add option" },
    O = { "diOption<<esc>pa><esc>", "Remove option" },
    r = { "diResult<<esc>pa><esc>", "Add result" },
    R = { "diResult<<esc>pa><esc>", "Remove result" },
    s = { "diSome(<esc>pa)<esc>", "Add some" },
  },
}, { buffer = 0, mode = "v" })
