-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--branch=stable',
    'https://github.com/folke/lazy.nvim.git', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    { import = 'plugins.colorscheme' },
    { import = 'plugins.noice' },
    { import = 'plugins.snacks' },
    { import = 'plugins.ui' },
    { import = 'plugins.treesitter' },
    { import = 'plugins.lsp' },
    { import = 'plugins.completion' },
    { import = 'plugins.formatting' },
    { import = 'plugins.git' },
    { import = 'plugins.file_explorer' },
    { import = 'plugins.ai' },
    { import = 'plugins.editing' },
    { import = 'plugins.dap' },
    { import = 'plugins.testing' },
    { import = 'plugins.notes' },
    { import = 'plugins.markdown' },
    { import = 'plugins.devcontainer' },
    { import = 'plugins.session' },
    { import = 'plugins.other' },
    { import = 'plugins.mappings' },
  },
  defaults = { lazy = true },
  change_detection = { notify = false },
  install = { colorscheme = { 'catppuccin', 'habamax' } },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip', 'matchit', 'matchparen', 'netrwPlugin', 'tarPlugin', 'tohtml', 'tutor', 'zipPlugin',
      },
    },
  },
})

-- Custom local plugins (no lazy spec needed)
require('plugins.custom.open_in_finder').setup()

-- Apply project config after exrc (.nvim.lua) has run.
-- exrc fires after init.lua completes, so VimEnter is the earliest safe point.
-- In container/remote-ui, also load .nvim.devcontainer.lua (if present) so it
-- can call require('project').setup({}) to extend the host config before apply().
vim.api.nvim_create_autocmd('VimEnter', {
  once     = true,
  callback = function()
    local in_container = io.open('/.dockerenv', 'r') ~= nil or vim.env.REMOTE_NVIM ~= nil
    if in_container then
      local f = vim.fn.getcwd() .. '/.nvim.devcontainer.lua'
      if vim.uv.fs_stat(f) then
        vim.secure.trust({ action = 'allow', path = f })
        dofile(f)
      end
    end
    vim.schedule(function() require('project').apply() end)
  end,
})
