return {
  -- {
  --  "dominikduda/vim_current_word",
  -- - event = "BufRead",
  -- },
  {
    "stevearc/aerial.nvim",
    opts = {
      -- link_tree_to_folds = false,
      -- link_folds_to_tree = true,
      manage_folds = false,
      backends = { "treesitter", "lsp", "markdown", "man" },
      layout = {
        width = 0.4,
        max_width = { 50 },
      },
      keymaps = {
        ["<c-p>"] = "actions.prev",
        ["<c-n>"] = "actions.next",
        ["[["] = "actions.prev_up",
        ["]]"] = "actions.next_up",
      },
    },
  },
}
