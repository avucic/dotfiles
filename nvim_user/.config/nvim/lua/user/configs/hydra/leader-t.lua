local M = {}

function M.setup(Hydra, _, _)
  local hint = [[
  _zp_: poet mode               _zf_: focus mode
  _zm_: minimalist mode         _mm_: Minimap toggle^^
]]

  Hydra({
    name = "Toggle",
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
    body = "<Leader>t",
    heads = {
      { "zp", "<cmd>TZAtaraxis<cr>", { desc = "Poet mode", exit = true } },
      { "zf", "<cmd>TZFocus<cr>", { desc = "Focus mode", exit = true } },
      { "zm", "<cmd>TZMinimalist<cr>", { desc = "Minimalist mode", exit = true } },
      { "mm", "<cmd>MinimapToggle<cr>", { desc = "Minimap" } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
