return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "s1n7ax/nvim-window-picker", enabled = false },
  { "max397574/better-escape.nvim", enabled = false },
  {
    "Shatur/neovim-session-manager",
    opts = {
      autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
        "toggleterm",
      },
    },
  },
}
