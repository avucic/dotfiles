local ingore_spell = {
  "Telescope*",
  "toggleterm",
  "prompt",
  "alpha",
  "WhichKey",
  "cmp_menu",
  "hydra_hint",
  "nofile",
  "filetree",
  "packer",
  "bufferlist",
}

local aucmd_dict = {
  FileType = {
    {
      pattern = "help",
      callback = function()
        vim.cmd([[noremap <buffer> q :q<cr>]])
      end,
    },
    {
      pattern = "*",
      callback = function()
        vim.cmd([[setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])
        -- TODO: find a better way to fix spell highlight issue?
        if vim.g.is_spell_off ~= true then
          for _, value in pairs(ingore_spell) do
            if value == vim.o.filetype then
              vim.cmd([[setlocal nospell]])
              return
            end
          end

          vim.defer_fn(function()
            vim.cmd([[setlocal spell syntax=off]])
          end, 1)
        end
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
