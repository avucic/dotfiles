return {
  "atiladefreitas/dooing",
  config = function()
    require("dooing").setup {
      keymaps = {
        toggle_window = "<leader>ott", -- Toggle global todos
        open_project_todo = "<leader>otT", -- Toggle project-specific todos
        show_due_notification = "<leader>otd", -- Show due items window
      },
    }
  end,
}
