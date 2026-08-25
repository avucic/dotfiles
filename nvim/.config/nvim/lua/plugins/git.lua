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
          map('n', '<Leader>ghq', gs.setqflist,     { desc = 'Hunks to quickfix' })
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
      { '<Leader>gh', '<cmd>DiffviewFileHistory %<cr>',         desc = 'File history' },
      { '<Leader>gH', '<cmd>DiffviewFileHistory<cr>',           desc = 'Repo history' },
      { '<Leader>gH', ":'<,'>DiffviewFileHistory<cr>", mode = 'v', desc = 'Selection history' },
    },
    config = function()
      -- Find first non-diffview tab, fallback to nil
      local function find_target_tab()
        for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
          local wins = vim.api.nvim_tabpage_list_wins(tab)
          local is_diffview = false
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].filetype:match('[Dd]iffview') then
              is_diffview = true
              break
            end
          end
          if not is_diffview then return tab end
        end
      end

      require('diffview').setup({
        enhanced_diff_hl = true,
        watch_index = false,
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
            { 'n', 'o', function()
                local view = require('diffview.lib').get_current_view()
                if not view or not view.panel then return end
                local entry = view.panel:get_item_at_cursor()
                if not entry or not entry.path then return end
                local path = entry.path
                if not vim.startswith(path, '/') and view.adapter then
                  local root = (view.adapter.ctx or {}).toplevel or vim.fn.getcwd()
                  path = root .. '/' .. path
                end
                local target_tab = find_target_tab()
                if target_tab then
                  vim.api.nvim_set_current_tabpage(target_tab)
                  vim.cmd('edit ' .. vim.fn.fnameescape(path))
                else
                  vim.cmd('tabnew ' .. vim.fn.fnameescape(path))
                end
              end, { desc = 'Open file' } },
          },
          file_history_panel = {
            { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
            { 'n', 'o', function()
                local view = require('diffview.lib').get_current_view()
                if not view or not view.panel then return end
                local item = view.panel:get_item_at_cursor()
                if not item then return end

                local file_entry = item.files and item.files[1] or item
                local rev = file_entry and file_entry.revs and file_entry.revs.b
                if not file_entry or not file_entry.path or not rev or not rev.commit then return end

                local root = (view.adapter and view.adapter.ctx or {}).toplevel or vim.fn.getcwd()
                local path, sha = file_entry.path, rev.commit
                local lines = vim.fn.systemlist({ 'git', '-C', root, 'show', sha .. ':' .. path })
                if vim.v.shell_error ~= 0 then
                  vim.notify('Could not read ' .. path .. ' @ ' .. sha:sub(1, 7), vim.log.levels.ERROR)
                  return
                end

                local target_tab = find_target_tab()
                if target_tab then
                  vim.api.nvim_set_current_tabpage(target_tab)
                  vim.cmd('enew')
                else
                  vim.cmd('tabnew')
                end

                local buf = vim.api.nvim_get_current_buf()
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
                vim.api.nvim_buf_set_name(buf, string.format('%s @ %s', path, sha:sub(1, 7)))
                vim.bo[buf].buftype = 'nofile'
                vim.bo[buf].swapfile = false
                vim.bo[buf].modified = false
                vim.bo[buf].filetype = vim.filetype.match({ filename = path }) or ''
              end, { desc = 'Open file version in tab' } },
          },
        },
      })
    end,
  },
}
