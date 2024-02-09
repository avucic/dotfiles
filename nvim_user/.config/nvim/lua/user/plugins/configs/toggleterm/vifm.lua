local Terminal = require("toggleterm.terminal").Terminal

function _VIFM_TOGGLE(dirArg)
  local lg_cmd = "vifm " .. (dirArg or "$PWD")

  local vifm = Terminal:new({
    cmd = lg_cmd,
    count = 5,
    direction = "float",
    border = "single",
    float_opts = {
      width = function()
        return math.floor(vim.o.columns * 0.5)
      end,

      height = function()
        return math.floor((vim.o.lines - vim.o.cmdheight) * 0.5)
      end,
    },
    -- function to run on opening the terminal
    on_open = function(term)
      -- vim.cmd("startinsert!")
      " --choose-files /tmp/fm-nvim " .. dir, "l"
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<cr>", "<cmd>edit<cr>", { noremap = true, silent = true })
    end,
  })

  vifm:toggle()
end
