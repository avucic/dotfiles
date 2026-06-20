-- stylua: ignore start
local map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', { silent = true }, opts or {}))
end

-- Clear search and notifications on <Esc>
map('n', '<Esc>', function()
  vim.cmd('nohlsearch')
  vim.b.snacks_words = false
  vim.lsp.buf.clear_references()
  pcall(function() Snacks.notifier.hide() end)
  vim.defer_fn(function() vim.b.snacks_words = nil end, 300)
end)
map('n', '<Esc><Esc>', function()
  vim.cmd('nohlsearch')
  vim.b.snacks_words = false
  vim.lsp.buf.clear_references()
  pcall(function() Snacks.notifier.hide() end)
  vim.defer_fn(function() vim.b.snacks_words = nil end, 300)
end)

-- Window navigation
map({ 'n', 'x' }, '<C-h>', '<C-w>h')
map({ 'n', 'x' }, '<C-j>', '<C-w>j')
map({ 'n', 'x' }, '<C-k>', '<C-w>k')
map({ 'n', 'x' }, '<C-l>', '<C-w>l')

-- saving
map('n', '<Leader>W', '<cmd>:noa w<cr>', { desc = 'Save without format' })
map('n', '<Leader>w', '<cmd>:w<cr>', { desc = 'Save' })

-- Quit all
map('n', 'Q', '<cmd>qall!<cr>')

-- Better movement
map({ 'n', 'v' }, '<S-l>', '$')
map({ 'n', 'v' }, '<S-h>', '^')

-- Don't yank on visual paste
map('v', 'p', '"_dP')

-- Disable annoying defaults
map('n', '<C-z>', '<Nop>')
map('n', '<A-j>', '<Nop>')
map('n', '<A-k>', '<Nop>')

-- Command line navigation (emacs-style)
vim.cmd([[
  cnoremap <C-A> <Home>
  cnoremap <C-F> <Right>
  cnoremap <C-B> <Left>
]])

-- Visual search/replace of selection
vim.cmd([[vnoremap <C-r> "hy:%s^<C-r>h^^gI<left><left><left>]])
vim.cmd([[vnoremap <C-g> "hy:g/<C-r>h/normal<space>]])

-- Save without format
map('n', '<Leader>W', '<cmd>:noa w<cr>', { desc = 'Save without format' })

-- Window management
map('n', '<C-w>q', '<cmd>q<cr>', { desc = 'Close' })
map('n', '<C-w>D', '<cmd>only<cr>', { desc = 'Close others' })
map('n', '<C-w>p', '<cmd>lua require("plugins.custom.window_picker").pick()<cr>', { desc = 'Pick window' })
map('n', '<C-w>d', '<cmd>lua require("plugins.custom.window_picker").pick({ delete = true })<cr>', { desc = 'Pick to delete' })
map('n', 'gw',     '<cmd>lua require("plugins.custom.window_picker").pick()<cr>')

-- Tabs
map('n', '<C-w>tn', '<cmd>tabnew<cr>', { desc = 'New tab' })
map('n', '<C-w>tq', '<cmd>tabclose<cr>', { desc = 'Close tab' })

-- Files
map('n', '<Leader>fn', '<cmd>enew<cr>', { desc = 'New file' })
map('n', '<Leader>fy', '<cmd>let @*=expand("%:.")<cr>', { desc = 'Yank file path' })
map('n', '<Leader>fY', '<cmd>let @*=expand("%:p")<cr>', { desc = 'Yank full file path' })
map('n', '<Leader>fx', '<cmd>OpenFile<cr>', { desc = 'Open file in system app' })
map('n', '<Leader>fX', '<cmd>OpenFolderInFinder<cr>', { desc = 'Open folder in Finder' })
map('n', '<Leader>fR', '<cmd>e %<cr>', { desc = 'Reload file' })

-- Buffers

-- Git
map('n', '<Leader>gs', '<cmd>Neogit kind=split<cr>',                                  { desc = 'Git status' })
map('n', '<Leader>gn', function() require('neogit').open() end,                        { desc = 'Neogit' })
map('n', '<Leader>gg', function() Snacks.lazygit() end,                                { desc = 'Lazygit' })
map('n', '<Leader>gb', function() Snacks.picker.git_branches() end,                    { desc = 'Git branches' })
map('n', '<Leader>gc', function() Snacks.picker.git_log() end,                         { desc = 'Git commits (repo)' })
map('n', '<Leader>gC', function() Snacks.picker.git_log_file() end,                    { desc = 'Git commits (file)' })
map('n', '<Leader>go', function() Snacks.gitbrowse() end,                              { desc = 'Git browse' })
map('x', '<Leader>go', function() Snacks.gitbrowse() end,                              { desc = 'Git browse' })
map('n', '<Leader>gO', function() Snacks.gitbrowse({ branch = (vim.g.project or {}).git_browse_main_branch or 'master' }) end, { desc = 'Git browse (main)' })
map('x', '<Leader>gO', function() Snacks.gitbrowse({ branch = (vim.g.project or {}).git_browse_main_branch or 'master' }) end, { desc = 'Git browse (main)' })
map('n', '<Leader>gnN', '<cmd>GenerateBranchName<cr>',                                 { desc = 'Generate branch name' })

-- Open
map('n', '<Leader>ot', function() require('plugins.custom.float_term').open({ cmd = 'tuxedo', title = 'Tuxedo' }) end, { desc = 'Todos (tuxedo)' })
map('n', '<Leader>o/', function() Snacks.terminal() end, { desc = 'Terminal' })


-- Text
map('n', '<Leader>xr', [[:%s/\<<C-r><C-w>\>/]], { desc = 'Replace word' })

-- Notes
map('n', '<Leader>nS', function() require('utils.core').open_scratch_float() end, { desc = 'Scratch' })


-- Terminal
map('t', '<C-q>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<C-c>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '\\\\', '<cmd>lua Snacks.terminal.toggle()<cr>', { desc = 'Toggle terminal' })

-- LSP (supplement native gr* mappings)
map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Declaration' })
map({ 'n', 'v' }, '<Leader>la', vim.lsp.buf.code_action,                                              { desc = 'LSP code action' })
map({ 'n', 'v' }, '<Leader>lA', function() vim.lsp.buf.code_action({ context = { only = { 'source' }, diagnostics = {} } }) end, { desc = 'LSP source action' })
map('n', '<Leader>lf', function() vim.lsp.buf.format({ async = true }) end,                           { desc = 'Format buffer' })
map('n', '<Leader>lh', vim.lsp.buf.signature_help,                                                    { desc = 'Signature help' })
map('n', '<Leader>li', '<cmd>LspInfo<cr>',                                                            { desc = 'LSP information' })
map('n', '<Leader>ll', function() vim.lsp.codelens.refresh() end,                                     { desc = 'CodeLens refresh' })
map('n', '<Leader>lL', function() vim.lsp.codelens.run() end,                                         { desc = 'CodeLens run' })
map('n', '<Leader>lr', vim.lsp.buf.rename,                                                            { desc = 'Rename symbol' })
-- stylua: ignore end
