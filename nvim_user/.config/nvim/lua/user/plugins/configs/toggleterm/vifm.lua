local Terminal = require("toggleterm.terminal").Terminal
local Path = require("plenary.path")
local tmp_path = "/tmp/nvim-vifm"

function Rename(old, new)
  local orig = vim.notify
  vim.notify = function() end
  local current_buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local is_valid = vim.api.nvim_buf_is_valid(buf)
    if is_valid then
      local name = vim.api.nvim_buf_get_name(buf)

      local listed = vim.bo[buf].buflisted
      if listed then
        if old == name then
          vim.api.nvim_buf_set_name(buf, new)
          vim.api.nvim_buf_call(buf, vim.cmd.edit)
        end
      end
    end
  end

  vim.cmd([[BWnex]])
  vim.notify = orig
end

function _VIFM_TOGGLE(dir_arg)
  local current_file = vim.fn.expand("%:p")
  local current_file_name = vim.fn.expand("%")
  local cmd
  if dir_arg ~= nil or current_file_name == "" then
    cmd = ('vifm --choose-files "%s"'):format(tmp_path)
  else
    cmd = ('vifm --choose-files "%s" --select "%s"'):format(tmp_path, current_file_name)
  end

  if current_file ~= "" and dir_arg == nil then
    cmd = cmd .. " " .. vim.fn.expand("%:p:h")
  elseif dir_arg ~= nil then
    cmd = cmd .. " " .. dir_arg
  else
    cmd = cmd .. " ."
  end

  local vifm = Terminal:new({
    cmd = cmd,
    direction = "float",
    close_on_exit = true,
    float_opts = {
      width = function()
        return math.floor(vim.o.columns * 0.5)
      end,

      height = function()
        return math.floor((vim.o.lines - vim.o.cmdheight) * 0.5)
      end,
    },
    highlights = {
      NormalFloat = {},
    },
    on_open = function(term)
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<c-q>", "<cmd>close<CR>", { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<ESC>", "<ESC>", { silent = true })
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<c-e>", "<C-\\><C-n>il", { silent = true })
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<c-v>", "<C-\\><C-n>:vsplit<CR>il", { silent = true })
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<c-s>", "<C-\\><C-n>:split<CR>il", { silent = true })
    end,
    on_close = function()
      data = Path:new(tmp_path):read()
      if data ~= "" then
        vim.schedule(function()
          vim.cmd("e " .. data)
        end)
      end
    end,
  })

  vifm:toggle()
end
