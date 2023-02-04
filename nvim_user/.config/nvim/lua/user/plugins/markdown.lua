return {
  {
    "dkarter/bullets.vim",
    ft = "markdown",
  },

  {
    "avucic/paste-markdown-url",
    build = "pip3 install requests beautifulsoup4 lxml",
    config = function()
      require("paste-markdown-url")
    end,
    ft = "markdown",
    cmd = { "PasteMDLink" },
  },

  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    cmd = { "MarkdownPreview" },
    ft = "markdown",
  },
  {
    "xorid/asciitree.nvim",
    ft = "markdown",
    cmd = { "AsciiTree" },
  },
  -- edit code blocks in markdown
  {
    "AckslD/nvim-FeMaco.lua",
    ft = { "markdown" },
    cmd = { "FeMaco" },
    config = function()
      require("femaco").setup()
    end,
  },
  {
    "jubnzv/mdeval.nvim",
    init = function()
      vim.g.markdown_fenced_languages = { "ruby", "go", "javascript" }
    end,
    config = require("user.plugins.configs.mdeval"),
    ft = { "markdown" },
    opt = true,
  },
  {
    "mickael-menu/zk-nvim",
    opts = {
      {
        -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
        -- it's recommended to use "telescope" or "fzf"
        picker = "telescope",

        lsp = {
          -- `config` is passed to `vim.lsp.start_client(config)`
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            on_attach = function(bufnr)
              -- TODO: it's note triggered. This mappings are defined in autocmds
              -- vim.keymap.set("n", "<cr>", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Declaration" })
              -- vim.keymap.set("n", "<bs>", ":ZkBacklinks<cr>", { buffer = bufnr, desc = "Back links" })
            end,
          },

          -- automatically attach buffers in a zk notebook that match the given filetypes
          auto_attach = {
            enabled = false,
            filetypes = { "markdown" },
          },
        },
      },
    },
    init = require("user.plugins.configs.zk").init,
    config = require("user.plugins.configs.zk").config,
    cmd = {
      "ZkAnnotateTask",
      "ZkOpenNotes",
      "ZkOrphans",
      "ZkCd",
      "ZkOpenNotebook",
      "ZkShowCalendar",
      "ZkFindOrCreateNote",
      "ZkFindOrCreateProjectNote",
      "ZkFindOrCreateJournalDailyNote",
      "ZkNew",
      "ZkIndex",
      "ZkNotes",
      "ZkLinks",
      "ZkBacklinks",
      "ZkTags",
      "ZkGrep",
    },
  },
  {
    -- drowing
    "jbyuki/venn.nvim",
    ft = { "markdown" },
    cmd = { "VBox" },
  },
  {
    "dhruvasagar/vim-table-mode",
    init = function()
      -- let g:table_mode_realign_map = '<Leader>ntr'
      -- let g:table_mode_delete_row_map = '<Leader>ntdd'
      -- let g:table_mode_delete_column_map = '<Leader>ntdc'
      -- let g:table_mode_insert_column_before_map = '<Leader>ntiC'
      -- let g:table_mode_insert_column_after_map = '<Leader>ntic'
      -- let g:table_mode_add_formula_map = '<Leader>ntfa'
      -- let g:table_mode_eval_formula_map = '<Leader>ntfe'
      -- let g:table_mode_echo_cell_map = '<Leader>nt?'
      -- let g:table_mode_sort_map = '<Leader>nts'
      -- let g:table_mode_tableize_map = '<Leader>ntt'
      -- let g:table_mode_tableize_d_map = '<Leader>nT'

      vim.g.table_mode_disable_tableize_mappings = 1
      vim.g.table_mode_disable_mappings = 1
      -- vim.g.table_mode_corner_corner = "+"
      -- vim.g.table_mode_header_fillchar = "="
      vim.g.table_mode_always_active = 1
    end,
    ft = { "markdown" },
  },
  {
    "gaoDean/autolist.nvim",
    ft = { "markdown" },
    config = function()
      require("autolist").setup({})
    end,
  },
}
