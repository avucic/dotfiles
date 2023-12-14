-- local utils = require("astronvim.utils")
-- local tbl_isempty = vim.tbl_isempty
-- local tbl_contains = vim.tbl_contains
-- local lsp_formatting_options = require("astronvim.utils.lsp")["formatting"]

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

vim.diagnostic.config({
  signs = {
    priority = 8,
  },
})

local disable_formatting = function(client)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
end

-- local has_capability = function(capability, filter)
--   for _, client in ipairs(vim.lsp.get_active_clients(filter)) do
--     if client.supports_method(capability) then
--       return true
--     end
--   end
--   return false
-- end
--
-- local function del_buffer_autocmd(augroup, bufnr)
--   local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
--   if cmds_found then
--     vim.tbl_map(function(cmd)
--       vim.api.nvim_del_autocmd(cmd.id)
--     end, cmds)
--   end
-- end

return function(client, bufnr)
  --  Fix for jumping on save
  --  https://github.com/neovim/neovim/issues/24297#issuecomment-1782245297
  -- local autoformat = lsp_formatting_options.format_on_save
  -- local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
  --
  -- if
  --     autoformat.enabled
  --     and (tbl_isempty(autoformat.allow_filetypes or {}) or tbl_contains(autoformat.allow_filetypes, filetype))
  --     and (tbl_isempty(autoformat.ignore_filetypes or {}) or not tbl_contains(autoformat.ignore_filetypes, filetype))
  -- then
  --   vim.api.nvim_create_autocmd("BufWritePre", {
  --     group = vim.api.nvim_create_augroup("add_buffer_autocmd", {}),
  --     callback = function()
  --       if not has_capability("textDocument/formatting", { bufnr = bufnr }) then
  --         del_buffer_autocmd("lsp_auto_format", bufnr)
  --         return
  --       end
  --
  --       local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  --       vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  --       vim.lsp.buf.format(utils.extend_tbl(lsp_formatting_options, { bufnr = bufnr }))
  --     end,
  --   })
  -- end
  -- end fix

  -- TODO: LSPAttach event
  -- require("lsp_signature").on_attach(client, bufnr)
  -- if client.server_capabilities.documentSymbolsProvider then
  --   require("nvim-navbuddy").attach(client, bufnr)
  -- end

  if client.name == "tailwindcss" then
    require("telescope").load_extension("tailiscope")
    vim.keymap.set("n", "<leader>oK", "<cmd>Telescope tailiscope<cr>", { desc = "Tailwind docs" })
  end

  -- TODO: why settings doesn't work?
  if client.name == "lua_ls" then
    disable_formatting(client)
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
