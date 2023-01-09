local M = {}

function M.setup(Hydra, _, _)
  Hydra({
    name = "Lsp",
    hint = [[
   _a_: code action              _f_: format   ^
]],
    config = {
      on_key = false,
      invoke_on_body = true,
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    mode = "v",
    body = "<Leader>l",
    heads = {
      { "a", "<cmd>lua vim.lsp.buf.code_action()<cr>", { exit = true } },
      { "f", "<cmd>lua vim.lsp.buf.format({async = true })<cr>", { exit = true } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })

  Hydra({
    name = "Lsp",
    hint = [[
   _a_: code action              _i_: implementation
   _D_: declaration              _d_: definition
   _E_: workspace diagnostics    _e_: diagnostics
   _f_: format                   _l_: code lens
   _I_: info                     _n_: next diagnostic
   _r_: references               _p_: prev diagnostic
   _R_: rename                   _K_: symbol details
  _wa_: add workspace           _wr_: remove workspace ^
]],
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
          if vim.o.filetype == "rust" then
            require("rust-tools").hover_actions.hover_actions()
          else
            vim.lsp.buf.hover()
          end
        end,
        { desc = "Hover symbol details", exit = true },
      },
      { "a", "<cmd>lua vim.lsp.buf.code_action()<cr>", { exit = true } },
      { "e", "<cmd>Telescope diagnostics bufnr=0<cr>", { exit = true } },
      { "E", "<cmd>Telescope diagnostics<cr>", { exit = true } },
      { "D", "<cmd>lua vim.lsp.buf.declaration()<CR>", { exit = true } },
      -- { "d", "<cmd>lua vim.lsp.buf.definition()<CR>", { exit = true } },
      { "d", "<cmd>Glance definitions<CR>", { exit = true } },
      { "wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", { exit = true } },
      { "wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", { exit = true } },

      { "f", "<cmd>lua vim.lsp.buf.format({async = true })<cr>", { exit = true } },
      -- { "f", "<cmd>lua vim.lsp.buf.formatting()<cr>", { exit = true } },
      { "i", "<cmd>lua vim.lsp.buf.implementation()<CR>", { exit = true } },
      { "I", "<cmd>Mason<cr>", { exit = true } },
      -- { "I", "<cmd>LspInstallInfo<cr>", { exit = true }},
      { "n", "<cmd>lua vim.diagnostic.goto_next()<CR>" },
      { "p", "<cmd>lua vim.diagnostic.goto_prev()<cr>" },
      { "l", "<cmd>lua vim.lsp.codelens.run()<cr>", { exit = true } },
      -- { "q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", { exit = true } },
      {
        "R",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        {
          expr = true,
          exit = true,
        },
      },
      -- { "r", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", { exit = true } },
      { "r", "<cmd>Glance references<CR>", { exit = true } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
