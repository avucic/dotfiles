return function(_, _)
  local rt = require("rust-tools")

  require("rust-tools").setup({
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(
        "/Users/vucinjo/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb",
        "/Users/vucinjo/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib"
      ),
    },
    server = {
      standalone = false,
      on_attach = function(_, bufnr)
        -- Hover actions
        vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
        -- Code action groups
        -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        vim.keymap.set("n", "gd", "<cmd>Glance definitions<cr>", { buffer = bufnr, desc = "Glance definitions" })
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { buffer = bufnr, desc = "Declaration" })
      end,
      settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
            extraArgs = { "--all", "--", "-W", "clippy::all" },
          },
        },
      },
    },
  })
end
