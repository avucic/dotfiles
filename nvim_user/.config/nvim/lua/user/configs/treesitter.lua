local M = {}

function M.config()
  local module = require("user.utils").load_module("nvim-treesitter.parsers")

  if not module then
    return {}
  end

  local parser_config = module.get_parser_configs()
  parser_config.embedded_template = {
    install_info = {
      url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
      files = { "src/parser.c" },
      requires_generate_from_grammar = true,
    },
    filetype = "eruby",
    -- used_by = { "eruby", "erb" },
  }

  -- These two are optional and provide syntax highlighting
  -- for Neorg tables and the @document.meta tag
  parser_config.norg_meta = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
      files = { "src/parser.c" },
      branch = "main",
    },
  }

  parser_config.norg_table = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
      files = { "src/parser.c" },
      branch = "main",
    },
  }

  require("nvim-treesitter.configs").setup({
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        use_languagetree = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["a{"] = "@block.outer",
          ["i{"] = "@block.inner",
        },
      },
      lsp_interop = {
        enable = true,
        border = "none",
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
      },
    },
  })

  return {
    -- highlight = {
    --   enable = true, -- false will disable the whole extension
    --   additional_vim_regex_highlighting = true,
    --   disable = {}, -- list of language that will be disabled
    -- },
    -- matchup = {
    --   enable = false, -- mandatory, false will disable the whole extension
    --   -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
    -- },

    ensure_installed = {
      "ruby",
      "go",
      "html",
      "css",
      "scss",
      "bash",
      "cmake",
      "dockerfile",
      "hcl",
      "javascript",
      "json",
      "ledger",
      "lua",
      "python",
      "yaml",
      "norg",
      --"eruby",
      "markdown",
      "embedded_template",
      "norg_meta",
      "norg_table",
      "query",
    },
  }
end

return M
