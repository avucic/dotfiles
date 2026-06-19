return {
  -- ── gitsigns ─────────────────────────────────────────────────────────────────
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '▎' },
          change       = { text = '▎' },
          delete       = { text = '' },
          topdelete    = { text = '' },
          changedelete = { text = '▎' },
          untracked    = { text = '▎' },
        },
        on_attach = function(bufnr)
          local gs = require('gitsigns')
          local function map(mode, lhs, rhs, opts)
            vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', { buffer = bufnr, silent = true }, opts or {}))
          end
          map('n', ']h', function() gs.nav_hunk('next') end, { desc = 'Next hunk' })
          map('n', '[h', function() gs.nav_hunk('prev') end, { desc = 'Prev hunk' })
          map('n', '<Leader>ghs', gs.stage_hunk,  { desc = 'Stage hunk' })
          map('n', '<Leader>ghr', gs.reset_hunk,  { desc = 'Reset hunk' })
          map('v', '<Leader>ghs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = 'Stage hunk' })
          map('v', '<Leader>ghr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = 'Reset hunk' })
          map('n', '<Leader>ghS', gs.stage_buffer,  { desc = 'Stage buffer' })
          map('n', '<Leader>ghR', gs.reset_buffer,  { desc = 'Reset buffer' })
          map('n', '<Leader>ghp', gs.preview_hunk,  { desc = 'Preview hunk' })
          map('n', '<Leader>ghb', function() gs.blame_line({ full = true }) end, { desc = 'Blame line' })
          map('n', '<Leader>ghd', gs.diffthis,       { desc = 'Diff this' })
          map('n', '<Leader>gl',  gs.blame_line,                               { desc = 'Blame line' })
          map('n', '<Leader>gL',  function() gs.blame_line({ full = true }) end, { desc = 'Blame line (full)' })
          map('n', '<Leader>gp',  gs.preview_hunk,   { desc = 'Preview hunk' })
          map('n', '<Leader>gr',  gs.reset_hunk,     { desc = 'Reset hunk' })
          map('n', '<Leader>gR',  gs.reset_buffer,   { desc = 'Reset buffer' })
          map('n', '<Leader>gS',  gs.stage_buffer,   { desc = 'Stage buffer' })
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
        end,
      })
    end,
  },

  -- ── git-conflict ──────────────────────────────────────────────────────────────
  {
    'akinsho/git-conflict.nvim',
    event = 'BufReadPost',
    config = function()
      require('git-conflict').setup({ default_mappings = false })
      local map = function(lhs, rhs, desc)
        vim.keymap.set('n', lhs, rhs, { desc = desc })
      end
      map('<Leader>gco', '<Plug>(git-conflict-ours)',          'Conflict: choose ours')
      map('<Leader>gct', '<Plug>(git-conflict-theirs)',        'Conflict: choose theirs')
      map('<Leader>gcb', '<Plug>(git-conflict-both)',          'Conflict: choose both')
      map('<Leader>gc0', '<Plug>(git-conflict-none)',          'Conflict: choose none')
      map(']x',         '<Plug>(git-conflict-next-conflict)', 'Next conflict')
      map('[x',         '<Plug>(git-conflict-prev-conflict)', 'Prev conflict')
    end,
  },

  -- ── neogit ────────────────────────────────────────────────────────────────────
  {
    'NeogitOrg/neogit',
    cmd          = 'Neogit',
    dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
    config = function()
      require('neogit').setup({
        integrations = { diffview = true, snacks = true },
        graph_style  = 'unicode',
      })
    end,
  },

  -- ── diffview ─────────────────────────────────────────────────────────────────
  {
    'sindrets/diffview.nvim',
    cmd  = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    keys = {
      { '<Leader>gd', '<cmd>DiffviewOpen<cr>',          desc = 'Diff view' },
      { '<Leader>gD', '<cmd>DiffviewClose<cr>',         desc = 'Close diff view' },
      { '<Leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'File history' },
      { '<Leader>gH', '<cmd>DiffviewFileHistory<cr>',   desc = 'Repo history' },
    },
    config = function()
      require('diffview').setup({
        enhanced_diff_hl = true,
        view = {
          default      = { layout = 'diff2_horizontal' },
          merge_tool   = { layout = 'diff3_horizontal', disable_diagnostics = true },
          file_history = { layout = 'diff2_horizontal' },
        },
        keymaps = {
          view = {
            { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
          },
          file_panel = {
            { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
          },
          file_history_panel = {
            { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
          },
        },
      })
    end,
  },
}
