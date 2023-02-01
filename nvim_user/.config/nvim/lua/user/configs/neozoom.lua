local M = {}

function M.config()
  local neo_zoom = require("user.core.utils").load_module("neo-zoom")
  if not neo_zoom then
    return {}
  end

  neo_zoom.setup({
    -- top_ratio = 0,
    -- left_ratio = 0.225,
    -- width_ratio = 0.775,
    -- height_ratio = 0.925,
    -- border = 'double',
    -- disable_by_cursor = true, -- zoom-out/unfocus when you click anywhere else.
    -- exclude_filetypes = { 'lspinfo', 'mason', 'lazy', 'fzf', 'qf' },
    exclude_buftypes = { "terminal" },
    presets = {
      {
        filetypes = { "dapui_.*", "dap-repl" },
        config = {
          top_ratio = 0.25,
          left_ratio = 0.6,
          width_ratio = 0.4,
          height_ratio = 0.65,
        },
        callbacks = {
          function()
            vim.wo.wrap = true
          end,
        },
      },
    },
    -- popup = {
    --   -- NOTE: Add popup-effect (replace the window on-zoom with a `[No Name]`).
    --   -- This way you won't see two windows of the same buffer
    --   -- got updated at the same time.
    --   enabled = true,
    --   exclude_filetypes = {},
    --   exclude_buftypes = {},
    -- },
  })
end

return M
