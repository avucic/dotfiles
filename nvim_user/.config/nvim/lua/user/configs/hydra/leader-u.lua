local M = {}

function M.setup(Hydra, _, _)
  local hint = [[
  _m_: poet mode                 _]_: minimap
  _d_: diagnostics               _s_: signcolumn ^
  _n_: change line number        _z_: spell^^
  _v_: paste mode                _t_: tabline^^
  _u_: url highlight             _w_: wrap^^
  _l_: statusline                _f_: autoformat
  _c_: conceallevel              _i_: ide
  _N_: notifications             _T_: theme
  _x_: lsp virtual text
]]

  local cmd = vim.cmd
  local toggle_notifications = function()
    if vim.g.turn_of_notify ~= true then
      vim.notify = function() end
      vim.g.turn_of_notify = true
    else
      vim.notify = require("notify")
      vim.g.turn_of_notify = false
    end
  end

  local mode_hydra = Hydra({
    name = "Poet mode",
    config = {
      on_key = false,
    },
    mode = { "n", "v", "x" },
    heads = {
      { "p", "<cmd>TZAtaraxis<cr>", { desc = "poet mode" } },
      { "f", "<cmd>TZFocus<cr>", { desc = "focus mode" } },
      { "m", "<cmd>TZMinimalist<cr>", { desc = "minimalist mode" } },
      { "n", ":'<,'>TZNarrow<cr>", { desc = "narrow", exit = true, mode = "v" } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })

  local function choose_mode()
    mode_hydra:activate()
  end

  local function toggle_conceal()
    if vim.opt.conceallevel._value == 0 then
      cmd([[set conceallevel=2]])
    else
      cmd([[set conceallevel=0]])
    end
  end

  local function toggle_spell()
    if vim.g.is_spell_off == true then
      vim.g.is_spell_off = false
      cmd([[set spell]])
    else
      vim.g.is_spell_off = true
      cmd([[set nospell]])
    end
  end

  local function toggle_lsp_virtual_text()
    if vim.g.lsp_virtual_text_style ~= "inline" then
      vim.g.lsp_virtual_text_style = "inline"
    else
      vim.g.lsp_virtual_text_style = "popup"
    end
    vim.cmd([[LspRestart]])
  end

  local function toggle_theme()
    if vim.g.current_colorscheme == "light" then
      vim.g.current_colorscheme = "dark"
      cmd([[colorscheme default_theme]])
    else
      vim.g.current_colorscheme = "light"
      cmd([[colorscheme material]])
    end
  end

  Hydra({
    name = "Toggle",
    hint = hint,
    config = {
      on_key = false,
      invoke_on_body = true,
      color = "pink",
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    mode = { "n", "v" },
    body = "<Leader>u",
    heads = {
      { "m", choose_mode, { desc = "Poet mode" } },
      { "]", "<cmd>ToggleMiniMap<cr>", { desc = "Minimap" } },
      { "d", astronvim.ui.toggle_diagnostics, { desc = "toggle diagnostics" } },
      { "s", astronvim.ui.toggle_signcolumn, { desc = "toggle signcolumn" } },
      { "c", toggle_conceal, { desc = "toggle conceal" } },
      { "n", astronvim.ui.change_number, { desc = "change line numbering" } },
      { "z", toggle_spell, { desc = "toggle spell" } },
      { "v", astronvim.ui.toggle_paste, { desc = "toggle paste mode" } },
      { "t", astronvim.ui.toggle_tabline, { desc = "toggle tabline" } },
      { "u", astronvim.ui.toggle_url_match, { desc = "toggle URL highlight" } },
      { "w", astronvim.ui.toggle_wrap, { desc = "toggle wrap" } },
      { "l", astronvim.ui.toggle_statusline, { desc = "toggle statusline" } },
      { "f", astronvim.ui.toggle_autoformat, { desc = "toggle autoformat" } },
      { "N", toggle_notifications, { desc = "toggle notifications", exit = true } },
      { "x", toggle_lsp_virtual_text, { desc = "toggle lsp virtual text", exit = true } },
      {
        "i",
        "<cmd>Workspace LeftPanelToggle<cr><cmd>Workspace RightPanelToggle<cr>",
        { exit = true },
      },
      { "T", toggle_theme },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
