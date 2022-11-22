local M = {}

function M.config()
  local nvim_toggler = require("user.core.utils").load_module("nvim-toggler")
  if not nvim_toggler then
    return {}
  end

  nvim_toggler.setup({
    -- your own inverses
    -- inverses = {
    --   ["true"] = "false",
    --   ["yes"] = "no",
    --   ["on"] = "off",
    --   ["left"] = "right",
    --   ["up"] = "down",
    --   ["!="] = "==",
    -- },
    -- removes the default <leader>i keymap
    remove_default_keybinds = true,
  })
end

return M
