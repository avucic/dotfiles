local Terminal = require("toggleterm.terminal").Terminal

local tasks = Terminal:new({
  cmd = "tmuxp load tasks",
  direction = "float",
  hidden = true,
  close_on_exit = true,
  highlights = {
    NormalFloat = {},
  },
  float_opts = {
    width = function()
      return math.floor(vim.o.columns * 0.5)
    end,

    height = function()
      return math.floor((vim.o.lines - vim.o.cmdheight) * 0.5)
    end,
  },
})

function _TASKS_TOGGLE()
  tasks:toggle()
end
