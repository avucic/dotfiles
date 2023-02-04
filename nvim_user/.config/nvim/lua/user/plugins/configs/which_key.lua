return function(plugin, opts)
  local wk = require("which-key")
  -- local leader_f = require("user.plugins.configs.wk.leader-f")
  -- local leader_g = require("user.plugins.configs.wk.leader-g")
  wk.setup({
    plugins = { spelling = { enabled = true }, presets = { operators = false, windows = false } },
    -- window = { border = "rounded", padding = { 2, 2, 2, 2 } },
    disable = { filetypes = { "TelescopePrompt", "neo-tree" } },
    layout = {
      -- height = { min = 4, max = 25 },
      -- width = { min = 20, max = 50 },
      -- spacing = 3,
      align = "center",
    },
  })

  wk.register({
    ["<leader>"] = {
      n = {
        name = "+Notes",
        t = { name = "+Tasks" },
        j = { name = "+Journal" },
        n = { name = "+New Note" },
      },
      s = { name = "+Search" },
      j = { name = "+Jump" },
      J = { name = "+Jump" },
      y = { name = "+Yank" },
      z = { name = "+Spelling" },
      b = {
        s = { name = "+Sort" },
      },
      l = {
        w = { name = "+Workspace" },
      },
      o = {
        name = "+Open",
        d = { name = "+DB" },
        t = { name = "+Tasks" },
      },
      u = {
        m = { name = "+Poet mode" },
      },
    },
    g = {
      V = {
        name = "+Treesitter selection",
      },
    },
  }, { mode = "n" })

  wk.register({
    ["<leader>"] = {
      x = { name = "+Text" },
      g = {
        name = "Google translate",
      },
    },
  }, { mode = "v" })
end
