local M = {}


function M.setup(Hydra, _, _)
  local tasks_hydra = Hydra({
    name = "Tasks",
    config = {
      on_key = false,
      invoke_on_body = true,
      color = "teal",
    },
    heads = {
      { "t", "<cmd>Telescope toggletasks spawn<cr>", {desc ="new" }},
      { "l", "<cmd>Telescope toggletasks select<cr>", {desc  = "select" }},
        { "e", "<cmd>Telescope toggletasks edit<cr>", {desc = "edit" }},
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })

  Hydra({
    name = "Open",
    hint = [[
   _o_: symbols outline           _c_: open calendar  ^
  _do_: open db                  _dt_: toggle db
   _t_: tasks                     _g_: ChatGPT
]],
    config = {
      on_key = false,
      invoke_on_body = true,
      color = "teal",
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    mode = "n",
    body = "<Leader>o",
    heads = {
      { "o", "<cmd>AerialToggle! right<cr>", { desc = "Symbols Outline" } },
      { "g", "<cmd>ChatGPT<cr>" },
      { "t", function ()
        tasks_hydra:activate()
      end},
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
