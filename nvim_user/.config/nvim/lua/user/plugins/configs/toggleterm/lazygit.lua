local Terminal = require("toggleterm.terminal").Terminal
local lg_cmd = "lazygit"

-- function Edit(fn, line_number)
--   local edit_cmd = string.format(":e %s", fn)
--   if line_number ~= nil then
--     edit_cmd = string.format(":e +%d %s", line_number, fn)
--   end
--   vim.cmd(edit_cmd)
-- end

vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"

local lazygit = Terminal:new({
  cmd = lg_cmd,
  count = 5,
  direction = "float",
  highlights = {
    NormalFloat = {},
  },
  float_opts = {
    -- width = function()
    --   return vim.o.columns
    -- end,
    -- height = function()
    --   return vim.o.lines
    -- end,
  },
  -- function to run on opening the terminal
  on_open = function(term)
    -- vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
})

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end
