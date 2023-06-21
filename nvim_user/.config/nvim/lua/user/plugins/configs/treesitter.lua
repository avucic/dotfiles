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
