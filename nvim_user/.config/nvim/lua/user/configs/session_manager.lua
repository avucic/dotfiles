local M = {}

function M.config()
  return {
    autosave_last_session = true,
    autosave_ignore_filetypes = {
  "Telescope*",
  "toggleterm",
  "prompt",
  "alpha",
  "WhichKey",
  "cmp_menu",
  "hydra_hint",
  "nofile",
  "filetree",
  "packer",
  "bufferlist",
    },
  }
end

return M
