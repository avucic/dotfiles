local M = {}

function M.config()
  local rt = require("user.core.utils").load_module("rust-tools")
  if not rt then
    return {}
  end

  local config = {
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(
        "/Users/vucinjo/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb",
        "/Users/vucinjo/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib"
      ),
    },
    server = astronvim.lsp.server_settings("rust_analyzer"),
  }
  rt.setup(config)

  -- rt.setup({
  --   dap = {
  --     adapter = require("rust-tools.dap").get_codelldb_adapter(
  --       "/Users/vucinjo/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb",
  --       "/Users/vucinjo/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib"
  --     ),
  --   },
  --   settings = astronvim.lsp.server_settings("rust_analyzer"),
  --   --     server = {
  --   --       settings = {
  --   --         cargo = {
  --   -- target = "disabled"
  --   --         },
  --   --         ["rust-analyzer"] = {
  --   --           inlayHints = { locationLinks = false },
  --   --         },
  --   --       },
  --   --     },
  --   -- server = {
  --   --   on_attach = function(_, bufnr)
  --   --     -- Hover actions
  --   --     vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
  --   --     -- Code action groups
  --   --     vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
  --   --   end,
  --   -- },
  -- })
end

return M
