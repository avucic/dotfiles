return function()
  local portal = require("user.core.utils").load_module("portal")
  if not portal then
    return {}
  end

  portal.setup({
    query = { "different", "different", "different", "different" },
    portal = {
      title = {
        render_empty = false,
      },
    },
  })
end