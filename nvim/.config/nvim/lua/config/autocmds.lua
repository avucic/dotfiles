local augroup = function(name) return vim.api.nvim_create_augroup(name, { clear = true }) end

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function() vim.hl.on_yank() end,
})

-- Resize splits when window is resized
vim.api.nvim_create_autocmd('VimResized', {
  group = augroup('resize_splits'),
  callback = function() vim.cmd('tabdo wincmd =') end,
})

-- Close certain filetypes with q
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = { 'help', 'man', 'qf', 'lspinfo', 'checkhealth', 'neotest-output', 'neotest-summary' },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = ev.buf, silent = true })
  end,
})

-- Auto-create parent dirs on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup('auto_create_dir'),
  callback = function(ev)
    if ev.match:match('^%w%w+:[\\/][\\/]') then return end
    local file = vim.uv.fs_realpath(ev.match) or ev.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- LSP keymaps on attach
vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup('lsp_keymaps'),
  callback = function(ev)
    local buf = ev.buf
    local function map(mode, lhs, rhs, opts)
      vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', { buffer = buf, silent = true }, opts or {}))
    end
    map('n', 'K',          vim.lsp.buf.hover,            { desc = 'Hover' })
    map('n', 'gry', vim.lsp.buf.type_definition, { desc = 'Type definition' })
    map('n', '<Leader>ld', vim.diagnostic.open_float,     { desc = 'Diagnostics float' })
    map('n', '<Leader>lq', vim.diagnostic.setloclist,     { desc = 'Diagnostics loclist' })

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method('textDocument/inlayHint') then
      map('n', '<Leader>uh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
      end, { desc = 'Toggle inlay hints' })
    end
  end,
})

-- Strip formatting capability from LSP servers per project config
vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup('lsp_format_disable'),
  callback = function(args)
    local c = vim.lsp.get_client_by_id(args.data.client_id)
    if not c then return end
    local project = vim.g.project or {}
    local strip = (project.lsp and project.lsp.disable_formatting) or {}
    for _, name in ipairs(strip) do
      if c.name == name then
        c.server_capabilities.documentFormattingProvider = false
        c.server_capabilities.documentRangeFormattingProvider = false
        return
      end
    end
  end,
})

-- Large file: disable heavy features
vim.api.nvim_create_autocmd('BufReadPre', {
  group = augroup('large_file'),
  callback = function(ev)
    local max_size = 1024 * 256 -- 256 KB
    local ok, stat = pcall(vim.uv.fs_stat, ev.match)
    if ok and stat and stat.size > max_size then
      vim.b[ev.buf].large_file = true
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.cmd('syntax off')
    end
  end,
})

-- :LspInfo — show active LSP clients for current buffer
vim.api.nvim_create_user_command('LspInfo', function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    vim.notify('No LSP clients attached to this buffer', vim.log.levels.INFO)
    return
  end
  local lines = { 'LSP clients for ' .. vim.fn.expand('%:t') .. ':', '' }
  for _, c in ipairs(clients) do
    local fmt = c.server_capabilities.documentFormattingProvider and 'yes' or 'no'
    table.insert(lines, string.format('  %-20s root: %s', c.name, c.root_dir or '?'))
    table.insert(lines, string.format('  %-20s formatting: %s', '', fmt))
    table.insert(lines, '')
  end
  vim.notify(table.concat(lines, '\n'), vim.log.levels.INFO)
end, {})

-- Wrap and spell in text files
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('text_wrap_spell'),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
