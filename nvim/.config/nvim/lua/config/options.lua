-- Mason bin must be on PATH before any LSP server starts
vim.env.PATH = vim.fn.stdpath('data') .. '/mason/bin:' .. vim.env.PATH

-- Editor options
vim.opt.clipboard = 'unnamedplus'

-- Auto-trust .nvim.lua files under /app (mounted workspace) inside containers.
-- On the host these files are explicitly trusted via :trust; inside Docker the
-- trust DB is separate so we whitelist the known-safe workspace root instead.
if io.open('/.dockerenv', 'r') then
  local nvim_lua = vim.fn.getcwd() .. '/.nvim.lua'
  if vim.uv.fs_stat(nvim_lua) then
    vim.secure.trust({ action = 'allow', path = nvim_lua })
  end
end

--In-container clipboard: OSC 52 via nvim_ui_send (stdout is a dead pipe in headless mode).
-- Paste served from local cache to avoid terminal read hangs.
-- tmux DCS passthrough always applied — $TMUX is unset inside container.
if io.open('/.dockerenv', 'r') then
  local cache = { ['+'] = { {}, 'v' }, ['*'] = { {}, 'v' } }

  local function osc52_seq(reg, b64)
    local clip  = reg == '+' and 'c' or 'p'
    local inner = string.format('\027]52;%s;%s\007', clip, b64)
    return '\027Ptmux;' .. inner:gsub('\027', '\027\027') .. '\027\\'
  end

  local function copy(reg)
    return function(lines, regtype)
      cache[reg] = { lines, regtype or 'v' }
      vim.api.nvim_ui_send(osc52_seq(reg, vim.base64.encode(table.concat(lines, '\n'))))
    end
  end

  local function paste(reg)
    return function() return cache[reg][1], cache[reg][2] end
  end

  vim.g.clipboard = {
    name  = 'osc52-tmux-remote',
    copy  = { ['+'] = copy('+'), ['*'] = copy('*') },
    paste = { ['+'] = paste('+'), ['*'] = paste('*') },
  }
end
vim.opt.mouse  = 'a'
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
vim.opt.spell = true
vim.opt.conceallevel = 2
vim.opt.foldenable    = true
vim.opt.foldlevel     = 99
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn    = '1'
vim.opt.exrc = true

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Appearance
vim.opt.shortmess:append('I')
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.pumheight = 12
vim.opt.pumblend = 0
vim.opt.winblend = 0
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.cmdheight = 1

-- Window title
local title_parts = {}
if vim.env.REMOTE_NVIM then table.insert(title_parts, 'REMOTE') end
if vim.env.DEVCONTAINER then table.insert(title_parts, 'DEV') end
table.insert(title_parts, 'nvim — %t')
vim.opt.title = true
vim.opt.titlestring = table.concat(title_parts, ' ')

-- Files
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.autowrite = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Completion
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,
  },
})

-- Filetype associations
vim.filetype.add({
  extension = {
    mdx = 'markdown',
    mjml = 'eruby',
    cedarschema = 'cedar',
    jbuilder = 'ruby',
  },
  filename = {
    ['todo.txt'] = 'todotxt',
    ['done.txt'] = 'todotxt',
  },
  pattern = {
    ['.env.*'] = 'sh',
    ['vifmrc'] = 'vim',
    ['todo.txt'] = 'todotxt',
    ['done.txt'] = 'todotxt',
  },
})

