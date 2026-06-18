return {
  -- ── vim-tmux-navigator ────────────────────────────────────────────────────────
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
    config = function()
      vim.g.tmux_navigator_no_mappings = 1
      local map = function(lhs, rhs) vim.keymap.set({ 'n', 'x', 'i' }, lhs, rhs, { silent = true }) end
      map('<C-h>', '<cmd>TmuxNavigateLeft<cr>')
      map('<C-j>', '<cmd>TmuxNavigateDown<cr>')
      map('<C-k>', '<cmd>TmuxNavigateUp<cr>')
      map('<C-l>', '<cmd>TmuxNavigateRight<cr>')
      map('<C-\\>', '<cmd>TmuxNavigatePrevious<cr>')
    end,
  },

  -- ── vim-illuminate ────────────────────────────────────────────────────────────
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('illuminate').configure({
        providers = { 'lsp', 'treesitter', 'regex' },
        delay = 200,
        under_cursor = true,
      })
      vim.keymap.set('n', ']]', function() require('illuminate').goto_next_reference() end, { desc = 'Next reference' })
      vim.keymap.set('n', '[[', function() require('illuminate').goto_prev_reference() end, { desc = 'Prev reference' })
    end,
  },

  -- ── flash.nvim ────────────────────────────────────────────────────────────────
  {
    'folke/flash.nvim',
    keys = {
      { 'gV', function() require('flash').jump() end,       mode = { 'n', 'x', 'o' }, desc = 'Flash' },
      { 'gR', function() require('flash').treesitter() end, mode = { 'n', 'x', 'o' }, desc = 'Flash Treesitter' },
      { 'r',  function() require('flash').remote() end,     mode = 'o',               desc = 'Remote Flash' },
    },
    config = function()
      require('flash').setup({ modes = { char = { enabled = false } } })
    end,
  },

  -- ── nvim-surround ────────────────────────────────────────────────────────────
  {
    'kylechui/nvim-surround',
    event  = { 'BufReadPost', 'BufNewFile' },
    config = function() require('nvim-surround').setup() end,
  },

  -- ── dial.nvim ─────────────────────────────────────────────────────────────────
  {
    'monaqa/dial.nvim',
    keys = {
      { '<C-a>',  function() require('dial.map').manipulate('increment', 'normal') end },
      { '<C-x>',  function() require('dial.map').manipulate('decrement', 'normal') end },
      { '<C-a>',  function() require('dial.map').manipulate('increment', 'visual') end, mode = 'v' },
      { '<C-x>',  function() require('dial.map').manipulate('decrement', 'visual') end, mode = 'v' },
    },
    config = function()
      local augend = require('dial.augend')
      require('dial.config').augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      })
    end,
  },

  -- ── treesj (split/join) ──────────────────────────────────────────────────────
  {
    'Wansmer/treesj',
    keys   = { { 'gJ', '<cmd>TSJToggle<cr>', desc = 'Split/join' } },
    cmd    = { 'TSJToggle', 'TSJSplit', 'TSJJoin' },
    config = function() require('treesj').setup({ use_default_keymaps = false }) end,
  },

  -- ── text-case ─────────────────────────────────────────────────────────────────
  {
    'johmsalas/text-case.nvim',
    keys = {
      { '<Leader>xi.', mode = { 'n', 'v' } },
    },
    config = function()
      require('textcase').setup()
      local function textcase_pick(method)
        local tc = require('textcase')
        local cases = {
          { label = 'snake_case',    fn = tc.api.to_snake_case },
          { label = 'camelCase',     fn = tc.api.to_camel_case },
          { label = 'PascalCase',    fn = tc.api.to_pascal_case },
          { label = 'CONSTANT_CASE', fn = tc.api.to_constant_case },
          { label = 'dash-case',     fn = tc.api.to_dash_case },
          { label = 'dot.case',      fn = tc.api.to_dot_case },
          { label = 'Title Case',    fn = tc.api.to_title_case },
          { label = 'UPPER CASE',    fn = tc.api.to_upper_case },
          { label = 'lower case',    fn = tc.api.to_lower_case },
        }
        vim.ui.select(cases, { prompt = 'Text Case:', format_item = function(item) return item.label end },
          function(choice) if choice then choice.fn(method) end end)
      end
      vim.keymap.set('n', '<Leader>xi.', function() textcase_pick('current_word') end, { silent = true, desc = 'Text case word' })
      vim.keymap.set('v', '<Leader>xi.', function() textcase_pick('visual') end,       { silent = true, desc = 'Text case selection' })
    end,
  },

  -- ── align.nvim ────────────────────────────────────────────────────────────────
  {
    'Vonr/align.nvim',
    keys = {
      { '<Leader>xac', mode = 'v', function() require('align').align_to_char({ length = 1 }) end,               desc = '1 char' },
      { '<Leader>xas', mode = 'v', function() require('align').align_to_char({ length = 2, preview = true }) end, desc = '2 chars' },
      { '<Leader>xaw', mode = 'v', function() require('align').align_to_string({ preview = true, regex = false }) end, desc = 'String' },
      { '<Leader>xar', mode = 'v', function() require('align').align_to_char({ preview = true, regex = true }) end, desc = 'Regex' },
    },
  },

  -- ── yanky ─────────────────────────────────────────────────────────────────────
  {
    'gbprod/yanky.nvim',
    event = 'VeryLazy',
    config = function()
      require('yanky').setup({ ring = { history_length = 20 } })
      local map = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { silent = true }) end
      map('n', 'y',  '<Plug>(YankyYank)')
      map('n', 'p',  '<Plug>(YankyPutAfter)')
      map('n', 'P',  '<Plug>(YankyPutBefore)')
      map('n', ']p', '<Plug>(YankyCycleForward)')
      map('n', '[p', '<Plug>(YankyCycleBackward)')
    end,
  },

  -- ── vim-visual-multi ─────────────────────────────────────────────────────────
  {
    'mg979/vim-visual-multi',
    keys = { { '<C-n>', mode = { 'n', 'v' } }, { ',', mode = { 'n', 'v' } } },
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_mouse_mappings   = 1
      vim.g.VM_skip_empty_lines = 1
      vim.g.VM_leader           = ','
      vim.g.VM_maps = {
        ['Find Under']    = '<C-n>',
        ['Skip Region']   = '<C-x>',
        ['Remove Region'] = '<C-p>',
      }
    end,
  },

  -- ── harpoon ───────────────────────────────────────────────────────────────────
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    keys = {
      { 'ma', function() require('harpoon'):list():add() end,                                   desc = 'Harpoon add' },
      { 'ml', function() local h = require('harpoon') h.ui:toggle_quick_menu(h:list()) end,    desc = 'Harpoon list' },
      { 'mj', function() require('harpoon'):list():select(1) end,                               desc = 'Harpoon 1' },
      { 'mk', function() require('harpoon'):list():select(2) end,                               desc = 'Harpoon 2' },
      { 'mn', function() require('harpoon'):list():next() end,                                  desc = 'Harpoon next' },
      { 'mp', function() require('harpoon'):list():prev() end,                                  desc = 'Harpoon prev' },
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require('harpoon'):setup() end,
  },
}
