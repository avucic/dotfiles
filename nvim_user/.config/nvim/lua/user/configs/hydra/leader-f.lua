local M = {}

function M.setup(Hydra, _, _)
  Hydra({
    name = "File",
    hint = [[
  _f_: files             _F_: all files
  _o_: old files         _g_: live grep
  _p_: projects          _/_: search in file
  _R_: reload fils       _?_: search history
  _r_: resume            _n_: new file
  _y_: copy file path    _Y_: copy full file path
  _e_: file explorer     _E_: file explorer project root  ^
  _x_: open              _X_: open folder  ^
  _m_: bookmarks

  _<Enter>_: Telescope
]],
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
        "<cmd>Telescope file_browser path=%:p:h files=true<cr>",
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
      { "y", ':let @*=expand("%")<cr>', { desc = "Copy file path" } },
      { "Y", ':let @*=expand("%:p")<cr>', { desc = "Copy full file path" } },
      { "x", ':OpenFileInFinder<cr>', { desc = "Open file in finder" } },
      { "X", ':OpenFolderInFinder<cr>', { desc = "Open folder in finder" } },
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
