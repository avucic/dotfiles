local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return function(client, bufnr)
  if vim.g.autoformat_enabled ~= true then
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

  -- local lsp_signature = require("user.core.utils").load_module("lsp_signature")
  -- if lsp_signature then
  --     lsp_signature.on_attach({
  --         bind = true, -- This is mandatory, otherwise border config won't get registered.
  --         handler_opts = {
  --             border = "rounded",
  --         },
  --     }, bufnr)
  -- end

  if vim.g.lsp_virtual_text_style == "popup" then
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      underline = true,
      signs = true,
    })
    --
    --   local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
    --   vim.api.nvim_create_autocmd("CursorHold", {
    --     callback = function()
    --       vim.diagnostic.open_float(nil, { focusable = false })
    --     end,
    --     group = diag_float_grp,
    --   })
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = open_diagnostic,
    })
  end
end
