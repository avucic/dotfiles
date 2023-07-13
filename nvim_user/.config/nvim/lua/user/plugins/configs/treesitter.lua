return function()
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
    markid = { enable = true },
    indent = {
      enable = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        -- init_selection = "<CR>",
        scope_incremental = "<CR>",
        node_incremental = "<TAB>",
        node_decremental = "<S-TAB>",
      },
    },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          -- You can optionally set descriptions to the mappings (used in the desc parameter of
          -- nvim_buf_set_keymap) which plugins like which-key display
          -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          -- You can also use captures from other query groups like `locals.scm`
          ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          ["ic"] = "@class.inner",
          ["il"] = "@loop.inner",
          ["al"] = "@loop.outer",
          ["ast"] = "@statement.outer",
          ["isc"] = "@scopename.inner",
          ["iB"] = "@block.inner",
          ["aB"] = "@block.outer",
          ["ia"] = "@parameter.inner",
          ["aa"] = "@parameter.outer",
        },
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "<c-v>", -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        -- include_surrounding_whitespace = true,
      },
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
      "toml",
      "sql",
      "svelte",
      "dockerfile",
      "make",
      "zig",
    },
  }
end
