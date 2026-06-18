return {
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 800,
    config = function()
      local function service_name()
        local cwd = vim.fn.getcwd()
        return cwd:match('/services/([^/]+)') or vim.fn.fnamemodify(cwd, ':t')
      end

      local function env_badge()
        if vim.env.DEVCONTAINER then
          return { { 'DEV ', hl = 'DashboardDev' }, { service_name(), hl = 'DashboardDevText' } }
        end
        if vim.env.REMOTE_NVIM then
          return { { 'REMOTE', hl = 'DashboardRemote' } }
        end
        return nil
      end

      local function startup_text()
        local stats = require('lazy').stats()
        local elapsed_ns = vim.uv.hrtime() - (vim.g._start_ns or vim.uv.hrtime())
        local ms = math.floor(elapsed_ns / 1e5 + 0.5) / 10  -- ns → ms, 1 decimal
        return {
          align = 'center',
          text = {
            { '⚡ Neovim loaded ', hl = 'footer' },
            { tostring(stats.count), hl = 'special' },
            { ' plugins in ',        hl = 'footer' },
            { ms .. 'ms',            hl = 'special' },
          },
        }
      end

local function dashboard_sections()
        local sections = { { section = 'header' } }
        local badge = env_badge()
        if badge then
          sections[#sections + 1] = { text = badge, align = 'center', padding = 1 }
        end
        sections[#sections + 1] = { section = 'keys', gap = 1, padding = 1 }
        sections[#sections + 1] = startup_text()
        return sections
      end

      require('snacks').setup({
        bigfile      = { enabled = true },
        indent       = { enabled = true, animate = { enabled = false } },
        words        = { enabled = true },
        scroll       = { enabled = false },
        statuscolumn = { enabled = true },
        notifier     = { enabled = true },
        terminal     = { enabled = true },
        scratch      = { ft = 'markdown' },
        dim          = { enabled = true },
        zen          = { enabled = true },
        gitbrowse    = { enabled = true },
        lazygit      = {
          enabled = true,
          theme = {
            -- FloatBorder fg is set to bg (invisible) in our theme,
            -- so override lazygit's inactive border to use a visible color.
            inactiveBorderColor = { fg = 'Comment' },
          },
        },

        picker = {
          exclude = { '.git', 'node_modules' },
          layout  = 'telescope',
          win = {
            wo = { winblend = 0, winhighlight = 'Normal:Normal,FloatBorder:FloatBorder' },
            input = {
              keys = {
                ['<C-l>'] = { 'loclist',      mode = { 'n', 'i' } },
                ['<C-c>'] = { 'close',        mode = { 'n', 'i' } },
                ['g.']    = { 'toggle_hidden', mode = { 'n' } },
                ['gi']    = { 'toggle_ignored', mode = { 'n' } },
              },
            },
          },
        },

        dashboard = {
          preset = {
            --[[ Original logo:
            header = table.concat({
              '      @@@@@@@@@@@@@@@@@@                                       &@@@@@@@@@@@@@@@@@@@@ ',
              '    @@@@@@@@@@@@@@@@@@@@@@@@@@                            @@@@@@@@@@@@@@@@@@@@@@@@@@ ',
              '     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ',
              '     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ',
              '     *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  ',
              '      %@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      @@@@@@@@@@@@@@@@@@@@@@@@@@   ',
              '        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@            @@@@@@@@ ,@@@@@@@@@@@@    ',
              '         @@@@@@@@@#  @@@@@@@@@# /@@@@@@@@@@@@%      *@,      @@@@@     #@@@@@@@      ',
              '            @@       @@@@@@@@     @@@@@@@@@@@      @@@@@     @@@@@                   ',
              '                     @@@@@@@@@@@@@@@@@@@@@@@@%      %@       @@@@                    ',
              '                      @@@@@@@@@@@@@@@@@@@@@@@@@            @@@@@@                    ',
              '                      @@@@@@@@@@@@@@@@@@@@@@@@@@@@      @@@@@@@@                     ',
              '                      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                     ',
              '                      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                      ',
              '                      ,@@@@@@@@@@@@@@@@@     @@@@@@@@@@@@@@@@@@                      ',
              '                       @@@@@@@@@@@@@@(          @@@@@@@@@@@@@@                       ',
              '                       @@@@@@@@@@@@@@@#       @@@@@@@@@@@@@@@@                       ',
              '                        @@@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@@@@                        ',
              '                           @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%                         ',
              '                               @@@@@@@@@@@@@@@@@@@@@@@@%                             ',
              '                                   @@@@@@@@@@@@@@@@%                                 ',
              '                                                                                     ',
              '                               ...remember who you are...                            ',
            }, '\n'),
            --]]
            header = table.concat({
              '                                                        ',
              '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ',
              '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ',
              '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ',
              '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ',
              '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ',
              '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ',
              '                                                        ',
            }, '\n'),
            keys = {},
          },
          sections = dashboard_sections(),
        },
      })

      local map = function(mode, lhs, rhs, opts)
        vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', { silent = true }, opts or {}))
      end
      map('n', '<Leader>n.', function() Snacks.scratch() end,                    { desc = 'Toggle Scratch Buffer' })
      map('n', '<Leader>ns', function() Snacks.scratch.select() end,             { desc = 'Select Scratch Buffer' })
      map('n', '<Leader>nS', function()
        Snacks.scratch({ name = 'Global', ft = 'markdown', filekey = { cwd = false, branch = false, count = false } })
      end, { desc = 'Global Scratch' })
      map('n', '<C-w>Z',      function() Snacks.zen.zen() end,                   { desc = 'Zen mode' })
      map('n', '<C-w>z',      function() Snacks.zen.zoom() end,                  { desc = 'Zoom window' })
      map('n', '<Leader>f/',  function() Snacks.picker.lines() end,              { desc = 'Search buffer lines' })
      map('n', '<Leader>z=',  function() Snacks.picker.spelling() end,           { desc = 'Spell suggestions' })
      map('n', '<Leader>f?',  function() Snacks.picker.search_history() end,     { desc = 'Search history' })
      map('n', '<Leader>fw',  function() Snacks.picker.grep() end,               { desc = 'Live grep' })
      map('n', '<Leader>fW',  function() Snacks.picker.grep_word() end,          { desc = 'Grep word' })
      map('v', '<Leader>fw',  function() Snacks.picker.grep_word() end,          { desc = 'Grep selection' })
      map('v', '<C-f>',       function() Snacks.picker.live_grep({ default_text = vim.fn.getreg('*') }) end, { desc = 'Grep selection' })
      map('n', '<Leader>f[',  function() Snacks.explorer() end,                  { desc = 'File explorer' })
      map('n', '<Leader>f<cr>', function() Snacks.picker.resume() end,           { desc = 'Picker resume' })
      map('n', '<Leader>sb',  function() Snacks.picker.buffers() end,            { desc = 'Buffers' })
      map('n', '<Leader>s<cr>', function() Snacks.picker.resume() end,           { desc = 'Picker resume' })
      map('n', '<Leader>sp',  function() Snacks.picker() end,                    { desc = 'Pickers' })
      map('n', '<Leader>s;',  function() Snacks.picker.command_history() end,    { desc = 'Command history' })
      map('n', '<Leader>lR',  function() Snacks.picker.lsp_references() end,     { desc = 'LSP references' })
      map('n', '<Leader>oN',  function() Snacks.picker.notifications() end,      { desc = 'Notifications' })

      map('n', '<Leader>ff', function() Snacks.picker.files() end,                    { desc = 'Find files' })
      map('n', '<Leader>fF', function() Snacks.picker.git_files() end,                { desc = 'Git files' })
      map('n', '<Leader>fo', function() Snacks.picker.recent() end,                   { desc = 'Recent files' })

      map('n', '<Leader>sc', function() Snacks.picker.commands() end,                 { desc = 'Commands' })
      map('n', '<Leader>sk', function() Snacks.picker.keymaps() end,                  { desc = 'Keymaps' })
      map('n', '<Leader>sf', function() Snacks.picker.files() end,                    { desc = 'Files' })
      map('n', '<Leader>sg', function() Snacks.picker.git_files() end,                { desc = 'Git files' })
      map('n', '<Leader>sh', function() Snacks.picker.help() end,                     { desc = 'Help tags' })
      map('n', '<Leader>sm', function() Snacks.picker.marks() end,                    { desc = 'Marks' })
      map('n', '<Leader>sj', function() Snacks.picker.jumps() end,                    { desc = 'Jumps' })
      map('n', '<Leader>sn', function() Snacks.picker.notifications() end,            { desc = 'Notifications' })
      map('n', '<Leader>sr', function() Snacks.picker.recent() end,                   { desc = 'Recent files' })

      map('n', '<Leader>lD', function() Snacks.picker.diagnostics() end,               { desc = 'Search diagnostics' })
      map('n', '<Leader>ls', function() Snacks.picker.lsp_symbols() end,              { desc = 'Symbols' })
      map('n', '<Leader>lW', function() Snacks.picker.lsp_workspace_symbols() end,    { desc = 'Workspace symbols' })

      -- ── Toggles (<Leader>u) ──────────────────────────────────────────────────────
      local T = Snacks.toggle
      T.new({ name = 'Autopairs',
        get = function() return vim.g.minipairs_disable ~= true end,
        set = function(s) vim.g.minipairs_disable = not s end,
      }):map('<Leader>ua')
      T.option('autochdir', { global = true, name = 'Autochdir' }):map('<Leader>uA')
      T.new({ name = 'Background',
        get = function() return vim.o.background == 'light' end,
        set = function(s) vim.o.background = s and 'light' or 'dark' end,
      }):map('<Leader>ub')
      T.new({ name = 'Completion (buffer)',
        get = function() return vim.b.completion ~= false end,
        set = function(s) vim.b.completion = s or nil end,
      }):map('<Leader>uc')
      T.new({ name = 'Completion',
        get = function() return vim.g.cmp_enabled ~= false end,
        set = function(s) vim.g.cmp_enabled = s end,
      }):map('<Leader>uC')
      T.diagnostics():map('<Leader>ud')
      map('n', '<Leader>uD', function() Snacks.notifier.hide() end, { desc = 'Dismiss notifications' })
      T.option('signcolumn', { on = 'yes', off = 'no', name = 'Sign Column' }):map('<Leader>ug')
      map('n', '<Leader>ui', function()
        local sw = vim.o.shiftwidth
        local next = sw < 4 and 4 or sw < 8 and 8 or 2
        vim.o.tabstop, vim.o.shiftwidth, vim.o.softtabstop = next, next, next
        Snacks.notify('Indent: ' .. next, { title = 'Indent' })
      end, { desc = 'Change indent setting' })
      T.option('laststatus', { on = 3, off = 0, global = true, name = 'Statusline' }):map('<Leader>ul')
      T.line_number():map('<Leader>un')
      do
        local _notify = vim.notify
        T.new({ name = 'Notifications',
          get = function() return vim.g.notifications_enabled ~= false end,
          set = function(s)
            vim.g.notifications_enabled = s
            vim.notify = s and _notify or function() end
          end,
        }):map('<Leader>uN')
      end
      T.option('paste', { global = true, name = 'Paste Mode' }):map('<Leader>up')
      T.words():map('<Leader>ur')
      T.option('spell'):map('<Leader>us')
      T.option('conceallevel', { on = 2, off = 0, name = 'Conceal' }):map('<Leader>uS')
      T.option('showtabline', { on = 2, off = 0, global = true, name = 'Tabline' }):map('<Leader>ut')
      T.new({ name = 'Virtual Text',
        get = function() return (vim.diagnostic.config() or {}).virtual_text ~= false end,
        set = function(s) vim.diagnostic.config({ virtual_text = s }) end,
      }):map('<Leader>uv')
      T.new({ name = 'Virtual Lines',
        get = function()
          local vl = (vim.diagnostic.config() or {}).virtual_lines
          return vl ~= nil and vl ~= false
        end,
        set = function(s) vim.diagnostic.config({ virtual_lines = s }) end,
      }):map('<Leader>uV')
      T.option('wrap'):map('<Leader>uw')
      T.treesitter():map('<Leader>uy')
      T.new({ name = 'Color Highlight',
        get = function() return vim.b.colorizer_enabled == true end,
        set = function(s)
          if s then
            vim.cmd('ColorizerAttachToBuffer')
            vim.b.colorizer_enabled = true
          else
            vim.cmd('ColorizerDetachFromBuffer')
            vim.b.colorizer_enabled = false
          end
        end,
      }):map('<Leader>uz')
      T.zen():map('<Leader>uZ')
      T.indent():map('<Leader>u|')
      T.dim():map('<Leader>u<Tab>')
      T.option('foldcolumn', { on = '1', off = '0', name = 'Fold Column' }):map('<Leader>u>')
      map('n', '<Leader>u=', function()
        if vim.wo.diff then vim.cmd('windo diffoff') else vim.cmd('windo diffthis') end
      end, { desc = 'Toggle diff mode' })
    end,
  },
}
