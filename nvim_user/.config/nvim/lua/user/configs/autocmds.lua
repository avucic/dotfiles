local aucmd_dict = {
  FileType = {
    {
      pattern = "*",
      callback = function()
        vim.cmd([[setlocal formatoptions-=c formatoptions-=r formatoptions-=o spell]])

        vim.cmd([[
hi SpellBad   guifg=NONE guisp=red    gui=undercurl term=underline cterm=undercurl
hi SpellCap   guifg=NONE guisp=yellow gui=undercurl term=underline cterm=undercurl
hi SpellRare  guifg=NONE guisp=blue   gui=undercurl term=underline cterm=undercurl
hi SpellLocal guifg=NONE guisp=red gui=undercurl term=underline cterm=undercurl
  ]])
      end,
    },
    {
      pattern = "Telescope*,toggleterm",
      callback = function()
        vim.cmd([[set nospell]])
      end,
    },
    {
      pattern = "gitcommit",
      callback = function()
        vim.api.nvim_win_set_option(0, "wrap", true)
      end,
    },
    {
      pattern = "qf",
      callback = function()
        vim.cmd([[nnoremap <buffer> q :cclose<CR>]])
      end,
    },
  },
  VimResized = {
    {
      pattern = "*",
      callback = function()
        vim.cmd([[ tabdo wincmd = ]])
      end,
    },
  },

  BufWritePre = {
    -- {
    --   callback = function()
    --     if vim.g.autoformat_on_save == 1 then
    --       vim.lsp.buf.format()
    --     end
    --   end,
    -- },
    -- new line
    {
      callback = function()
        vim.cmd([[%s/\s\+$//e]])
      end,
    },
  },
}

for event, opt_tbls in pairs(aucmd_dict) do
  for _, opt_tbl in pairs(opt_tbls) do
    vim.api.nvim_create_autocmd(event, opt_tbl)
  end
end
