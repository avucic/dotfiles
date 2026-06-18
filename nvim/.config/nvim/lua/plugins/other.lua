return {
  {
    'rgroli/other.nvim',
    cmd  = { 'Other', 'OtherClear' },
    keys = {
      { '<Leader>aa', '<cmd>Other<cr>',      desc = 'Other file' },
      { '<Leader>aA', '<cmd>OtherClear<cr>', desc = 'Other clear' },
    },
    config = function(_, opts)
      require('other-nvim').setup(opts)
    end,
    opts = function()
      local mappings = {
        -- 'rails',
        -- 'react',
        -- 'rust',
      }
      local project = vim.g.project or {}
      vim.list_extend(mappings, project.custom_other_mappings or {})
      return { mappings = mappings }
    end,
  },
}
