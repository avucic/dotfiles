local M = {}

function M.config()
  local module = require("user.core.utils").load_module("nvim-treesitter.parsers")

  if not module then
    return {}
  end
  --
  -- local parser_config = module.get_parser_configs()
  -- parser_config.embedded_template = {
  --   install_info = {
  --     url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
  --     files = { "src/parser.c" },
  --     requires_generate_from_grammar = true,
  --   },
  --   filetype = "eruby",
  --   -- used_by = { "eruby", "erb" },
  -- }

  require("nvim-treesitter.highlight").set_custom_captures({
    ["block_quote"] = "comment",
    ["block_quote_marker"] = "comment",
    ["block_continuation"] = "comment",
    ["fenced_code_block_delimiter"] = "comment",
    ["atx_h1_marker"] = "MarkdownHeaderMarker",
    ["atx_h2_marker"] = "MarkdownHeaderMarker",
    ["atx_h3_marker"] = "MarkdownHeaderMarker",
    ["atx_h4_marker"] = "MarkdownHeaderMarker",
    ["atx_h5marker"] = "MarkdownHeaderMarker",
    ["atx_h6marker"] = "MarkdownHeaderMarker",
    ["list_marker_dot"] = "text.title",
    ["list_marker_minus"] = "text.title",
    ["list_marker_star"] = "text.title",
    ["(pipe_table_header (pipe_table_cell))"] = "text.title",
    ["pipe_table"] = "MarkdownTable",
  })

  return {
    highlight = {
      enable = true, -- false will disable the whole extension
      additional_vim_regex_highlighting = false,
      -- disable = {}, -- list of language that will be disabled
    },
    indent = {
      enable = true,
    },
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
      "elixir",
      "json",
      "http",
      "ledger",
      "lua",
      "python",
      "yaml",
      "markdown",
      "markdown_inline",
      "embedded_template",
      "query",
      "norg",
      -- "norg_meta",
      -- "norg_table",
    },
  }
end

return M
