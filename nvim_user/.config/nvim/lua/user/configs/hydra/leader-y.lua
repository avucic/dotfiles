local M = {}

function M.setup(Hydra, _, _)
  local hint = [[
  _y_: history            _m_: macro history ^^
  _D_: clear history
]]

  Hydra({
    name = "Yank",
    hint = hint,
    config = {
      on_key = false,
      invoke_on_body = true,
      -- color = "teal",
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    mode = "n",
    body = "<Leader>y",
    heads = {
      { "y", "<cmd>lua require('telescope').extensions.neoclip.default()<cr>", { desc = "History", exit = true } },
      {
        "m",
        "<cmd>lua require('telescope').extensions.macroscope.default()<cr>",
        { desc = "Macro History", exit = true },
      },
      { "D", "<cmd>lua require('neoclip').clear_history()<cr>", { desc = "Clear History", exit = true } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
