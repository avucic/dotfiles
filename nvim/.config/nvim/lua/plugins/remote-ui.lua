return {
  dir = vim.fn.stdpath "config",
  name = "remote-ui",
  cmd = { "RemoteStart", "RemotePick", "RemoteStop", "RemoteQuit", "RemoteInfo" },
  -- runs on startup even while the plugin stays lazy; only remote instances
  -- register the greeting, shown when the remote-ui client attaches (UIEnter).
  init = function()
    if not vim.env.REMOTE_NVIM then return end
    vim.api.nvim_create_autocmd("UIEnter", {
      desc = "RemoteUI: greet on UI attach",
      callback = function()
        vim.schedule(
          function()
            vim.notify(
              ("connected · %s"):format(vim.fn.fnamemodify(vim.fn.getcwd(), ":~")),
              vim.log.levels.INFO,
              { title = "📡 RemoteUI" }
            )
          end
        )
      end,
    })
  end,
  keys = {
    {
      mode = { "n" },
      "<leader>Dc",
      function() vim.cmd "RemoteStart" end,
      desc = "Remote: connect (auto)",
    },

    {
      mode = { "n" },
      "<leader>Dp",
      function() vim.cmd "RemotePick" end,
      desc = "Remote: pick container",
    },

    {
      mode = { "n" },
      "<leader>Ds",
      function() vim.cmd "RemoteStop" end,
      desc = "Remote: stop",
    },
    {
      mode = { "n" },
      "<leader>Dq",
      function() vim.cmd "RemoteStop" end,
      desc = "Remote: Quit",
    },
    {
      mode = { "n" },
      "<leader>Di",
      function() vim.cmd "RemoteInfo" end,
      desc = "Remote: info",
    },

    {
      mode = { "n" },
      "<leader>Dd",
      function() vim.cmd "detach" end,
      desc = "Remote: detach UI",
    },
  },
  config = function()
    require("plugins.custom.remote_ui").setup {}

    vim.api.nvim_create_user_command(
      "RemoteStart",
      function() require("plugins.custom.remote_ui").start() end,
      { desc = "Auto-connect remote-ui to the current workspace's devcontainer" }
    )

    vim.api.nvim_create_user_command(
      "RemotePick",
      function() require("plugins.custom.remote_ui").pick() end,
      { desc = "Connect remote-ui to a container picked from all running ones" }
    )

    vim.api.nvim_create_user_command(
      "RemoteStop",
      function() require("plugins.custom.remote_ui").stop() end,
      { desc = "Stop nvim --listen server in a container (run from host)" }
    )

    vim.api.nvim_create_user_command(
      "RemoteQuit",
      function() require("plugins.custom.remote_ui").quit() end,
      { desc = "Quit the remote nvim (kills server, pane swaps back to host)" }
    )

    vim.api.nvim_create_user_command(
      "RemoteInfo",
      function() require("plugins.custom.remote_ui").info() end,
      { desc = "Show remote-ui status: containers, servers, ports" }
    )
  end,
}
