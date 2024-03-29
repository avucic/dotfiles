local M = {}

require("user.plugins.configs.toggleterm.lazygit")
require("user.plugins.configs.toggleterm.lazydocker")
require("user.plugins.configs.toggleterm.tasks")
require("user.plugins.configs.toggleterm.scratchpad")
require("user.plugins.configs.toggleterm.vifm")

local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

local default_direction = "horizontal"

function M.open_terminal(dir, id)
  if not dir then
    dir = default_direction
  end

  local terminals = require("toggleterm.terminal").get_all()

  if not vim.g._terminal_counter or next(terminals) == nil or vim.g._terminal_counter < 1 then
    vim.g._terminal_counter = 100
  end

  if not id then
    vim.g._terminal_counter = vim.g._terminal_counter + 1
    vim.cmd(vim.g._terminal_counter .. "ToggleTerm direction=" .. dir)
  else
    vim.cmd(tostring(id) .. "ToggleTerm direction=" .. dir)
  end
end

function M.opts()
  return {
    size = function(term)
      local max_vertical = 80
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        local dynamic_size = vim.o.columns * 0.4
        if dynamic_size > max_vertical then
          return max_vertical
        else
          return dynamic_size
        end
      end
    end,
    on_create = function(term)
      if term.direction ~= "float" then
        set_terminal_keymaps()
      end
    end,

    on_open = function(term)
      -- vim.cmd("startinsert!")
    end,
    -- open_mapping = [[\\]],
    open_mapping = [[<c-\>]],
    persist_size = true,
    shade_terminals = false,
    shading_factor = -8,
    insert_mappings = false,
    terminal_mappings = false,
    start_in_insert = true,
    direction = default_direction,
    highlights = {
      -- border = "Normal",
      -- background = "Normal",
      -- highlights which map to a highlight group name and a table of it's values
      -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
      -- Normal = {
      --   guibg = "#ff6600",
      -- },
      NormalFloat = {
        guifg = "#ff6600",
      },
      FloatBorder = {
        guifg = "#1a1d24",
        -- guibg = "<VALUE-HERE>",
      },
    },
    winbar = {
      enabled = false,
    },
  }
end

return M
