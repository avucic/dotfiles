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
      {
        "d",
        "<cmd>:ZkFindOrCreateJournalDailyNote<cr>",
        { desc = "new daily journal", exit = true },
      },
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
      { "o", "<Cmd>ZkOrphans<CR>", { exit = true, desc = "orphans" } },
      { "<Esc>", nil, { exit = true, desc = false } },
    },
  })

  local note_hydra = Hydra({
    name = "New note",
    heads = {
      {
        "r",
        "<cmd>:ZkFindOrCreateNote { group='reference_notes', dir='references'}<cr>",
        { desc = "references", exit = true },
      },
      {
        "s",
        "<cmd>:ZkFindOrCreateNote { group='permanent_notes', dir='slip-box'}<cr>",
        { desc = "slip box", exit = true },
      },
      {
        "d",
        "<cmd>:ZkFindOrCreateNote { group='fleeting_notes', dir='daily_notes'}<cr>",
        { desc = "daily notes", exit = true },
      },
      {
        "l",
        "<cmd>:ZkFindOrCreateNote { group='literature_notes', dir='literature_notes'}<cr>",
        { desc = "literature notes", exit = true },
      },
      {
        "p",
        "<cmd>:ZkFindOrCreateProjectNote<cr>",
        { desc = "project notes", exit = true },
      },
      { "<Esc>", nil, { exit = true, desc = false } },
    },
  })

  local task_hydra = Hydra({
    name = "Tasks",
    config = {
      on_key = false,
    },
    heads = {
      {
        "t",
        "<cmd>lua require('user.core.utils').toggle_term_cmd('vit list due:today or +next', {direction = 'float'})<CR>",
        { exit = true },
      },
      {
        "T",
        "<cmd>lua require('user.core.utils').toggle_term_cmd('timew week', {direction = 'float'})<CR>",
        { exit = true },
      },
      {
        "o",
        ":ZkAnnotateTask<cr>",
        { exit = true },
      },
      { "<Esc>", nil, { exit = true, desc = false } },
    },
  })

  local hint_normal = [[
  _R_: reload index        _n_: new note
  _o_: open notes          _j_: journal
  _s_: search              _c_: calendar
  _t_: tasks               _._: cdw
  _i_: nootbook
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

  local function choose_task()
    task_hydra:activate()
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
      { "c", "<cmd>ZkShowCalendar<cr>", { exit = true } },
      { "n", choose_note, { exit = true } },
      { "j", choose_journal, { exit = true } },
      { "t", choose_task, { exit = true } },
      -- { "p", "<Cmd>MindOpenProject<CR>", { exit = true } },
      -- { "o", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", { exit = true } },
      { "o", "<Cmd>ZkOpenNotes<CR>", { exit = true } },
      -- { "l", "<Cmd>ZkLinks<CR>", { exit = true } },
      -- { "b", "<Cmd>ZkBacklinks<CR>", { exit = true } },
      -- { "st", "<Cmd>ZkTags<CR>", { exit = true } },
      -- { "s", "<cmd>:ZkNew{group='scratch', dir='scratch'}<cr>", { desc = "new scratch", exit = true } },
      { "s", choose_search, { exit = true } },
      { "<Esc>", nil, { exit = true, desc = false } },
    },
  })
end

return M
