local M = {}

function M.config()
  local Hydra = require("user.core.utils").load_module("hydra")
  if not Hydra then
    return {}
  end

  local cmd = require("hydra.keymap-util").cmd
  local pcmd = require("hydra.keymap-util").pcmd

  -- Win and buffers
  require("user.configs.hydra.leader-w").setup(Hydra, cmd, pcmd)
  -- Telescope
  require("user.configs.hydra.leader-f").setup(Hydra, cmd, pcmd)
  -- Packer
  require("user.configs.hydra.leader-P").setup(Hydra, cmd, pcmd)
  -- Search
  require("user.configs.hydra.leader-s").setup(Hydra, cmd, pcmd)
  -- LSP
  require("user.configs.hydra.leader-l").setup(Hydra, cmd, pcmd)
  -- Git
  require("user.configs.hydra.leader-g").setup(Hydra, cmd, pcmd)
  -- Notes
  require("user.configs.hydra.leader-n").setup(Hydra, cmd, pcmd)
  -- Buffers
  require("user.configs.hydra.leader-b").setup(Hydra, cmd, pcmd)
  -- Open
  require("user.configs.hydra.leader-o").setup(Hydra, cmd, pcmd)
  -- Text manipulation
  require("user.configs.hydra.leader-x").setup(Hydra, cmd, pcmd)
  -- Spelling
  require("user.configs.hydra.leader-z").setup(Hydra, cmd, pcmd)
  -- Yank
  require("user.configs.hydra.leader-y").setup(Hydra, cmd, pcmd)
  -- debug
  require("user.configs.hydra.leader-d").setup(Hydra, cmd, pcmd)
  -- Togggle
  require("user.configs.hydra.leader-t").setup(Hydra, cmd, pcmd)
  -- Jump
  require("user.configs.hydra.leader-j").setup(Hydra, cmd, pcmd)
end
return M
