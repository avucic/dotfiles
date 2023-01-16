local M = {}

M.change_tab = function(motion)
  local last_buffer_id = vim.fn.bufnr()
  local last_buffer_name = vim.fn.expand("%")

  if motion == "next" then
    vim.cmd([[BufferLineCycleWindowlessNext]])
  elseif motion == "prev" then
    vim.cmd([[BufferLineCycleWindowlessPrev]])
  else
    error("Invalid motion: " .. motion)
    return
  end

  if last_buffer_name == "" then
    vim.cmd("bd " .. last_buffer_id)
  end
end

function M.setup(Hydra, _, _)
  local hint = [[
   _h_: previous                   _l_: next
   _H_: move previous              _L_: move next
   _b_: list                       _P_: pin
   _p_: pick                       _o_: close others
  _se_: sort by extension         _sd_: sort by directory ^ ^
  _sr_: sort by relative dir       _q_: quit
   _;_: toggle cycling
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
          -- vim.cmd("BufferLineCyclePrev")
          M.change_tab("prev")
        end,
        { on_key = false },
      },
      {
        "l",
        function()
          -- vim.cmd("BufferLineCycleNext")
          M.change_tab("next")
        end,
        { desc = "choose", on_key = false },
      },
      {
        ";",
        function()
          vim.cmd("BufferLineCycleWindowlessToggle")
        end,
        { desc = "toggle cycling" },
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
        "o",
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
        "se",
        function()
          vim.cmd("BufferLineSortByExtension")
        end,
        { desc = "by directory" },
      },
      {
        "sd",
        function()
          vim.cmd("BufferLineSortByDirectory")
        end,
        { desc = "by directory" },
      },
      {
        "sr",
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
