return {
  -- ── oil.nvim ─────────────────────────────────────────────────────────────────
  {
    'stevearc/oil.nvim',
    -- Load early so it can intercept directory opens before netrw would
    event = 'VeryLazy',
    keys  = {
      { '<Leader>e',  '<cmd>Oil<cr>',                                              desc = 'Explorer (oil)' },
      { '<Leader>fe', '<cmd>Oil<cr>',                                              desc = 'Explorer (oil)' },
      { '-',          function() require('oil').open() end,                         desc = 'Oil parent dir' },
      { '_',          function() require('oil').open(vim.uv.cwd()) end,             desc = 'Oil cwd' },
    },
    config = function()
      require('oil').setup({
        default_file_explorer = true,
        columns               = { 'icon' },
        buf_options           = { buflisted = false, bufhidden = 'hide' },
        view_options = {
          show_hidden    = false,
          is_hidden_file = function(name, _) return vim.startswith(name, '.') end,
        },
        float    = { border = 'rounded' },
        keymaps  = {
          ['g.'] = 'actions.toggle_hidden',
          ['<CR>']  = 'actions.select',
          ['<C-s>'] = 'actions.select_split',
          ['<C-v>'] = 'actions.select_vsplit',
          ['<C-t>'] = 'actions.select_tab',
          ['<C-p>'] = 'actions.preview',
          ['<C-c>'] = 'actions.close',
          ['<C-l>'] = 'actions.refresh',
          ['-']     = 'actions.parent',
          ['_']     = 'actions.open_cwd',
          ['`']     = 'actions.cd',
          ['~']     = 'actions.tcd',
          ['gs']    = 'actions.change_sort',
          ['gx']    = 'actions.open_external',
          ['g?']    = 'actions.show_help',
          ['q']     = 'actions.close',
        },
        use_default_keymaps = false,
      })
    end,
  },

  -- ── neo-tree ──────────────────────────────────────────────────────────────────
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch       = 'v3.x',
    dependencies = { 'nvim-lua/plenary.nvim', 'echasnovski/mini.nvim', 'MunifTanjim/nui.nvim' },
    keys = {
      { '<Leader>E', '<cmd>Neotree toggle<cr>', desc = 'Explorer (neo-tree)' },
    },
    config = function()
      require('neo-tree').setup({
        close_if_last_window = true,
        window = { width = 30 },
        filesystem = {
          filtered_items = {
            hide_dotfiles   = true,
            hide_gitignored = true,
          },
          follow_current_file = { enabled = true },
        },
      })
    end,
  },
}
