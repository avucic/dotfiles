return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"

    -- service name from cwd (/app/services/<svc> -> <svc>), captured once
    local cwd = vim.fn.getcwd()
    local svc = cwd:match "/services/([^/]+)" or vim.fn.fnamemodify(cwd, ":t")

    if type(opts.statusline) == "table" then
      table.insert(
        opts.statusline,
        2,
        status.component.builder {
          {
            provider = function() return vim.env.REMOTE_NVIM and " 󰢹 REMOTE " or "" end,
            hl = "DashboardRemote",
          },
          {
            provider = function() return vim.env.DEVCONTAINER and "  DEV(" .. svc .. ") " or "" end,
            hl = "DashboardDev",
          },
        }
      )
    end

    return opts
  end,
}
