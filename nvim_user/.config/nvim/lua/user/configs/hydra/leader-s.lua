local M = {}

function M.setup(Hydra, cmd, _)
  local hint = [[
  _h_: vim help       _;_: commands history
  _k_: keymaps        _c_: execute command
  _O_: options        _b_: buffers
  _w_: search web     _t_: tasks
  _s_: doc symbols    _S_: workspace symbols
  _o_: outline

  _r_: resume         _<Enter>_: Telescope
]]

  Hydra({
    name = "Search",
    config = {
      on_key = false,
      invoke_on_body = true,
    },
    mode = "v",
    body = "<Leader>s",
    heads = {
      { "w", ":'<,'>BrowserSearch<cr>" },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })

  Hydra({
    name = "Search",
    hint = hint,
    config = {
      on_key = false,
      invoke_on_body = true,
      color = "pink",
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    mode = "n",
    body = "<Leader>s",
    heads = {
      { "h", "<cmd>lua require('telescope.builtin').help_tags()<CR>", { exit = true } },
      -- { "k", "<cmd>lua require('legendary').find({kind = 'keymaps'})<CR>", { exit = true } },
      { "k", "<cmd>lua require('telescope.builtin').keymaps()<CR>", { exit = true } },
      -- { "s", "<cmd>AerialToggle! right<cr>", { exit = true } },
      { "s", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", { exit = true } },
      { "S", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", { exit = true } },
      { "o", "<cmd>Telescope aerial<cr>", { desc = "Symbols Outline in Telescope" } },
      { "O", "<cmd>lua require('telescope.builtin').vim_options()<CR>", { exit = true } },
      { ";", "<cmd>lua require('telescope.builtin').command_history()<CR>", { exit = true } },
      { "c", "<cmd>lua require('telescope.builtin').commands()<CR>", { exit = true } },
      { "r", "<cmd>lua require('telescope.builtin').resume()<CR>", { exit = true } },
      { "b", "<cmd>lua require('telescope.builtin').buffers()<CR>", { exit = true } },
      { "w", "<cmd>BrowserSearch<cr>" },
      { "t", "<cmd>lua require('telescope').extensions.vstask.tasks()<cr>", { desc = "Tasks", exit = true } },
      { "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
