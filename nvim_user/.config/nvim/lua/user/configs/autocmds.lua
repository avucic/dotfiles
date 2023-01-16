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
  "aerial",
}

local aucmd_dict = {
  FileType = {
    {
      pattern = "http",
      callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<cr>", [[<plug>RestNvim]], { noremap = true, desc = "goto link" })
        vim.api.nvim_buf_set_keymap(0, "n", "P", [[<plug>RestNvimPreview]], { noremap = true, desc = "preview" })
        vim.api.nvim_buf_set_keymap(0, "n", "L", [[<plug>RestNvimLast]], { noremap = true, desc = "preview" })
      end,
    },
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
        end, 100)
      end,
      -- once = true,
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
    -- new line
    {
      callback = function()
        vim.cmd([[%s/\s\+$//e]])
      end,
    },
  },
  BufRead = {
    {
      group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
      pattern = "Cargo.toml",
      callback = function()
        require("cmp").setup.buffer({ sources = { { name = "crates" } } })
      end,
    },
    {
      pattern = "markdown",
      callback = function()
        vim.defer_fn(function()
          vim.cmd([[call MarkdownConceal() ]]) -- TODO: fix conceal.
        end, 100)
      end,
      -- once = true,
    },
  },
}

for event, opt_tbls in pairs(aucmd_dict) do
  for _, opt_tbl in pairs(opt_tbls) do
    vim.api.nvim_create_autocmd(event, opt_tbl)
  end
end
