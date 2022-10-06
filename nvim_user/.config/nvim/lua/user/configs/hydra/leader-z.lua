local M = {}

function M.setup(Hydra, _, _)
  local hint = [[
  _n_: next         _p_: previous
  _a_: add word     _c_: corrct
  _l_: list
]]

  Hydra({
    name = "Spelling",
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
    body = "<Leader>z",
    heads = {
      { "n", "]s", { desc = "Next" } },
      { "p", "[s", { desc = "Previous" } },
      { "a", "zg", { desc = "Add word" } },
      { "c", "1z=", { desc = "Use 1. correction" } },
      {
        "l",
        "<cmd>lua require('telescope.builtin').spell_suggest()<cr>",
        { desc = "List corrections", exit = true },
      },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
