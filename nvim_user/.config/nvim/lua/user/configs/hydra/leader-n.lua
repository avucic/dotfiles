local M = {}

function M.setup(Hydra, _, _)
  local table_hint = [[
   _r_: realig         _dr_: delete row     _dc_: delete column
  _mt_: tableize       _ms_: sort table     _ic_: insert column after
  _fa_: add formula    _fe_: eval formula   _iC_: insert column before ^ ^
  _lr_: renumber list  _?_: echo cell map
]]

  local table_hydra_normal = Hydra({
    name = "Table",
    hint = table_hint,
    config = {
      on_key = false,
      invoke_on_body = true,
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    heads = {
      -- {"t", "<cmd>TableModeEnable<CR>",{exit = true}},
      { "r", "<Plug>(table-mode-realign)", { desc = "realign", exit = true } },
      { "dr", "<Plug>(table-mode-delete-row)", { desc = "delete row", exit = true } },
      { "dc", "<Plug>(table-mode-delete-cell)", { desc = "delete cell", exit = true } },
      { "mt", "<Plug>(table-mode-tableize)", { desc = "tableize", exit = true } },
      { "ms", "<Plug>(table-mode-sort)", { desc = "sort", exit = true } },
      { "ic", "<Plug>(table-mode-insert-column-after)", { desc = "insert column after", exit = true } },
      { "iC", "<Plug>(table-mode-insert-column-before)", { desc = "insert column before", exit = true } },
      { "fa", "<Plug>(table-mode-add-formula)", { desc = "add formula", exit = true } },
      { "fe", "<Plug>(table-mode-eval-formula)", { desc = "eval formula", exit = true } },
      { "lr", "<cmd>RenumberList<cr>", { desc = "renumber list", exit = true } },
      { "?", "<Plug>(table-mode-echo-cell-map)", { desc = "Echo cell map", exit = true } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })

  local function choose_table_normal()
    table_hydra_normal:activate()
  end

  local hint_visual = [[
  _w_: search notes    _n_: new note from title
]]

  Hydra({
    name = "Notes",
    hint = hint_visual,
    color = "pink",
    config = {
      -- on_key = false,
      invoke_on_body = true,
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    mode = "v",
    body = "<Leader>n",
    heads = {
      { "w", ":'<,'>ZkMatch<CR>", { exit = true } },
      { "n", ":'<,'>ZkNewFromTitleSelection<CR>", { exit = true } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })

  local note_hydra = Hydra({
    name = "New Note",
    config = {
      on_key = false,
    },
    heads = {
      { "g", "<cmd> MindFindOrCreateNote<cr>", { on_key = false, desc = "new global noe" } },
      { "p", "<cmd> MindFindOrCreateNote project<cr>", { on_key = false, desc = "new project note" } },
      { "<Esc>", nil, { exit = true, desc = false } },
    },
  })

  local journal_hydra = Hydra({
    name = "Journal",
    config = {
      on_key = false,
    },
    heads = {
      { "d", "<cmd> MindFindOrCreateNote global journal_daily<cr>", { on_key = false, desc = "new daily journal" } },
      { "f", "<cmd> MindFindOrCreateNote global fer<cr>", { on_key = false, desc = "new daily journal" } },
      { "<Esc>", nil, { exit = true, desc = false } },
    },
  })

  local hint_normal = [[
  _i_: index/main         _._: project notes
  _q_: close              _R_: reload index
  _n_: new                _o_: open notes
  _l_: links              _b_: backlinks
  _st_: search tags      _sg_: grep
  _pp_: preview          _pq_: quit preview
  _t_: table              _p_: project tree
  _j_: journal
]]

  local function choose_note()
    note_hydra:activate()
  end

  local function choose_journal()
    journal_hydra:activate()
  end

  Hydra({
    name = "Notes",
    hint = hint_normal,
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
    body = "<Leader>n",
    heads = {
      { "i", "<cmd>Neotree close<cr><Cmd>MindOpenMain<CR>", { exit = true } },
      { ".", "<Cmd>MindOpenProject<CR>", { exit = true } },
      { "q", "<cmd>Neotree close<cr><Cmd>MindClose<CR>", { exit = true } },
      { "R", "<Cmd>MindReloadState<CR><Cmd>ZkIndex<CR>", { exit = true } },
      -- { "n", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", { exit = true } },

      { "n", choose_note, { exit = true } },
      { "j", choose_journal, { exit = true } },
      { "p", "<Cmd>MindOpenProject<CR>", { exit = true } },
      { "o", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", { exit = true } },
      { "l", "<Cmd>ZkLinks<CR>", { exit = true } },
      { "b", "<Cmd>ZkBacklinks<CR>", { exit = true } },
      { "st", "<Cmd>ZkTags<CR>", { exit = true } },
      { "sg", "<Cmd>ZkGrep<CR>", { exit = true } },
      { "pp", "<Cmd>MarkdownPreview<CR>", { nowait = true } },
      { "pq", "<Cmd>MarkdownPreviewStop<CR>", { exit = true } },
      { "t", choose_table_normal, { exit = true } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
