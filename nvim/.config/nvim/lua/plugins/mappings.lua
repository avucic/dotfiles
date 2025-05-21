-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
-- stylua: ignore start

vim.cmd [[vnoremap <C-r> "hy:%s@<C-r>h@@gI<left><left><left>]]
vim.cmd [[vnoremap <C-g> "hy:g/<C-r>h/normal<space>]]
-- vim.cmd([[vnoremap <C-r> "hy:Subs/<C-r>h//gI<left><left><left>]])
-- vim.cmd([[nnoremap <Leader-r> :%s/\<<C-r><C-w>\>/]])

-- command line
vim.cmd [[
  cnoremap <C-A> <Home>
	cnoremap <C-F> <Right>
	cnoremap <C-B> <Left>
  ]]

local maps = { i = {}, n = {}, v = {}, t = {}, x = {} }

-- N ------------------------------------------------------------------------------------
maps.n["<Leader>c"] = false -- close buffer
maps.n["<Leader>C"] = false
maps.n["<c-z>"] = "<Nop>"
maps.n["<C-q>"] = false
-- maps.n["gd"] = false
-- maps.n["gD"] = false
maps.n["|"] = false
-- maps.n["j"] = false

-- maps.n["<c-q>"] =      { "<cmd>silent! cclose<cr><cmd>nohlsearch<cr><cmd>ToggleTermToggleAll<cr>" }
maps.n["<esc>"] =      { "<cmd>nohlsearch<cr><cmd>lua Snacks.notifier.hide()<cr>" }
maps.n["<esc><esc>"] = { "<cmd>nohlsearch<cr><cmd>lua Snacks.notifier.hide()<cr>" }

maps.n["Q"] =          { "<cmd>qall!<cr>" }
maps.n["<S-l>"] =      { "$" }
maps.n["<S-h>"] =      { "^" }
-- maps.n["z="] =         { "<cmd>lua Snacks.picker.spell_suggest()<CR>" }
maps.n["<Leader>W"] =  { "<cmd>:noa w<cr>", desc = "Save without format" }
maps.v["<c-f>"] =      { "y<ESC>:lua Snacks.picker.live_grep({default_text= vim.fn.getreg('*')})<CR>" }
maps.v["<S-l>"] =      { "$", desc = "Jump to end of line" }
maps.v["<S-h>"] =      { "^", desc = "Jump to the begging of line" }
maps.v["p"] =          { '"_dP' }

-- remove from Astrovim. TODO: better way?
maps.n["<A-j>"] = { "<Nop>" }
maps.n["<A-k>"] = { "<Nop>" }

-- c-w  +Windows
maps.n["<c-w>"] = { desc = "Window management" }
maps.n["<c-w>q"] = { "<cmd>:q<cr>", desc = "Close" }
maps.n["<c-w>D"] = { "<cmd>only<cr>", desc = "Close others" }
maps.n["<C-w>K"] = { "<cmd>lua require('smart-splits').resize_up()<cr><cmd>WhichKey <c-w><cr>", desc = "Resize split up" }
maps.n["<C-w>J"] = { "<cmd>lua require('smart-splits').resize_down()<cr><cmd>WhichKey <c-w><cr>", desc = "Resize split down" }
maps.n["<C-w>H"] = { "<cmd>lua require('smart-splits').resize_left()<cr><cmd>WhichKey <c-w><cr>", desc = "Resize split left" }
maps.n["<C-w>L"] = { "<cmd>lua require('smart-splits').resize_right()<cr><cmd>WhichKey <c-w><cr>", desc = "Resize split right" }

-- tabs
maps.n["<c-w>t"] = { desc = "Tabs" }
-- maps.n["<c-w>tt"] = { "<cmd>lua require('telescope-tabs').list_tabs()<cr>", desc = "List tabs" }
maps.n["<c-w>tn"] = { "<cmd>tabnew<cr>", desc = "new tab" }
maps.n["<c-w>tq"] = { "<cmd>tabclose<cr>", desc = "Close tab" }
--

-- +Files
maps.n["<Leader>fn"] = { "<cmd>enew<cr>", desc = "New file" }
-- maps.n["<Leader>fe"] = { "<cmd>lua _VIFM_TOGGLE()<cr>", desc = "Explorer from current dir" }
-- maps.n["<Leader>fE"] = { "<cmd>lua _VIFM_TOGGLE(vim.fn.getcwd())<cr>", desc = "Explorer from current dir" }
-- maps.n["<Leader>fd"] = { "<cmd>lua require('telescope').extensions.dir.live_grep()<CR>", desc = "Find dir" }
-- maps.n["<Leader>f?"] = { "<cmd>lua Snacks.picker.search_history()<CR>", desc = "History" }
maps.n["<Leader>fy"] = { "<cmd>let @*=expand('%')<cr>", desc = "Yank file path" }
maps.n["<Leader>fY"] = { "<cmd>let @*=expand('%:p')<cr>", desc = "Yank full file path" }
maps.n["<Leader>fx"] = { "<cmd>OpenFile<cr>", desc = "Open file in folder" }
maps.n["<Leader>fX"] = { "<cmd>OpenFolderInFinder<cr>", desc = "Open folder" }
-- maps.n["<leader>fw"] = { "<cmd>lua Snacks.picker.grep()<CR>", desc = "Live grep", }
-- maps.n["<leader>fW"] = { "<cmd>lua Snacks.picker.grep_word()<CR>", desc = "Live grep", }
-- maps.v["<leader>fw"] = { "<cmd>lua Snacks.picker.grep_word({word = require('core.utils').get_visual_selection()})<CR>", desc = "Live grep", }
maps.n["<leader>fR"] = { "<cmd>e %<CR>", desc = "Reload file", }
-- maps.n["<leader>f<cr>"] = { "<cmd>lua Snacks.picker.resume()<CR>", desc = "Resume" }

-- +Search
maps.n["<Leader>s"] = { desc = "Search" }

-- maps.n["<leader>sc"] = { "<cmd>lua Snacks.picker.commands()<CR>", desc = "Commands" }
-- maps.n["<leader>sk"] = { "<cmd>lua Snacks.picker.keymaps()<CR>", desc = "Keymaps" }
-- maps.n["<Leader>s;"] = { "<cmd>lua Snacks.picker.command_history()<CR>", desc = "Command History" }
-- maps.n["<Leader>st"] = { "<cmd>TodoTelescope<cr>", desc = "Todo list" }
-- maps.n["<leader>sb"] = { "<cmd>lua Snacks.picker.buffers()<CR>", desc = "Buffers" }
-- maps.n["<Leader>sn"] = { function() require("telescope").extensions.notify.notify() end, desc = "Find notifications" }
-- maps.n["<leader>s<cr>"] = { "<cmd>lua Snacks.picker.resume()<CR>", desc = "Resume" }
-- maps.n["<leader>sp"] = { "<cmd>lua Snacks.picker()<CR>", desc = "Resume" }

-- +Buffers
maps.n["<Leader>bo"] = { "<Leader>bc", desc = "Close all buffers except current", remap = true }
maps.n["<Leader>bO"] = { "<Leader>bC", desc = "Close all", remap = true }
maps.n["<Leader>bR"] = { function() require("astrocore.buffer").close_left() end, desc = "Close all buffers to the right" }
maps.n["<Leader>bL"] = { function() require("astrocore.buffer").close_right() end, desc = "Close all buffers to the left" }
maps.n["<Leader>bp"] = false
maps.n["<Leader>bl"] = false
maps.n["<leader>bl"] = { "<cmd>lua require('astrocore.buffer').nav((vim.v.count > 0 and vim.v.count or 1))<cr><cmd>WhichKey <LT>leader>b<CR>", desc = "Next buffer", }
maps.n["<leader>bh"] = { "<cmd>lua require('astrocore.buffer').nav(-(vim.v.count > 0 and vim.v.count or 1))<cr><cmd>WhichKey <LT>leader>b<CR>", desc = "Previous buffer", }
maps.n["<leader>bq"] = { "<cmd>lua require('astrocore.buffer').close(0)<CR><cmd>WhichKey <LT>leader>b<CR>", desc = "Close" }
-- maps.n["<leader>bd"] = { "<cmd>lua require('astroui.status.heirline').buffer_picker(function(bufnr) require('astrocore.buffer').close(bufnr) end)<CR><cmd>WhichKey <Leader>b<CR>", desc = "Clooooooooooooooose" }
maps.n["<Leader>bd"] = false
maps.n["<leader>bd"] = {
  function()
    require('astroui.status.heirline').buffer_picker(
      function(bufnr)
        require('astrocore.buffer').close(bufnr);
        require('which-key').show_command("<Leader>bd");
      end
    )
end, desc = "Pick from tabline and close" }
maps.n["<leader>bQ"] = { "<cmd>q<cr>", desc = "Force close", }
maps.n["<leader>bD"] = { "<cmd>WipeWindowlessBufs<cr>", desc = "Wipeout all buffers not shown in a window", }

-- +Git
-- maps.n["<Leader>gf"] = { "<cmd>Easypick changed_files<cr>", desc = "List changed files" }
-- maps.n["<Leader>gr"] = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset hunk" }
-- maps.n["<Leader>gR"] = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset buffer" }
-- maps.n["<Leader>gg"] = {
--   "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
--   desc = "Git status",
-- }

-- maps.n["<Leader>gd"] = { false, desc = "Git diff" }
-- maps.n["<Leader>gdd"] = { "<cmd>lua require('gitsigns').diffthis()<cr>", desc = "Diff" }
-- maps.n["<Leader>gdq"] = { "<cmd>diffoff<cr>", desc = "Diff" }
-- maps.n["<Leader>gdl"] = { "<cmd>lua require('telescope').extensions.advanced_git_search.diff_commit_line()<cr>", desc = "Search line" }
-- maps.v["<leader>gdl"] = { "<cmd>lua require('telescope').extensions.advanced_git_search.diff_commit_line()<cr>", desc = "Search line" }
-- maps.n["<Leader>gdb"] = { "<cmd>lua require('telescope').extensions.advanced_git_search.diff_branch_file()<cr>", desc = "Diff branch file" }
-- maps.n["<Leader>gdf"] = { "<cmd>lua require('telescope').extensions.advanced_git_search.diff_commit_file()<cr>", desc = "Search file" }
-- maps.n["<Leader>gds"] = { "<cmd>lua require('telescope').extensions.advanced_git_search.search_log_content()<cr>", desc = "Search log" }
maps.n["<Leader>gT"] = false
maps.n["<Leader>gt"] = false
maps.n["<Leader>gS"] = false
--
-- +Open
maps.n["<Leader>o"] = { false, desc = "Open" }
maps.n["<Leader>oN"] = { "<cmd>NoiceTelescope<cr>", desc = "Notifications" }

-- +Tasks
maps.n["<Leader>t"] = { desc = "Tasks" }
maps.n["<Leader>tf"] = false
maps.n["<Leader>th"] = false
maps.n["<Leader>tl"] = false
-- maps.n["<Leader>tn"] = false
maps.n["<Leader>tp"] = false
maps.n["<Leader>tv"] = false

-- + Run
maps.n["<Leader>r"] = { desc = "Run and execute" }

-- + Local language mappings
maps.n["<Leader>m"] = { desc = "Local language mappings" }

-- +Jump
maps.n["<Leader>j"] = { desc = "Jumping" }
maps.n["<Leader>jn"] = { "<cmd>lua require('aerial').next()<cr><cmd>WhichKey <LT>leader>j<CR>", desc = "Aerial next" }
maps.n["<Leader>jN"] = { "<cmd>lua require('aerial').next(-1)<cr><cmd>WhichKey <LT>leader>j<CR>", desc = "Aerial previous" }
maps.n["<Leader>jr"] = { "<cmd>lua Snacks.picker.lsp_references()<CR>", desc = "LSP references" }

-- +Notes
maps.n["<Leader>n"] = { false, desc = "Notes" }
maps.n["<Leader>nn"] = false
maps.n["<Leader>nf"] = { "<Cmd>ZkOpenNotes<CR>", desc = "Open notes" }
maps.n["<Leader>ni"] = { "<cmd>ZkOpenNotebook<CR>", desc = "Open notebook" }
maps.n["<Leader>n."] = { "<Cmd>ZkCd<CR>", desc = "cdw" }
maps.n["<Leader>nR"] = { "<Cmd>ZkIndex<CR>", desc = "Reindex" }
maps.n["<Leader>nn"] = { "<Cmd>ZkFindOrCreateNote<CR>", desc = "Find or create note" }

maps.v["<Leader>nn"] = { ":'<,'>ZkFindOrCreateNoteFromVisualSelection<cr>", desc = "New Project note", silent = true }



-- maps.n["<Leader>nt"] = { desc = "Todo's" }
-- maps.n["<Leader>ntt"] = { "<cmd>lua _TASKS_TOGGLE()<CR>", desc = "Tasks today" }
-- maps.n["<Leader>ntt"] = { "<cmd>ToDoTxtTasksToggle<CR>", desc = "Todos toggle" }
-- maps.n["<Leader>ntc"] = { "<cmd>ToDoTxtCapture<CR>", desc = "Todos capture" }

-- maps.n["<Leader>nf"] = { desc = "Find notes" }
maps.n["<Leader>nw"] = { "<Cmd>ZkGrep<CR>", desc = "Grep" }
maps.n["<Leader>nt"] = { "<Cmd>ZkTags<CR>", desc = "By tags" }
maps.n["<Leader>nl"] = { "<Cmd>ZkLinks<CR>", desc = "Links" }
maps.n["<Leader>nb"] = { "<Cmd>ZkBacklinks<CR>", desc = "Backlinks" }
maps.n["<Leader>no"] = { "<Cmd>ZkOrphans<CR>", desc = "Orphans" }

-- maps.n["<Leader>nj"] = { desc = "New dalily journal" }
-- maps.n["<Leader>njd"] = { "<cmd>ZkFindOrCreateJournalDailyNote<cr>", desc = "New dalily journal" }
-- maps.n["<Leader>njf"] = { "<cmd>ZkNew{group='fer', dir='journal/fer'}<cr>", desc = "New fer session" }

-- maps.n["<Leader>ns"] = { "<cmd>lua _SCRATCHPAD_TOGGLE()<cr>", desc = "Scratch Pad" }

-- +Toggle
-- maps.n["<Leader>ub"] = { "<cmd>lua require('user.core.utils').toggle_theme()<cr>", desc = "Toggle theme" }
-- maps.n["<Leader>ux"] = { "<cmd>lua require('user.core.utils').toggle_lsp_virtual_text_popup()<cr>", desc = "Toggle Lsp virtual text popup" }
-- maps.n["<Leader>uo"] = { "<cmd>lua require('aerial').toggle()<cr>", desc = "Outline" }

-- +Text
maps.n["<Leader>x"] = { desc = "Text" }
maps.v["<Leader>x"] = { desc = "Text" }
maps.v["<Leader>xa"] = { desc = "Align" }
maps.n["<Leader>xi"] = { desc = "Text Case" }
maps.n["<Leader>xi."] = { "<cmd>TextCaseOpenTelescope<CR>", desc = "Current word" }
maps.n["<Leader>xiq"] = { "<cmd>TextCaseOpenTelescopeQuickChange<CR>", desc = "Telescope Quick Change" }
maps.n["<Leader>xil"] = { "<cmd>TextCaseOpenTelescopeLSPChange<CR>", desc = "Telescope LSP Change" }
maps.n["<Leader>xr"] = { [[:%s/\<<C-r><C-w>\>/]], desc = "Replace" }

-- T ------------------------------------------------------------------------------------
maps.t["\\\\"] = { "<cmd>ToggleTermToggleAll<cr>" }
maps.t["<c-q>"] = { "<C-\\><C-n>" }
maps.t["<c-c>"] = { "<C-\\><C-n>" }
-- maps.t["<Esc>"] = { "<C-\\><C-n>" }

maps.t["<C-h>"] = false
maps.t["<C-j>"] = false
maps.t["<C-k>"] = false
maps.t["<C-l>"] = false
-- stylua: ignore end

return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = maps,
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      maps = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
