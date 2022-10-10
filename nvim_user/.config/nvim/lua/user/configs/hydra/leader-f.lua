local M = {}

function M.setup(Hydra, cmd, _)
  local harpoon_hint = [[
  _h_: list files      _a_: Add file
  _1_: open file 1     _2_: Open file 2 ^^
  _3_: open file 3     _4_: Open file 4
]]

  local harpoon_hydra = Hydra({
    name = "Tabs",
    hint = harpoon_hint,
    config = {
      on_key = false,
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    heads = {
      { "a", "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = "Add file", exit = true } },
      -- h = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Open Menu" },
      { "h", "<cmd>lua require('telescope').extensions.harpoon.marks()<cr>", { exit = true } },
      { "1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { exit = true, desc = "Open File 1" } },
      { "2", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { exit = true, desc = "Open File 2" } },
      { "3", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { exit = true, desc = "Open File 3" } },
      { "4", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { exit = true, desc = "Open File 4" } },
      { "<Esc>", nil, { exit = true, desc = false } },
    },
  })

  local function choose_harpoon()
    harpoon_hydra:activate()
  end

  local telescopehint = [[
  _f_: files             _m_: marks
  _o_: old files         _g_: live grep
  _p_: projects          _/_: search in file
  _R_: reload fils       _?_: search history
  _r_: resume            _h_: harpoon
  _t_: focus on tree     _y_: copy file path
  _e_: file explorer
  ^
  _<Enter>_: Telescope
]]

  Hydra({
    name = "File",
    hint = telescopehint,
    config = {
      invoke_on_body = true,
      color = "pink",
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    mode = "n",
    body = "<Leader>f",
    heads = {
      { "e", "<cmd>Neotree toggle<cr>", { exit = true } },
      { "m", cmd("MarksListBuf"), { desc = "marks" } },
      { "f", "<cmd>FocusDisable<cr><cmd>lua require('telescope.builtin').find_files()<CR>", { exit = true } },
      { "g", "<cmd>FocusDisable<cr><cmd>lua require('telescope.builtin').live_grep()<CR>", { exit = true } },
      {
        "o",
        "<cmd>FocusDisable<cr><cmd>lua require('telescope.builtin').oldfiles()<CR>",
        { exit = true, desc = "recently opened files" },
      },
      { "r", "<cmd>FocusDisable<cr><cmd>lua require('telescope.builtin').resume()<CR>", { exit = true } },
      {
        "p",
        "<cmd>FocusDisable<cr><cmd>lua require('telescope').extensions.project.project{}<CR>",
        { exit = true, desc = "projects" },
      },
      {
        "/",
        "<cmd>FocusDisable<cr><cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>",
        { exit = true, desc = "search in file" },
      },
      {
        "?",
        "<cmd>FocusDisable<cr><cmd>lua require('telescope.builtin').search_history()<CR>",
        { desc = "search history" },
      },
      { "R", "<cmd>e %<CR>", { exit = true } },
      { "h", choose_harpoon, { exit = true, desc = "choose harpoon" } },
      { "t", "<cmd>Neotree focus<CR>", { exit = true } },
      { "y", ':let @*=expand("%")<cr>', { exit = true, desc = "Copy file path" } },
      {
        "<Enter>",
        "<cmd>FocusDisable<cr><cmd>lua require('telescope.builtin')<CR>:Telescope<CR>",
        { exit = true, desc = "list all pickers" },
      },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
