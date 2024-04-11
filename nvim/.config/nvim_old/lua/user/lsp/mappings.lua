local open_diagnostic = function()
  local opts = {
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = "rounded",
    source = "always",
    prefix = " ",
    scope = "cursor",
  }
  vim.diagnostic.open_float(nil, opts)
end
return {
  n = {
    ["gr"] = "<cmd>Glance references<cr>",
    ["<c-space>"] = { open_diagnostic },
    ["gd"] = { "<cmd>Glance definitions<cr>", desc = "Glance definitions" },
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Declaration" },
  },
}
