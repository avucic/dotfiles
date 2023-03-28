local M = {}

function M.dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

function M.delete_window()
  local window = require("window-picker").pick_window()
  vim.api.nvim_win_close(window, false)
end

local _user_terminals = {}

function M.toggle_term_cmd(cmd, opts)
  if _user_terminals[cmd] == nil then
    _user_terminals[cmd] =
      require("toggleterm.terminal").Terminal:new({ cmd = cmd, hidden = true, direction = opts.direction })
  end
  _user_terminals[cmd]:toggle()
end

function M.load_module(name)
  local ok, module = pcall(require, name)
  if ok then
    return module
  end
  -- assert(ok, string.format("Module %s not installed", name))
  return nil
end

function M.modul_exists(name)
  local ok, _ = pcall(require, name)
  if not ok then
    return false
  end
  return true
end

function M.env_merge(env)
  if env == nil then
    return env
  end
  -- Merge.
  env = vim.tbl_extend("force", vim.fn.environ(), env)
  local final_env = {}
  for k, v in pairs(env) do
    assert(type(k) == "string", "env must be a dict")
    table.insert(final_env, k .. "=" .. tostring(v))
  end
  return final_env
end

function M.define_sts_jump_keymap(char, otps, desc, both)
  local map = vim.keymap.set
  both = both or true
  map("n", "<leader>j" .. char, function()
    require("syntax-tree-surfer").filtered_jump(otps, true)
    vim.cmd([[WhichKey <leader>j]])
  end, { desc = "Next " .. desc, buffer = true })
  if both then
    map("n", "<leader>j" .. string.upper(char), function()
      require("syntax-tree-surfer").filtered_jump(otps, false)
      vim.cmd([[WhichKey <leader>j]])
    end, { desc = "Previous " .. desc, buffer = true })
  end
  map("n", "<leader>J" .. char, function()
    require("syntax-tree-surfer").targeted_jump(otps)
  end, { desc = "Next (target) " .. desc, buffer = true })
end

function M.toggle_theme()
  if vim.g.current_colorscheme == "light" then
    vim.g.current_colorscheme = "dark"
    vim.cmd([[colorscheme astrodark]])
  else
    vim.g.current_colorscheme = "light"
    vim.cmd([[colorscheme astrolight]])
  end
end

function M.toggle_lsp_virtual_text_popup()
  if vim.g.lsp_virtual_text_style ~= "inline" then
    vim.g.lsp_virtual_text_style = "inline"
  else
    vim.g.lsp_virtual_text_style = "popup"
  end
  vim.cmd([[LspRestart]])
end

function M.fileExists(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

function M.get_visual_selection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

return M
