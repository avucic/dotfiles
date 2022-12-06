local M = {}

function M.setup(Hydra, _, _)
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
      { "a", "<cmd>lua require('harpoon.kark').add_file()<cr>" },
      { "h", "<cmd>lua require('telescope').extensions.harpoon.marks()<cr>" },
      { "1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = "Open File 1" } },
      { "2", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = "Open File 2" } },
      { "3", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = "Open File 3" } },
      { "4", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = "Open File 4" } },
      { "<Esc>", nil, { desc = false } },
    },
  })

  local function choose_harpoon()
    harpoon_hydra:activate()
  end

  local telescopehint = [[
  _f_: files             _F_: all files
  _o_: old files         _g_: live grep
  _p_: projects          _/_: search in file
  _R_: reload fils       _?_: search history
  _r_: resume            _h_: harpoon
  _y_: copy file path    _m_: bookmarks
  _e_: file explorer     _E_: file explorer project root ^
  _n_: new file
  ^
  _<Enter>_: Telescope
]]

  Hydra({
    name = "File",
    hint = telescopehint,
    config = {
      invoke_on_body = true,
      color = "teal",
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    mode = "n",
    body = "<Leader>f",
    heads = {
      { "n", "<cmd>enew<cr>" },
      { "E", "<cmd>Telescope file_browser<cr>" },
      {
        "e",
        "<cmd>lua require('telescope').extensions.file_browser.file_browser {path = '%:p:h', files = true}<cr>",
      },
      { "m", "<cmd>lua require('telescope').extensions.vim_bookmarks.all()<cr>" },
      { "f", "<cmd>lua require('telescope.builtin').find_files()<CR>" },
      {
        "F",
        "<cmd>lua require('telescope.builtin').find_files({ hidden = true, no_ignore = true })<CR>",
      },
      { "g", "<cmd>lua require('telescope.builtin').live_grep()<CR>" },
      {
        "o",
        "<cmd>lua require('telescope.builtin').oldfiles()<CR>",
        { desc = "recently opened files" },
      },
      { "r", "<cmd>lua require('telescope.builtin').resume()<CR>" },
      {
        "p",
        "<cmd>lua require('telescope').extensions.project.project{}<CR>",
        { desc = "projects" },
      },
      {
        "/",
        "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>",
        { desc = "search in file" },
      },
      {
        "?",
        "<cmd>lua require('telescope.builtin').search_history()<CR>",
        { desc = "search history" },
      },
      { "R", "<cmd>e %<CR>" },
      { "h", choose_harpoon, { desc = "choose harpoon" } },
      { "y", ':let @*=expand("%")<cr>', { desc = "Copy file path" } },
      {
        "<Enter>",
        "<cmd>lua require('telescope.builtin')<CR>:Telescope<CR>",
        { desc = "list all pickers" },
      },
      { "<Esc>", nil, { nowait = true, desc = false } },
    },
  })
end

return M
