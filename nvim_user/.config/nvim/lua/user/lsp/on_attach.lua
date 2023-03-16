local open_diagnostic = function()
  local opts = {
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = "rounded",
    source = "always",
    -- prefix = " ",
    scope = "cursor",
  }
  vim.diagnostic.open_float(nil, opts)
end

return function(client, bufnr)
  if vim.g.autoformat_range_only_enabled == true and vim.g.autoformat_enabled == true then
    vim.notify("Both options are enabled: autoformat_range_only_enabled  and  autoformat_enabled", vim.log.levels.ERROR)
  end

  if vim.g.autoformat_range_only_enabled == true then
    vim.g.autoformat_enabled = false

    if client.server_capabilities.documentRangeFormattingProvider then
      local lsp_format_modifications = require("lsp-format-modifications")
      lsp_format_modifications.attach(client, bufnr, {
        format_on_save = true,
        format_callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
  end

  if vim.g.lsp_virtual_text_style == "popup" then
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      underline = true,
      signs = true,
    })

    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = open_diagnostic,
    })
  end
end
