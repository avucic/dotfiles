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
    ["<c-w>"] = {
      name = "+Windows",
      t = { name = "+Tabs" },
      u = {
        name = "+Zen mode",
      },
    },
    ["<leader>"] = {
      n = {
        name = "+Notes",
        t = { name = "+Tasks" },
        j = { name = "+Journal" },
        n = { name = "+New Note" },
      },
      t = { name = "+Tasks" },
      s = { name = "+Search" },
      j = { name = "+Jump" },
      J = { name = "+Jump" },
      y = { name = "+Yank" },
      z = { name = "+Spelling" },
      x = {
        name = "+Text",
        i = "+Text Case",
      },
      b = {
        s = { name = "+Sort" },
      },
      l = {
        w = { name = "+Workspace" },
      },
      o = {
        name = "+Open",
        d = { name = "+DB" },
        t = { name = "+Terminal" },
      },
      g = {
        d = {
          name = "+Diff",
        },
      },
    },
    g = {
      V = {
        name = "+Treesitter selection",
      },
    },
  }, { mode = "n" })

  wk.register({
    ["<c-w>"] = {
      u = {
        name = "+Zen mode",
      },
    },
    ["<leader>"] = {
      f = { name = "+Files" },
      x = {
        name = "+Text",
        g = { name = "+Google translate" },
        d = { name = "+Decoding" },
        a = { name = "+Align" },
        i = { name = "+Text case" },
      },
    },
  }, { mode = "v" })
end
