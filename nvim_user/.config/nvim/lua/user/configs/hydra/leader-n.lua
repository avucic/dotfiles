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

  local journal_hydra = Hydra({
    name = "Journal",
    config = {
      on_key = false,
    },
    heads = {
      { "d", "<cmd>:ZkNew{group='journal', dir='journal/daily'}<cr>", { desc = "new daily journal", exit = true } },
      { "f", "<cmd>:ZkNew{group='fer', dir='journal/fer'}<cr>", { desc = "new fer session", exit = true } },
      { "<Esc>", nil, { exit = true, desc = false } },
    },
  })

  local search_hydra = Hydra({
    name = "Search",
    config = {
      on_key = false,
    },
    heads = {
      { "g", "<Cmd>ZkGrep<CR>", { exit = true, desc = "grep" } },
      { "t", "<Cmd>ZkTags<CR>", { exit = true, desc = "by tags" } },
      { "l", "<Cmd>ZkLinks<CR>", { exit = true, desc = "links" } },
      { "b", "<Cmd>ZkBacklinks<CR>", { exit = true, desc = "backlinks" } },
      { "<Esc>", nil, { exit = true, desc = false } },
    },
  })

  local note_hydra = Hydra({
    name = "New note",
    heads = {
      -- {
      --   "l",
      --   "<cmd>:ZkNew{group='literature_notes', dir='Literature Notes'}<cr>",
      --   { desc = "Literature note", exit = true },
      -- },
      -- {
      --   "p",
      --   "<cmd>:ZkNew{group='permanent_notes', dir='Permanent Notes'}<cr>",
      --   { desc = "Permanent note", exit = true },
      -- },
      -- {
      --   "f",
      --   "<cmd>:ZkNew{group='fleeting_notes', dir='Fleeting Notes'}<cr>",
      --   { desc = "Fleeting note", exit = true },
      -- },
      {
        "l",
        "<cmd>:ZkFindOrCreateNote literature<cr>",
        { desc = "literature", exit = true },
      },
      {
        "p",
        "<cmd>:ZkFindOrCreateNote permanent<cr>",
        { desc = "permanent", exit = true },
      },
      {
        "f",
        "<cmd>:ZkFindOrCreateNote fleeting<cr>",
        { desc = "fleeting", exit = true },
      },
      { "<Esc>", nil, { exit = true, desc = false } },
    },
  })

  local hint_normal = [[
  _i_: index/main         _._: cdw
  _R_: reload index       _n_: new note
  _o_: open notes         _j_: journal
  _f_: search
]]

  local function choose_journal()
    journal_hydra:activate()
  end

  local function choose_search()
    search_hydra:activate()
  end

  local function choose_note()
    note_hydra:activate()
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
      { "i", "<cmd>ZkOpenNotebook<CR>", { exit = true } },
      { ".", "<Cmd>ZkCd<CR>", { exit = true } },
      { "R", "<Cmd>ZkIndex<CR>", { exit = true } },
      -- { "n", "<cmd>ZkFindOrCreateNote<cr>", { exit = true } },
      { "n", choose_note, { exit = true } },
      { "j", choose_journal, { exit = true } },
      -- { "p", "<Cmd>MindOpenProject<CR>", { exit = true } },
      { "o", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", { exit = true } },
      -- { "l", "<Cmd>ZkLinks<CR>", { exit = true } },
      -- { "b", "<Cmd>ZkBacklinks<CR>", { exit = true } },
      -- { "st", "<Cmd>ZkTags<CR>", { exit = true } },
      -- { "s", "<cmd>:ZkNew{group='scratch', dir='scratch'}<cr>", { desc = "new scratch", exit = true } },
      { "f", choose_search, { exit = true } },
      { "<Esc>", nil, { exit = true, desc = false } },
    },
  })
end

return M
