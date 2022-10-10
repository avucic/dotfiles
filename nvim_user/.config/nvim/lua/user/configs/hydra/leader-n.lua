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

  local hint_normal = [[
  _i_: index/main         _._: project notes
  _R_: reload index       _p_: project tree
  _n_: new                _o_: open notes
  _l_: links              _b_: backlinks
 _st_: search tags       _sg_: grep
  _j_: journal
]]

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
      { "i", "<cmd>ZkOpenNotebook<CR>", { exit = true } },
      { ".", "<Cmd>ZkCd<CR>", { exit = true } },
      { "R", "<Cmd>ZkIndex<CR>", { exit = true } },
      { "n", "<cmd>ZkFindOrCreateNote<cr>", { exit = true } },
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
