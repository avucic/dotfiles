local M = {}

function M.setup(Hydra, cmd, _)
  local hint = [[
  _h_: vim help       _;_: commands history
  _k_: keymaps        _c_: execute command
  _O_: options        _b_: buffers
  _w_: search web     _t_: tasks
  _s_: symbols

  _r_: resume         _<Enter>_: Telescope
]]

  Hydra({
    name = "Search",
    hint = hint,
    config = {
      on_key = false,
      invoke_on_body = true,
      -- color = "pink",
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    mode = "n",
    body = "<Leader>s",
    heads = {
      { "h", "<cmd>lua require('telescope.builtin').help_tags()<CR>", { exit = true } },
      { "k", "<cmd>lua require('legendary').find({kind = 'keymaps'})<CR>", { exit = true } },
      -- { "k", "<cmd>lua require('telescope.builtin').keymaps()<CR>", { exit = true } },
      { "s", "<cmd>AerialToggle! right<cr>", { exit = true } },
      { "O", "<cmd>lua require('telescope.builtin').vim_options()<CR>", { exit = true } },
      { ";", "<cmd>lua require('telescope.builtin').command_history()<CR>", { exit = true } },
      { "c", "<cmd>lua require('telescope.builtin').commands()<CR>", { exit = true } },
      { "r", "<cmd>lua require('telescope.builtin').resume()<CR>", { exit = true } },
      { "b", "<cmd>lua require('telescope.builtin').buffers()<CR>", { exit = true } },
      { "w", "<cdm>BrowserSearch<cr>" },
      { "t", "<cmd>lua require('telescope').extensions.vstask.tasks()<cr>", { desc = "Tasks", exit = true } },
      { "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
