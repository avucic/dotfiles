local aucmd_dict = {
  FileType = {
    {
      pattern = "*",
      callback = function()
        vim.cmd([[setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])
      end,
    },
    {
      pattern = "gitcommit",
      callback = function()
        vim.api.nvim_win_set_option(0, "wrap", true)
      end,
    },
    {
      pattern = "markdown",
      callback = function()
        vim.api.nvim_win_set_option(0, "wrap", true)
        vim.api.nvim_win_set_option(0, "conceallevel", 2)
        vim.api.nvim_win_set_option(0, "foldlevel", 99)

        vim.keymap.set("n", "<cr>", vim.lsp.buf.definition, { desc = "Go to Declaration" })
        vim.keymap.set("n", "<bs>", ":ZkBacklinks<cr>", { desc = "Back links" })

        vim.cmd([[ call MarkdownBlocks() ]])
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

  BufRead = {
    {
      pattern = "*",
      callback = function()
        vim.api.nvim_win_set_option(0, "spell", true)
      end,
    },
  },
  BufNewFile = {
    {
      pattern = "*",
      callback = function()
        vim.api.nvim_win_set_option(0, "spell", true)
      end,
    },
  },

  BufWritePre = {
    {
      callback = function()
        if vim.g.autoformat_on_save == 1 then
          vim.lsp.buf.format()
        end
      end,
    },
    -- new line
    {
      callback = function()
        vim.cmd([[%s/\s\+$//e]])
      end,
    },
  },
  InsertLeave = {
    {
      pattern = "*.md",
      callback = function()
        vim.cmd([[ call MarkdownBlocks() ]])
      end,
    },
  },
  BufEnter = {
    {
      pattern = "*.md",
      callback = function()
        vim.cmd([[ call MarkdownBlocks() ]])
      end,
    },
  },
  BufWritePost = {
    {
      pattern = "*.md",
      callback = function()
        vim.cmd([[ call MarkdownBlocks() ]])
      end,
    },
  },
}

for event, opt_tbls in pairs(aucmd_dict) do
  for _, opt_tbl in pairs(opt_tbls) do
    vim.api.nvim_create_autocmd(event, opt_tbl)
  end
end
