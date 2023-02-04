local M = {}

function M.config()
  vim.cmd([[vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>]])

  -- command line
  vim.cmd([[
    cnoremap <C-A> <Home>
	  cnoremap <C-F> <Right>
	  cnoremap <C-B> <Left>
    ]])

  local maps = { i = {}, n = {}, v = {}, t = {}, x = {} }

  -- N ------------------------------------------------------------------------------------

  maps.n["<leader>c"] = false
  maps.n["<leader>C"] = false
  maps.n["<leader>n"] = false

  maps.n["<c-q>"] = { "<cmd>silent! cclose<cr><cmd>nohlsearch<cr><cmd>ToggleTermToggleAll<cr>" }
  maps.n["<esc>"] = { "<cmd>nohlsearch<cr><cmd>lua require('notify').dismiss()<cr>" }
  maps.n["<esc><esc>"] = { "<cmd>nohlsearch<cr>" }
  maps.n["Q"] = { "<cmd>qall!<cr>" }
  maps.n["<S-l>"] = { "$" }
  maps.n["<S-h>"] = { "^" }
  maps.n["z="] = { "<cmd>lua require('telescope.builtin').spell_suggest()<CR>" }
  maps.n["<leader>W"] = { "<cmd>:noa w<cr>", desc = "Save without format" }
  maps.n["ww"] = { "<cmd>lua require('user.core.plugins.window_picker').pick()<cr>" }
  maps.n["gVa"] = { "<cmd>lua require'nvim-treesitter.incremental_selection'.node_incremental()<cr><cmd>WhichKey gV<cr>", desc = "Increment", }
  maps.n["gVd"] = { "<cmd>lua require'nvim-treesitter.incremental_selection'.node_decremental()<cr><cmd>WhichKey gV<cr>", desc = "Decremental", }

  -- remove from Astrovim. TODO: better way?
  maps.n["<A-j>"] = { "<Nop>" }
  maps.n["<A-k>"] = { "<Nop>" }

  -- c-w  +Windows
  maps.n["<c-w>q"] = { "<cmd>:q<cr>", desc = "Close" }
  maps.n["<c-w>d"] = { "<cmd>lua require('user.core.plugins.window_picker').pick({delete = true })<cr>", desc = "Pick to delete" }
  maps.n["<c-w>D"] = { "<cmd>only<cr>", desc = "Close others" }
  maps.n["<c-w>T"] = { "<c-w>t", desc = "Move to new tab" }
  maps.n["<c-w>="] = { "<cmd>WindowsEqualize<CR><cmd>WindowsDisableAutowidth<cr>", desc = "Equalize" }
  maps.n["<c-w>s"] = { "<cmd>split +enew<cr>", desc = "Split horizontaly" }
  maps.n["<c-w>v"] = { "<cmd>vsplit +enew<cr>", desc = "Split verticaly" }
  maps.n["<c-w>z"] = { "<cmd>WindowsMaximize<CR>", desc = "maximize" }
  maps.n["<c-w>Z"] = { "<cmd>NeoZoomToggle<CR>", desc = "zoom" }
  maps.n["<c-w>o"] = { "<C-w>o", desc = "Remain only" }
  maps.n["<c-w>p"] = { "<cmd>lua require('user.core.plugins.window_picker').pick()<cr>", desc = "Pick window" }

  -- tabs
  maps.n["<c-w>tt"] = { "<cmd>lua require('telescope-tabs').list_tabs()<cr>", desc = "List tabs" }
  maps.n["<c-w>tn"] = { "<cmd>tabnew<cr>", desc = "new tab" }
  maps.n["<c-w>tq"] = { "<cmd>tabclose<cr>", desc = "Close tab" }

  -- +Files
  maps.n["<leader>fn"] = { "<cmd>enew<cr>", desc = "New file" }
  maps.n["<leader>fE"] = { "<Cmd>lua require('telescope').extensions.file_browser.file_browser({files=true})<CR>", desc = "Recent files", }
  maps.n["<leader>fe"] = { "<Cmd>lua require('telescope').extensions.file_browser.file_browser({files=true, path=vim.fn.expand('%:p:h')})<CR>", desc = "Recent files", }
  maps.n["<leader>fg"] = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", desc = "Live grep", }
  maps.n["<leader>fo"] = { "<Cmd>lua require('telescope').extensions.smart_open.smart_open()<CR>", desc = "Recent files" }
  maps.n["<leader>fp"] = { "<cmd>lua require('telescope').extensions.project.project{}<CR>", desc = "Projects" }
  maps.n["<leader>f/"] = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", desc = "Fuzzy find" }
  maps.n["<leader>f?"] = { "<cmd>lua require('telescope.builtin').search_history()<CR>", desc = "History" }
  maps.n["<leader>fR"] = { "<cmd>e %<CR>", desc = "Reload" }
  maps.n["<leader>fy"] = { "<cmd>let @*=expand('%')<cr>", desc = "Yank file path" }
  maps.n["<leader>fY"] = { "<cmd>let @*=expand('%:p')<cr>", desc = "Yank full file path" }
  maps.n["<leader>fx"] = { "<cmd>OpenFileInFinder<cr>", desc = "Open file in folder" }
  maps.n["<leader>fX"] = { "<cmd>OpenFolderInFinder<cr>", desc = "Open folder" }
  maps.n["<leader>fT"] = { "<cmd>lua require('telescope.builtin')<CR>:Telescope<CR>", desc = "Open telescope" }

  -- +Buffers
  maps.n["<leader>bb"] = { "<cmd>lua require('telescope.builtin').buffers()<CR>", desc = "History" }
  maps.n["<leader>bh"] = { "<cmd>BufferLineCyclePrev<cr><cmd>WhichKey <LT>leader>b<CR>", desc = "Next" }
  maps.n["<leader>bl"] = { "<cmd>BufferLineCycleNext<cr><cmd>WhichKey <LT>leader>b<CR>", desc = "Previous" }
  maps.n["<leader>bH"] = { "<cmd>BufferLineMovePrev<cr><cmd>WhichKey <LT>leader>b<CR>", desc = "Move Previous" }
  maps.n["<leader>bL"] = { "<cmd>BufferLineMoveNext<cr><cmd>WhichKey <LT>leader>b<CR>", desc = "Move next" }
  maps.n["<leader>bq"] = { "<cmd>bd<CR>", desc = "Delete" }
  maps.n["<leader>bP"] = { "<cmd>BufferLIneTogglePin<CR>", desc = "Pin" }
  maps.n["<leader>bp"] = { "<cmd>BufferLinePick<CR>", desc = "Pick" }
  maps.n["<leader>bse"] = { "<cmd>BufferLineSortByExtension<CR>", desc = "Sort by extension" }
  maps.n["<leader>bsd"] = { "<cmd>BufferLineSortByDirectory<CR>", desc = "Sort by directory" }
  maps.n["<leader>bsr"] = { "<cmd>BufferLineSortByRelativeDirectory<CR>", desc = "Sort by relative directory" }
  maps.n["<leader>bo"] = { "<cmd>BufferLineSortByRelativeDirectory<CR>", desc = "Sort by relative directory" }
  maps.n["<leader>b\\"] = false
  maps.n["<leader>b|"] = false

  -- +Session
  maps.n["<leader>Sl"] = { "<cmd>lua require('nvim-possession').list()<cr>", desc = "List" }
  maps.n["<leader>Sn"] = { "<cmd>lua require('nvim-possession').new()<cr>", desc = "New" }
  maps.n["<leader>Su"] = { "<cmd>lua require('nvim-possession').update()<cr>", desc = "Update" }

  -- +Git
  maps.n["<leader>gr"] = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset hunk" }
  maps.n["<leader>gR"] = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset buffer" }
  maps.n["<leader>gl"] = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame" }
  maps.n["<leader>gO"] = { "<cmd>OpenInGHFile<cr>", desc = "Open current file in Github" }
  maps.n["<leader>go"] = { "<cmd>OpenInGHRepo<cr>", desc = "Open page with line in Github" }
  maps.n["<leader>gs"] = { "<cmd>lua require('user.core.utils').toggle_term_cmd('lazygit --use-config-file ~/.config/lazygit/config.yml', {direction = 'float'})<CR>", desc = "Git status", }
  maps.n["<leader>gu"] = false
  maps.n["<leader>gt"] = false
  maps.n["<leader>gb"] = false
  maps.n["<leader>gc"] = false

  -- +Terminal
  maps.n["<leader>tt"] = { "<cmd>lua require('user.configs.toggleterm').open_terminal('horizontal', 1)<cr>", desc = "Defaul", }
  maps.n["<leader>tr"] = { "<Cmd>ToggleTermSetName<CR>", desc = "Rename" }
  maps.n["<leader>tf"] = { "<cmd>lua require('user.configs.toggleterm').open_terminal('float', 1)<cr>", desc = "Float" }
  maps.n["<leader>tF"] = { "<cmd>lua require('user.configs.toggleterm').open_terminal('float')<cr>", desc = "New float" }
  maps.n["<leader>tN"] = { "<cmd>lua require('user.configs.toggleterm').open_terminal('horizontal', nil)<cr>", desc = "New", }
  maps.n["<leader>tv"] = { "<cmd>lua require('user.configs.toggleterm').open_terminal('vertical', 1)<cr>", desc = "Vertical", }
  maps.n["<leader>tV"] = { "<cmd>lua require('user.configs.toggleterm').open_terminal('vertical')<cr>", desc = "New vertical", }
  maps.n["<leader>tT"] = { "<cmd>lua require('user.configs.toggleterm').open_terminal('tab', 1)<cr>", desc = "List terminals", }
  maps.n["<leader>tl"] = { "<cmd>lua require('user.plugins.toggleterm_telescope').open()<cr>", desc = "List terminals" }
  maps.n["<leader>tL"] = false
  maps.n["<leader>tn"] = false
  maps.n["<leader>tp"] = false
  maps.n["<leader>th"] = false

  -- +Jump
  maps.n["<leader>jn"] = { "<cmd>lua require('aerial').next()<cr><cmd>WhichKey <LT>leader>j<CR>", desc = "Aerial next" }
  maps.n["<leader>jN"] = { "<cmd>lua require('aerial').next(-1)<cr><cmd>WhichKey <LT>leader>j<CR>", desc = "Aerial previous", }
  maps.n["<leader>jr"] = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", desc = "LSP references" }

  -- +LSP 
  maps.n["<leader>lK"]= { "<cmd>lua vim.lsp.buf.hover()<CR>",  desc = "Hover symbol details" }
  maps.n["<leader>la"]={"<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code action" }
  maps.n["<leader>le"]={"<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Diagnostic buffer" }
  maps.n["<leader>lD"]={"<cmd>lua vim.lsp.buf.declaration()<CR>", }
  maps.n["<leader>ld"]={"<cmd>Glance definitions<CR>", desc = "Definition" }
  maps.n["<leader>lwe"]={"<cmd>Telescope diagnostics<cr>", desc  = "Diagnostic workspace" }
  maps.n["<leader>lwa"]={"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", desc = "Add" }
  maps.n["<leader>lwr"]={"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", desc = "Remove" }
  maps.n["<leader>lws"]={"<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", desc = "Symbols" }
  maps.n["<leader>lf"]={"<cmd>lua vim.lsp.buf.format({async = true })<cr>", desc = "Format" }
  maps.n["<leader>li"]={"<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Implementation" }
  maps.n["<leader>lI"]={"<cmd>Mason<cr>", desc  = "Info" }
  maps.n["<leader>ln"]={"<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next diagnostic" }
  maps.n["<leader>lp"]={"<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Previous diagnostic" }
  maps.n["<leader>ll"]={"<cmd>lua vim.lsp.codelens.run()<cr>", desc = "Codelens" }
  maps.n["<leader>lr"]={"<cmd>Glance references<CR>", desc = "References" }
  maps.n["<leader>lR"]={"<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" }
  -- { "R", function() return ":IncRename " .. vim.fn.expand("<cword>") end, { expr = true, exit = true, }, },
  maps.n["<leader>lG"]= false

  -- +Notes
  maps.n["<leader>no"] = { "<Cmd>ZkOpenNotes<CR>", desc = "Open notes" }
  maps.n["<leader>ni"] = { "<cmd>ZkOpenNotebook<CR>", desc = "Open notebook" }
  maps.n["<leader>n."] = { "<Cmd>ZkCd<CR>", desc = "cdw" }
  maps.n["<leader>nR"] = { "<Cmd>ZkIndex<CR>", desc = "Reindex" }
  maps.n["<leader>nc"] = { "<cmd>ZkShowCalendar<cr>", desc = "Calendar" }
  maps.n["<leader>nnr"] = { "<cmd>:ZkFindOrCreateNote { group='reference_notes', dir='references'}<cr>", desc = "Reference note" }
  maps.n["<leader>nns"] = { "<cmd>:ZkFindOrCreateNote { group='permanent_notes', dir='references'}<cr>", desc = "Slip note" }
  maps.n["<leader>nnd"] = { "<cmd>:ZkFindOrCreateNote { group='fleeting_notes', dir='references'}<cr>", desc = "Daily note" }
  maps.n["<leader>nnl"] = { "<cmd>:ZkFindOrCreateNote { group='literature_notes', dir='references'}<cr>", desc = "Literature note" }
  maps.n["<leader>nnp"] = { "<cmd>:ZkFindOrCreateProjectNote<cr>", desc = "Project note" }

  maps.n["<leader>nt"] = { "<cmd>lua require('user.core.utils').toggle_term_cmd('vit list due:today or +next', {direction = 'float'})<CR>", desc = "Tasks today" }
  maps.n["<leader>nT"] = { "<cmd>lua require('user.core.utils').toggle_term_cmd('timew week', {direction = 'float'})<CR>", desc = "Tasks week" }
  maps.n["<leader>no"] = { "<cmd>ZkAnnotateTask<cr>", desc = "Tasks week" }

  maps.n["<leader>nfg"] = { "<Cmd>ZkGrep<CR>", desc = "Grep" }
  maps.n["<leader>nft"] = { "<Cmd>ZkTags<CR>", desc = "By tags" }
  maps.n["<leader>nfl"] = { "<Cmd>ZkTags<CR>", desc = "Links" }
  maps.n["<leader>nfb"] = { "<Cmd>ZkTags<CR>", desc = "Backlinks" }
  maps.n["<leader>nfo"] = { "<Cmd>ZkTags<CR>", desc = "Orphans" }

  maps.n["<leader>njd"] = { "<cmd>:ZkFindOrCreateJournalDailyNote<cr>", desc = "New dalily journal" }
  maps.n["<leader>njf"] = { "<cmd>:ZkNew{group='fer', dir='journal/fer'}<cr>", desc = "New fer session" }

  -- +Open
  maps.n["<leader>ott"] = { "<cmd>Telescope toggletasks spawn<cr>", desc = "New" }
  maps.n["<leader>otl"] = { "<cmd>Telescope toggletasks select<cr>", desc = "List" }
  maps.n["<leader>ote"] = { "<cmd>Telescope toggletasks edit<cr>", desc = "Edit" }
  maps.n["<leader>oo"] = { "<cmd>AerialToggle! right<cr>", desc = "Symbols outline" }
  maps.n["<leader>og"] = { "<cmd>ChatGPT<cr>", desc = "ChatGPT" }
  maps.n["<leader>odo"] = { "<cmd>lua require('user.configs.dadbod').db_tasks()<cr>", desc = "Open DB Connection" }
  maps.n["<leader>odt"] = { "<cmd>DBUIToggle<cr>", desc = "Toggle DB Connection" }

  -- +Search
  maps.n["<leader>sh"] = {"<cmd>lua require('telescope.builtin').help_tags()<CR>", desc = "Help" }
  maps.n["<leader>sk"] = {"<cmd>lua require('telescope.builtin').keymaps()<CR>", desc = "Keymaps" }
  maps.n["<leader>ss"] = {"<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", desc = "Symbols" }
  maps.n["<leader>sS"] = {"<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", desc = "Workspace symbols" }
  maps.n["<leader>so"] = {"<cmd>Telescope aerial<cr>", desc = "Outline" }
  maps.n["<leader>sO"] = {"<cmd>lua require('telescope.builtin').vim_options()<CR>", desc = "Options" }
  maps.n["<leader>s;"] = {"<cmd>lua require('telescope.builtin').command_history()<CR>", desc = "History" }
  maps.n["<leader>sc"] = {"<cmd>lua require('telescope.builtin').commands()<CR>", desc = "Commands" }
  maps.n["<leader>s<cr>"] = {"<cmd>lua require('telescope.builtin').resume()<CR>", desc = "Resume" }
  maps.n["<leader>sb"] = {"<cmd>lua require('telescope.builtin').buffers()<CR>", desc = "Buffers" }
  maps.n["<leader>sw"] = {"<cmd>BrowserSearch<cr>", desc = "Web" }
  maps.n["<leat>st"] =  {"<cmd>lua require('telescope').extensions.vstask.tasks()<cr>", desc = "Tasks"}

  -- +Toggle
  maps.n["<leader>um"] = {"<cmd>lua require('telescope').extensions.vstask.tasks()<cr>", desc = "Tasks"}
  maps.n["<leader>ump"]= {"<cmd>TZAtaraxis<cr>",  desc = "poet mode"  }
  maps.n["<leader>umf"]= {"<cmd>TZFocus<cr>",  desc = "focus mode"  }
  maps.n["<leader>umm"]= {"<cmd>TZMinimalist<cr>",  desc = "minimalist mode"  }
  maps.v["<leader>umn"]= {"<cmd>'<,'>TZNarrow<cr>",  desc = "narrow"  }

  -- +Text
  maps.v["<leader>xi"] = {"<Plug>(Inflect)",  desc = "Inflect"}
  maps.v["<leader>xea"] = { "<Plug>(EasyAlign)",  desc = "EasyAlign"}
  maps.v["<leader>xs"] = { "<cmd>lua require('silicon').visualise_api({})<cr>",  desc = "Generate code image" , }
  maps.v["<leader>xdt"] = { [[<cmd>lua print(io.popen("jwt decode ".. vim.fn.getreg('"') or ""):read("*a"))<cr>]], desc = "Base64 Decode token" }
  maps.n["<leader>xt"] = { "<cmd>lua require('nvim-toggler').toggle()<cr>",  desc = "Toggle word" }
  maps.v["<leader>xge"]= {":'<,'>Translate English<CR>", desc = "english" }
  maps.v["<leader>xgs"]= {":'<,'>Translate Serbian<CR>", desc = "serbian" }

  -- +Yank
  maps.n["<leader>yy"]= {"<cmd>lua require('telescope').extensions.neoclip.default()<cr>", desc = "History" }
  maps.n["<leader>ym"]= {"<cmd>lua require('telescope').extensions.macroscope.default()<cr>", desc = "Macro history" }
  maps.n["<leader>yD"]= {"<cmd>lua require('neoclip').clear_history()<cr>", desc = "Clear history" }

  -- Bookmarks
  maps.n["mm"] = { ":BookmarkToggle<cr>", desc = "Toggle bookmarks" }
  maps.n["ma"] = { ":lua require('user.configs.vim_bookmarks').open_bookmarks_workaround()<cr>", desc = "List all Bookmarks", }
  maps.n["mf"] = { ":lua require('telescope').extensions.vim_bookmarks.current_file()<cr>", desc = "List current file Bookmarks", }
  maps.n["mD"] = {"<cmd>normal mx<cr>", desc = "Delete bookmarks"}

  -- portal
  maps.n["<c-o>"] = {"<cmd>lua require('portal').jump_backward()<cr>", desc = "Backward"}
  maps.n["<c-i>"] ={ "<cmd>lua require('portal').jump_forward()<cr>", desc = "Forward"}

  -- Leap
  maps.n["s"] = { "<cmd>lua require('leap')<cr><Plug>(leap-forward-to)" }
  maps.n["ss"] = { "<cmd>lua require('leap')<cr><Plug>(leap-forward-till)" }
  maps.n["S"] = { "<cmd>lua require('leap')<cr><Plug>(leap-backward-to)" }
  maps.n["SS"] = { "<cmd>lua require('leap')<cr><Plug>(leap-backward-till)" }
  maps.n["gs"] = "<cmd>lua require('leap')<cr><Plug>(leap-cross-window)"
  maps.n["sp"] = { "<cmd>lua require('user.configs.leap').paranormal()<cr>" }

  -- multiple Cursor
  maps.n["<C-n>"] = "<Nop>"
  maps.n["<C-p>"] = "<Nop>"
  maps.n["<M-n>"] = { "<Plug>(VM-Add-Cursor-Down)" }
  maps.n["<M-p>"] = { "<Plug>(VM-Add-Cursor-up)" }

  -- toggle term
  maps.n["\\"] = "<Nop>"
  maps.n["\\\\"] = { "<cmd>ToggleTermToggleAll<cr>" }

  -- search google
  -- maps.n["<leader>sw"] = { ":BrowserSearch<cr>" }
  -- EasyAlign
  -- maps.n["ga"] = { "<Plug>(EasyAlign)" }
  -- Markdown bullets
  -- maps.n["=q"] = function()
  --   local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  --   local action = qf_winid > 0 and "cclose" or "copen"
  --   vim.cmd("botright " .. action)
  -- end
  -- maps.n["=l"] = function()
  --   local win = vim.api.nvim_get_current_win()
  --   local qf_winid = vim.fn.getloclist(win, { winid = 0 }).winid
  --   local action = qf_winid > 0 and "lclose" or "lopen"
  --   vim.cmd(action)
  -- end

  -- treesj
  maps.n["gS"] = { "<cmd>TSJSplit<cr>" }
  maps.n["gJ"] = { "<cmd>TSJJoin<cr>" }
  maps.n["K"] = { "<leader>lK", remap = true } -- shortcut

  -- V ------------------------------------------------------------------------------------

  maps.v["gVa"] = maps.n["gVa"]
  maps.v["gVd"] = maps.n["gVd"]
  maps.v["<S-l>"] = { "$", desc = "Jump to end of line" }
  maps.v["<S-h>"] = { "^", desc = "Jump to the begging of line" }
  -- Stay in indent mode
  maps.v["<"] = { "<gv", desc = "Move left" }
  maps.v[">"] = { "gv>", desc = "Move right" }
  maps.v["p"] = { '"_dP' }
  -- inflect
  -- maps.v["gI"] = { "<Plug>(Inflect)" }
  -- search google
  -- maps.v["<leader>sg"] = { ":BrowserSearch<cr>" }

  -- Leap
  maps.v["s"] = maps.n["s"]
  maps.v["ss"] = maps.n["ss"]
  maps.v["SS"] = maps.n["SS"]
  maps.v["<c-f>"] = { "y<ESC>:lua require('telescope.builtin').live_grep({default_text= vim.fn.getreg('*')})<CR>" }

  -- X ------------------------------------------------------------------------------------
  maps.x["J"] = { ":move '>+1<CR>gv-gv" }
  maps.x["K"] = { ":move '<-2<CR>gv-gv" }

  -- T ------------------------------------------------------------------------------------
  maps.t["\\\\"] = { "<cmd>ToggleTermToggleAll<cr>" }

  return maps
end

return M
