return function(_, opts)
  local possession = require("user.core.utils").load_module("nvim-possession")
  if not possession then
    return {}
  end

  possession.setup({
    autoswitch = {
      enable = true, -- default false
    },
  })
end
