local M = {}

function M.setup(Hydra, _, _)
  local hint = [[
  _m_: poet mode                 _]_: minimap^^
  _d_: diagnostics               _s_: signcolumn^^
  _n_: change line number        _z_: spell^^
  _v_: paste mode                _t_: tabline^^
  _u_: url highlight             _w_: wrap^^
  _l_: statusline                _f_: autoformat
  _c_: conceallevel
]]

  local mode_hydra = Hydra({
    name = "Poet mode",
    config = {
      on_key = false,
    },
    heads = {
      { "p", "<cmd>TZAtaraxis<cr>", { desc = "poet mode" } },
      { "f", "<cmd>TZFocus<cr>", { desc = "focus mode" } },
      { "m", "<cmd>TZMinimalist<cr>", { desc = "minimalist mode" } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })

  local function choose_mode()
    mode_hydra:activate()
  end

  local function toggle_conceal()
    if vim.opt.conceallevel._value == 0 then
      vim.cmd([[set conceallevel=2]])
    else
      vim.cmd([[set conceallevel=0]])
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
    mode = "n",
    body = "<Leader>u",
    heads = {
      { "m", choose_mode, { desc = "Poet mode" } },
      { "]", "<cmd>ToggleMiniMap<cr>", { desc = "Minimap" } },
      { "d", astronvim.ui.toggle_diagnostics, { desc = "toggle diagnostics" } },
      { "s", astronvim.ui.toggle_signcolumn, { desc = "toggle signcolumn" } },
      { "c", toggle_conceal, { desc = "toggle conceal" } },
      { "n", astronvim.ui.change_number, { desc = "change line numbering" } },
      { "z", astronvim.ui.toggle_spell, { desc = "toggle spell" } },
      { "v", astronvim.ui.toggle_paste, { desc = "toggle paste mode" } },
      { "t", astronvim.ui.toggle_tabline, { desc = "toggle tabline" } },
      { "u", astronvim.ui.toggle_url_match, { desc = "toggle URL highlight" } },
      { "w", astronvim.ui.toggle_wrap, { desc = "toggle wrap" } },
      { "l", astronvim.ui.toggle_statusline, { desc = "toggle statusline" } },
      { "f", astronvim.ui.toggle_autoformat, { desc = "toggle autoformat" } },
      {
        "i",
        "<cmd>Workspace LeftPanelToggle<cr><cmd>Workspace RightPanelToggle<cr>",
        { exit = true },
      },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M