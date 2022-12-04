local M = {}

function M.setup(Hydra, cmd, _)
  local hint = [[
   _o_: symbols outline          _tf_: float terminal ^
  _th_: horizontal terminal      _tv_: vertical terminal ^
  _tt_: tab terminal             _t._: terminal here
  _do_: open db                  _dt_: toggle db
   _c_: open calendar
]]

  Hydra({
    name = "Open",
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
    body = "<Leader>o",
    heads = {
      { "o", "<cmd>AerialToggle! right<cr>", { desc = "Symbols Outline", exit = true } },
      { "tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float", exit = true } },
      { "th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Horizontal", exit = true } },
      { "tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Vertical", exit = true } },
      { "tt", "<cmd>ToggleTerm  direction=tab<cr>", { desc = "Tab", exit = true } },
      { "t.", "<cmd>term<cr>", { desc = "Here", exit = true } },
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
