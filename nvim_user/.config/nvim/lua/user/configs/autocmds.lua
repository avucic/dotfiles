local ingore_spell = {
  "TelescopePrompt",
  "TelescopeResults",
  "TelescopePreview",
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

--   if vim.g.is_lsp_virtual_text_off == true then
--     vim.api.nvim_command([[
--   augroup Foo
-- autocmd CursorHold <buffer> lua vim.diagnostic.open_float({scope='line'})
-- augroup END
--     ]])
--   end
local aucmd_dict = {
  CursorHold = {
    {
      pattern = "*",
      callback = function()
        if vim.g.is_lsp_virtual_text_off == true then
           vim.diagnostic.open_float({scope='line'})
        end
      end,
    },
  },
  FileType = {

    {
      pattern = "zsh",
      callback = function()
        vim.cmd([[set filetype=bash]])
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
            else
              vim.cmd([[setlocal spell]])
            end
          end

          vim.defer_fn(function()
            if vim.o.filetype == "make" then
              vim.cmd([[setlocal spell]])
            else
              vim.cmd([[setlocal spell syntax=off]])
            end
          end, 1)
        end

        local opt = vim.o
        opt.foldmethod = "manual"
        opt.foldlevel = 99

        if vim.o.buftype ~= "nofile" then
          vim.defer_fn(function()
            opt.foldmethod = "expr"
            opt.foldexpr = "nvim_treesitter#foldexpr()"
          end, 100)
        end
      end,
    },
    {
      pattern = "markdown",
      callback = function()
        vim.defer_fn(function()
          vim.cmd([[call MarkdownConceal() ]]) -- TODO: fix conceal.
        end, 1)
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
