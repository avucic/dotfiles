local M = {}

function M.config()
  local module = require("user.core.utils").load_module("nvim-treesitter.parsers")

  if not module then
    return {}
  end

  -- require("nvim-treesitter.highlight").set_custom_captures({
  --   ["block_quote"] = "MarkdownBlockQuote",
  --   ["block_quote_marker"] = "comment",
  --   ["block_continuation"] = "comment",
  --   ["fenced_code_block_delimiter"] = "comment",
  --   ["atx_h1_marker"] = "MarkdownHeaderMarker",
  --   ["atx_h2_marker"] = "MarkdownHeaderMarker",
  --   ["atx_h3_marker"] = "MarkdownHeaderMarker",
  --   ["atx_h4_marker"] = "MarkdownHeaderMarker",
  --   ["atx_h5marker"] = "MarkdownHeaderMarker",
  --   ["atx_h6marker"] = "MarkdownHeaderMarker",
  --   ["list_marker_dot"] = "text.title",
  --   ["list_marker_minus"] = "text.title",
  --   ["list_marker_star"] = "text.title",
  --   -- ["(pipe_table_header (pipe_table_cell))"] = "text.title",
  --   ["pipe_table"] = "MarkdownTable",
  --   ["h1"] = "h1",
  -- })

  return {
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "O",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
    highlight = {
      enable = true, -- false will disable the whole extension
      -- additional_vim_regex_highlighting = true,
      -- disable = {}, -- list of language that will be disabled
    },
    indent = {
      enable = false,
    },
    spellsitter = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
      -- enable_autocmd = false,
      -- config = {
      --   -- Languages that have a single comment style
      --   typescript = "// %s",
      --   css = "/* %s */",
      --   scss = "/* %s */",
      --   html = "<!-- %s -->",
      --   svelte = "<!-- %s -->",
      --   vue = "<!-- %s -->",
      --   json = "",
    },
    textsubjects = {
      enable = true,
      prev_selection = ",", -- (Optional) keymap to select the previous selection
      keymaps = {
        ["."] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer",
        ["i;"] = "textsubjects-container-inner",
      },
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
          ["il"] = "@loop.inner",
          ["al"] = "@loop.outer",
          ["ast"] = "@statement.outer",
          ["isc"] = "@scopename.inner",
          -- ["iB"] = "@block.inner",
          -- ["aB"] = "@block.outer",
          ["ia"] = "@parameter.inner",
          ["aa"] = "@parameter.outer",
        },
      },
      -- move = {
      --   enable = true,
      --   set_jumps = true, -- whether to set jumps in the jumplist
      --   goto_next_start = {
      --     ["]m"] = "@function.outer",
      --     ["]im"] = "@function.inner",
      --     [")"] = "@parameter.inner",
      --     -- [']c'] = '@call.outer',
      --     -- [']ic'] = '@call.inner',
      --   },
      --   goto_next_end = {
      --     ["]M"] = "@function.outer",
      --     ["]iM"] = "@function.inner",
      --     ["g)"] = "@parameter.inner",
      --     -- [']C'] = '@call.outer',
      --     -- [']iC'] = '@call.inner',
      --   },
      --   goto_previous_start = {
      --     ["[m"] = "@function.outer",
      --     ["[im"] = "@function.inner",
      --     ["("] = "@parameter.inner",
      --     -- ['[c'] = '@call.outer',
      --     -- ['[ic'] = '@call.inner',
      --   },
      --   goto_previous_end = {
      --     ["[M"] = "@function.outer",
      --     ["[iM"] = "@function.inner",
      --     ["g("] = "@parameter.inner",
      --     -- ['[C'] = '@call.outer',
      --     -- ['[iC'] = '@call.inner',
      --   },
      -- },
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
      "rust",
      "vim",
      "help",
      "toml",
      "sql",
      "svelte",
      "dockerfile"
    },
  }
end

return M
