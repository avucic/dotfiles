local M = {}

function M.setup(Hydra, _, _)
  local hint = [[
  _i_: inflect          _dt_: base64 decode token
 _ea_: easyalign
]]

  Hydra({
    name = "Text",
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
    body = "<Leader>x",
    mode = "v",
    heads = {
      -- { "gf", "<Plug>(grammarous-fixit)", { desc = "Fix the error under the cursor" } },
      -- { "gq", "<Plug>(grammarous-close-info-window)", { desc = "Close the information window" } },
      -- { "ge", "<Plug>(grammarous-remove-error)", { desc = "Remove the error under the cursor" } },
      -- { "gn", "<Plug>(grammarous-move-to-next-error)", { desc = "Move cursor to the next error" } },
      -- { "gp", "<Plug>(grammarous-move-to-previous-error)", { desc = "Move cursor to the previous error" } },
      -- { "gd", "<Plug>(grammarous-disable-rule)", { desc = "Disable the grammar rule under the cursor" } },
      -- ["J"] = { ":move '>+1<CR>gv-gv" },
      -- ["K"] = { ":move '<-2<CR>gv-gv" },
      -- ["A-j"] = { ":move '>+1<CR>gv-gv" },
      -- ["A-k"] = { ":move '<-2<CR>gv-gv" },
      -- -- EasyAlign
      -- ["ga"] = { "<Plug>(EasyAlign)" },

      { "i", "<Plug>(Inflect)", { desc = "Inflect", nowait = true, exit = true } },
      { "ea", "<Plug>(EasyAlign)", { desc = "EasyAlign", nowait = true, exit = true } },
      {
        "dt",
        [[<cmd>lua print(io.popen("jwt decode ".. vim.fn.getreg('"') or ""):read("*a"))<cr>]],
        { desc = "Base64 Decode token", exit = true },
        -- eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTc1MjYxMjAsImlhdCI6MTY1NzUyNTU4MCwibmJmIjoxNDQ0NDc4NDAwLCJzY29wZXMiOlsiYXBpOnJlYWQiLCJhcGk6d3JpdGUiXX0.hQQ2vWMmrh_wugiNPc1UzqOgkPFD9FfMFU_tenqA0TI
      },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M