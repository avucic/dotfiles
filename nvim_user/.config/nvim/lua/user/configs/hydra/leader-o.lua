local M = {}

function M.setup(Hydra, _, _)
  Hydra({
    name = "Open",
    hint = [[
   _o_: symbols outline           _c_: open calendar
  _do_: open db                  _dt_: toggle db
   _t_: tasks
]],
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
    body = "<Leader>o",
    heads = {
      { "o", "<cmd>AerialToggle! right<cr>", { desc = "Symbols Outline" } },
      { "t", "<cmd>lua require('telescope').extensions.vstask.tasks()<cr>" },
      {
        "do",
        "<cmd>lua require('user.configs.dadbod').db_tasks()<cr>",
        { desc = "Open DB Connection", exit = true },
      },
      {
        "dt",
        "<cmd>DBUIToggle<cr>",
        { desc = "Toggle DB Connection" },
      },
      {
        "c",
        "<cmd>lua require('user.core.utils').toggle_term_cmd('calcurse', {direction = 'float'})<CR>",
        { exit = true },
      },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
