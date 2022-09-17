local M = {}

function M.setup(Hydra, _, _)
  local hint = [[
   _h_: previous                   _l_: next
   _H_: move previous              _L_: move next
   _b_: list                       _P_: pin
   _p_: pick                       _D_: close others
  _oe_: sort by extension         _od_: sort by directory ^ ^
  _or_: sort by relative dir       _q_: quit
]]

  Hydra({
    name = "Buffers",
    hint = hint,
    config = {
      invoke_on_body = true,
      -- color = "pink",
      hint = {
        border = "rounded",
        offset = -1,
        show_name = true,
      },
    },
    mode = "n",
    body = "<leader>b",
    heads = {
      {
        "b",
        "<cmd>lua require('telescope.builtin').buffers()<CR>",
        { on_key = false, exit = true },
      },
      {
        "h",
        function()
          vim.cmd("BufferLineCyclePrev")
        end,
        { on_key = false },
      },
      {
        "l",
        function()
          vim.cmd("BufferLineCycleNext")
        end,
        { desc = "choose", on_key = false },
      },

      {
        "H",
        function()
          vim.cmd("BufferLineMovePrev")
        end,
      },
      {
        "L",
        function()
          vim.cmd("BufferLineMoveNext")
        end,
        { desc = "move" },
      },
      {
        "q",
        function()
          vim.cmd("Bdelete!")
        end,
        { desc = "close" },
      },
      {
        "P",
        function()
          vim.cmd("BufferLIneTogglePin")
        end,
        { desc = "pin" },
      },
      {
        "D",
        "<cmd>w | %bd | e#<CR>",
        { desc = "close others" },
      },

      {
        "p",
        function()
          vim.cmd("BufferLinePick")
        end,
        { desc = "close others" },
      },
      {
        "oe",
        function()
          vim.cmd("BufferLineSortByExtension")
        end,
        { desc = "by directory" },
      },
      {
        "od",
        function()
          vim.cmd("BufferLineSortByDirectory")
        end,
        { desc = "by directory" },
      },
      {
        "or",
        function()
          vim.cmd("BufferLineSortByRelativeDirectory")
        end,
        { desc = "by directory" },
      },
      { "<Esc>", nil, { exit = true, desc = false } },
    },
  })
end

return M
