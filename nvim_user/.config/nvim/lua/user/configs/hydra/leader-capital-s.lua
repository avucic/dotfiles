local M = {}

function M.setup(Hydra, _, _)
  local hint = [[
  _l_: load last           _f_: load  ^
  _d_: delete              _s_: save
  _._: load current dir
]]

  Hydra({
    name = "Session",
    hint = hint,
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
    body = "<Leader>S",
    heads = {
      { "l", "<cmd>SessionManager! load_last_session<cr>" },
      { "s", "<cmd>SessionManager! save_current_session<cr>" },
      { "d", "<cmd>SessionManager! delete_session<cr>" },
      { "f", "<cmd>SessionManager! load_session<cr>" },
      { ".", "<cmd>SessionManager! load_current_dir_session<cr>" },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
