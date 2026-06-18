return {
  {
    'nvim-treesitter/nvim-treesitter',
    build  = ':TSUpdate',
    event  = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag',
    },
    config = function()
      local wanted = {
        'bash', 'c', 'css', 'diff', 'html', 'javascript', 'jsdoc', 'json',
        'lua', 'luadoc', 'luap', 'markdown', 'markdown_inline', 'printf', 'python',
        'query', 'regex', 'ruby', 'rust', 'toml', 'tsx', 'typescript', 'vim',
        'vimdoc', 'xml', 'yaml',
      }
      local installed = require('nvim-treesitter').get_installed()
      local installed_set = {}
      for _, lang in ipairs(installed) do installed_set[lang] = true end
      local missing = vim.tbl_filter(function(l) return not installed_set[l] end, wanted)
      if #missing > 0 then require('nvim-treesitter').install(missing) end

      require('nvim-treesitter-textobjects').setup({
        select = { lookahead = true },
        move   = { set_jumps = true },
      })

      local sel  = require('nvim-treesitter-textobjects.select')
      local move = require('nvim-treesitter-textobjects.move')
      local swap = require('nvim-treesitter-textobjects.swap')
      local function map(mode, lhs, fn, desc)
        vim.keymap.set(mode, lhs, fn, { silent = true, desc = desc })
      end

      map({ 'x', 'o' }, 'af', function() sel.select_textobject('@function.outer',    'textobjects') end, 'outer function')
      map({ 'x', 'o' }, 'if', function() sel.select_textobject('@function.inner',    'textobjects') end, 'inner function')
      map({ 'x', 'o' }, 'ac', function() sel.select_textobject('@class.outer',       'textobjects') end, 'outer class')
      map({ 'x', 'o' }, 'ic', function() sel.select_textobject('@class.inner',       'textobjects') end, 'inner class')
      map({ 'x', 'o' }, 'aa', function() sel.select_textobject('@parameter.outer',   'textobjects') end, 'outer argument')
      map({ 'x', 'o' }, 'ia', function() sel.select_textobject('@parameter.inner',   'textobjects') end, 'inner argument')
      map({ 'x', 'o' }, 'al', function() sel.select_textobject('@loop.outer',        'textobjects') end, 'outer loop')
      map({ 'x', 'o' }, 'il', function() sel.select_textobject('@loop.inner',        'textobjects') end, 'inner loop')
      map({ 'x', 'o' }, 'ai', function() sel.select_textobject('@conditional.outer', 'textobjects') end, 'outer conditional')
      map({ 'x', 'o' }, 'ii', function() sel.select_textobject('@conditional.inner', 'textobjects') end, 'inner conditional')

      map({ 'n', 'x', 'o' }, ']f', function() move.goto_next_start('@function.outer',     'textobjects') end, 'next function start')
      map({ 'n', 'x', 'o' }, ']c', function() move.goto_next_start('@class.outer',        'textobjects') end, 'next class start')
      map({ 'n', 'x', 'o' }, ']a', function() move.goto_next_start('@parameter.inner',    'textobjects') end, 'next argument')
      map({ 'n', 'x', 'o' }, '[f', function() move.goto_previous_start('@function.outer', 'textobjects') end, 'prev function start')
      map({ 'n', 'x', 'o' }, '[c', function() move.goto_previous_start('@class.outer',    'textobjects') end, 'prev class start')
      map({ 'n', 'x', 'o' }, '[a', function() move.goto_previous_start('@parameter.inner','textobjects') end, 'prev argument')

      map('n', '>a', function() swap.swap_next('@parameter.inner',     'textobjects') end, 'swap arg next')
      map('n', '<a', function() swap.swap_previous('@parameter.inner', 'textobjects') end, 'swap arg prev')

      require('nvim-ts-autotag').setup()
    end,
  },
}
