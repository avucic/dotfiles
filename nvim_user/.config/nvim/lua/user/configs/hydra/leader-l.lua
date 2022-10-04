local M = {}

function M.setup(Hydra, _, _)
  local lsp_hint = [[
  _a_: code action   _d_: document diagnostics
  _f_: format        _w_: workspace diagnostics
  _i_: info          _n_: next diagnostic
  _r_: references    _p_: prev diagnostic
  _l_: code lens     _q_: quick fix
  _R_: rename        _K_: symbol details
]]

  Hydra({
    name = "Lsp",
    hint = lsp_hint,
    config = {
      on_key = false,
      invoke_on_body = true,
      color = "pink",
      timeout = 5000,
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
      { "d", "<cmd>Telescope diagnostics bufnr=0<cr>", { exit = true } },
      { "w", "<cmd>Telescope diagnostics<cr>", { exit = true } },
      { "f", "<cmd>lua vim.lsp.buf.format({async = true })<cr>", { exit = true } },
      -- { "f", "<cmd>lua vim.lsp.buf.formatting()<cr>", { exit = true } },
      { "i", "<cmd>LspInfo<cr>", { exit = true } },
      -- { "I", "<cmd>LspInstallInfo<cr>", { exit = true }},
      { "n", "<cmd>lua vim.diagnostic.goto_next()<CR>" },
      { "p", "<cmd>lua vim.diagnostic.goto_prev()<cr>" },
      { "l", "<cmd>lua vim.lsp.codelens.run()<cr>", { exit = true } },
      { "q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", { exit = true } },
      { "R", "<cmd>lua vim.lsp.buf.rename()<cr>", { exit = true } },
      { "r", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", { exit = true } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
