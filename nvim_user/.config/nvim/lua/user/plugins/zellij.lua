return {
  {
    "Lilja/zellij.nvim",
    config = function()
      require("zellij").setup({
        -- path = "zellij",                            -- Zellij binary path
        replaceVimWindowNavigationKeybinds = false, -- Will set keybinds like <C-w>h to left
        whichKeyEnabled = true,
        vimTmuxNavigatorKeybinds = true, -- Will set keybinds like <C-h> to left
        debug = false, -- Will log things to /tmp/zellij.nvim
      })
    end,
    -- lazy = false,
    cmd = {
      "ZellijNavigateLeft",
      "ZellijNavigateRight",
      "ZellijNavigateUp",
      "ZellijNavigateDown",
      "ZellijNewPane",
      "ZellijNewTab",
      "ZellijRenamePane",
      "ZellijRenameTab",
    },
  },
}
