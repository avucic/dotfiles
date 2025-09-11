-- Customize Treesitter
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.cedar = {
  install_info = {
    url = "~/Work/Neovim/tree-sitter-cedar",
    files = { "src/parser.c" },
  },
  filetype = "cedar", -- if filetype does not agrees with parser name
}

---@type LazySpec
return {
  {
    "nvim-treesitter/playground",
    cmd = {
      "TSPlaygroundToggle",
      "TSHighlightCapturesUnderCursor",
      "TSCaptureUnderCursor",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- "David-Kunz/markid",
    },
    opts = {
      markid = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "v",
          node_decremental = "V",
        },
      },
      ensure_installed = {
        "lua",
        "vim",
        "ruby",
        "go",
        "html",
        "css",
        "scss",
        "bash",
        "cmake",
        "cedar",
        -- "dockerfile",
        "hcl",
        "regex",
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
        "make",
        "zig",
        "kdl",
        -- add more arguments for adding more treesitter parsers
      },
    },
  },
}
