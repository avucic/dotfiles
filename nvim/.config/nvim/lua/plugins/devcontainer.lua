return {
  {
    'erichlf/devcontainer-cli.nvim',
    cmd  = { 'DevcontainerUp', 'DevcontainerDown', 'DevcontainerExec' },
    keys = {
      { '<Leader>cu', '<cmd>DevcontainerUp<cr>',                                          desc = 'DevContainer up' },
      { '<Leader>cd', '<cmd>DevcontainerDown<cr>',                                        desc = 'DevContainer down' },
      { '<Leader>cx', "<cmd>DevcontainerExec direction='vertical' size='40'<cr>",         desc = 'DevContainer exec (vsplit)' },
      { '<Leader>cc', function() require('plugins.custom.remote_ui').start() end,         desc = 'Remote connect (auto)' },
      { '<Leader>cp', function() require('plugins.custom.remote_ui').pick() end,          desc = 'Remote pick container' },
      { '<Leader>cs', function() require('plugins.custom.remote_ui').stop() end,          desc = 'Remote stop' },
      { '<Leader>cq', function() require('plugins.custom.remote_ui').quit() end,          desc = 'Remote quit' },
      { '<Leader>ci', function() require('plugins.custom.remote_ui').info() end,          desc = 'Remote info' },
      { '<Leader>ce', '<cmd>detach<cr>',                                                   desc = 'Remote detach UI' },
    },
    dependencies = { 'akinsho/toggleterm.nvim' },
    config = function()
      require('devcontainer-cli').setup({
        interactive               = false,
        toplevel                  = false,
        dotfiles_repository       = 'https://github.com/avucic/dotfiles.git',
        dotfiles_branch           = 'refactoring',
        dotfiles_targetPath       = '~/.dotfiles',
        dotfiles_installCommand   = 'install.sh',
        remove_existing_container = false,
        shell                     = 'zsh',
        nvim_binary               = 'nvim',
        log_level                 = 'debug',
        console_level             = 'info',
      })

      local remote = require('plugins.custom.remote_ui')
      remote.setup({})

      vim.api.nvim_create_user_command('RemoteStart', function() remote.start() end, { desc = 'Auto-connect to workspace devcontainer' })
      vim.api.nvim_create_user_command('RemotePick',  function() remote.pick() end,  { desc = 'Pick container to connect to' })
      vim.api.nvim_create_user_command('RemoteStop',  function() remote.stop() end,  { desc = 'Stop nvim server in container' })
      vim.api.nvim_create_user_command('RemoteQuit',  function() remote.quit() end,  { desc = 'Quit remote nvim' })
      vim.api.nvim_create_user_command('RemoteInfo',  function() remote.info() end,  { desc = 'Show remote-ui status' })
    end,
  },

  -- ── toggleterm (devcontainer-cli dependency) ──────────────────────────────────
  { 'akinsho/toggleterm.nvim', lazy = true },

  -- ── On remote UI attach: greet ────────────────────────────────────────────────
  -- Runs on headless server startup; registers UIEnter before any plugin loads.
  {
    dir   = vim.fn.stdpath('config'),
    name  = 'remote-ui-init',
    lazy  = false,
    cond  = function() return vim.env.REMOTE_NVIM ~= nil end,
    config = function()
      vim.api.nvim_create_autocmd('UIEnter', {
        desc     = 'RemoteUI: greet on attach',
        callback = function()
          vim.schedule(function()
            vim.notify(
              ('connected · %s'):format(vim.fn.fnamemodify(vim.fn.getcwd(), ':~')),
              vim.log.levels.INFO,
              { title = 'RemoteUI' }
            )
          end)
        end,
      })
    end,
  },
}
