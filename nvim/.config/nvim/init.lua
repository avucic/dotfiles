vim.g._start_ns      = vim.uv.hrtime()
vim.g.mapleader      = ' '
vim.g.maplocalleader = ','

require('config.options')
require('config.autocmds')
require('plugins')
require('config.keymaps')
