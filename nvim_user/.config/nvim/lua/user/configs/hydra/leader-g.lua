local M = {}

function M.setup(Hydra, _, _)
  local git_hint = [[
  _b_: blame            _s_: status
  _j_: next hunk        _k_: prev hunk
  _p_: preview hunk     _r_: reset hunk
  _R_: reset buffer     _h_: file history
  _d_: diff view        _o_: open in Github
]]

  Hydra({
    name = "Git",
    hint = git_hint,
    config = {
      invoke_on_body = true,
      -- color = "pink",
      timeout = false,
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    mode = "n",
    body = "<Leader>g",
    heads = {

      -- { "b", "<cmd>lua require 'telescope.builtin'.git_branches()<cr>", { exit = true } },
      { "j", "<cmd>lua require 'gitsigns'.next_hunk()<cr>" },
      { "k", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>" },
      { "p", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>" },
      { "r", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>" },
      { "R", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", { exit = true } },
      -- s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      -- t = "Open Gitui", -- comand in toggleterm.lua
      {
        "s",
        "<cmd>lua require('user.core.utils').toggle_term_cmd('lazygit --use-config-file ~/.config/lazygit/config.yml', {direction = 'float'})<CR>",
        { exit = true },
      },
      -- s = { "<cmd>Neogit<CR>", "Git status" },
      -- u = {
      --   "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      --   "Undo Stage Hunk",
      -- },
      -- g = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      -- b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      { "b", "<cmd>lua require 'gitsigns'.blame_line()<cr>" },
      -- { "c", "<cmd>Telescope git_commits<cr>", { exit = true } },
      -- { "C", "<cmd>Telescope git_bcommits<cr>", { exit = true } },
      -- d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
      { "d", "<cmd>DiffviewOpen<cr>", { exit = true } },
      { "h", "<cmd>DiffviewFileHistory %<cr>", { exit = true } },
      { "o", "<cmd>OpenGithubFile<cr>", { exit = true } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
