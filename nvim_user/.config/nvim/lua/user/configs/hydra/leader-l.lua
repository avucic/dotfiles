local M = {}

function M.setup(Hydra, _, _)
  local lsp_hint = [[
  _a_: code action       _i_: implementation
  _d_: declaration       _D_: definition
  _f_: format            _w_: workspace diagnostics
  _I_: info              _n_: next diagnostic
  _r_: references        _p_: prev diagnostic
  _l_: code lens         _e_: diagnostics
  _R_: rename            _K_: symbol details
]]

  Hydra({
    name = "Lsp",
    hint = lsp_hint,
    config = {
      on_key = false,
      invoke_on_body = true,
      color = "pink",
      -- timeout = 5000,
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    mode = "n",
    body = "<Leader>l",
    heads = {

      {
        "K",
        function()
          vim.lsp.buf.hover()
        end,
        { desc = "Hover symbol details", exit = true },
      },
      { "a", "<cmd>lua vim.lsp.buf.code_action()<cr>", { exit = true } },
      { "e", "<cmd>Telescope diagnostics bufnr=0<cr>", { exit = true } },
      { "d", "<cmd>lua vim.lsp.buf.declaration()<CR>", { exit = true } },
      { "D", "<cmd>lua vim.lsp.buf.definition()<CR>", { exit = true } },
      { "w", "<cmd>Telescope diagnostics<cr>", { exit = true } },
      { "f", "<cmd>lua vim.lsp.buf.format({async = true })<cr>", { exit = true } },
      -- { "f", "<cmd>lua vim.lsp.buf.formatting()<cr>", { exit = true } },
      { "i", "<cmd>lua vim.lsp.buf.implementation()<CR>", { exit = true } },
      { "I", "<cmd>Mason<cr>", { exit = true } },
      -- { "I", "<cmd>LspInstallInfo<cr>", { exit = true }},
      { "n", "<cmd>lua vim.diagnostic.goto_next()<CR>" },
      { "p", "<cmd>lua vim.diagnostic.goto_prev()<cr>" },
      { "l", "<cmd>lua vim.lsp.codelens.run()<cr>", { exit = true } },
      -- { "q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", { exit = true } },
      { "R", "<cmd>lua vim.lsp.buf.rename()<cr>", { exit = true } },
      { "r", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", { exit = true } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M

-- See `:help vim.lsp.*` for documentation on any of the below functions
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>i', '<cmd>Telescope lsp_document_symbols<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>I', '<cmd>Telescope lsp_workspace_symbols<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>to', '<cmd>SymbolsOutline<CR>', opts)
