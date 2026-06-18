return {
  {
    'folke/noice.nvim',
    lazy = false,
    priority = 900,
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      require('noice').setup({
        notify = { enabled = false },
        lsp = {
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
          },
          hover    = { enabled = true },
          signature = { enabled = true },
        },
        presets = {
          bottom_search         = true,
          command_palette       = true,
          long_message_to_split = true,
          inc_rename            = true,
        },
        routes = {
          { filter = { event = 'msg_show', kind = 'return_prompt' }, opts = { skip = true } },
          { filter = { event = 'msg_show', find = 'written' },       opts = { skip = true } },
          { filter = { event = 'msg_show', find = '%d+ lines' },     opts = { skip = true } },
          { filter = { event = 'msg_show', find = 'search hit' },    opts = { skip = true } },
        },
      })
    end,
  },
}
