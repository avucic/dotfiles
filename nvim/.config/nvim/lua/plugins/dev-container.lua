return {
  {
    "erichlf/devcontainer-cli.nvim",
    dependencies = { "akinsho/toggleterm.nvim" },
    init = function()
      require("devcontainer-cli").setup {
        -- only the most useful options shown; see full config below
        interactive = true,
        toplevel = false,
        dotfiles_repository = "https://github.com/avucic/dotfiles.git",
        dotfiles_branch = "refactoring",
        dotfiles_targetPath = "~/.dotfiles",
        dotfiles_installCommand = "install.sh",
        remove_existing_container = false,
        shell = "zsh",
        nvim_binary = "nvim",
        log_level = "debug",
        console_level = "info",
      }
    end,
    keys = {
      { "<leader>D", "", desc = "DevContainer" },
      { "<leader>Du", ":DevcontainerUp<CR>", desc = "DevContainer: up" },
      { "<leader>Dd", ":DevcontainerDown<CR>", desc = "DevContainer: down" },
      { "<leader>Dx", ":DevcontainerExec direction='vertical' size='40'<CR>", desc = "DevContainer: exec (vsplit)" },
    },
  },
}
