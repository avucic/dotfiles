local M = {}

function M.setup(Hydra, _, _)
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
      { "g", "<cmd> MindFindOrCreateNote<cr>", { on_key = false, desc = "new global noe", nowait = true } },
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
  _R_: reload index       _p_: project tree
  _n_: new                _o_: open notes
  _l_: links              _b_: backlinks
 _st_: search tags       _sg_: grep
  _j_: journal            _q_: close tree
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
      -- color = "pink",
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
      -- { "pq", "<Cmd>MarkdownPreviewStop<CR>", { exit = true } },
      { "<Esc>", nil, { exit = true, desc = false } },
    },
  })
end

return M
