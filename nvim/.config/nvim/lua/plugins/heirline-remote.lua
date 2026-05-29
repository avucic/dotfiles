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
            provider = function() return (vim.env.DEVCONTAINER or vim.env.REMOTE_NVIM) and " " or "" end,
          },
          {
            provider = function() return vim.env.DEVCONTAINER and " DEV " or "" end,
            hl = "StatuslineDev",
          },
          {
            provider = function() return vim.env.DEVCONTAINER and "" or "" end,
            hl = "StatuslineDevArrow",
          },
          {
            provider = function() return vim.env.DEVCONTAINER and " " .. svc .. " " or "" end,
            hl = "StatuslineDevText",
          },
          {
            provider = function() return (not vim.env.DEVCONTAINER and vim.env.REMOTE_NVIM and "REMOTE ") or "" end,
            hl = "StatuslineRemote",
          },
          {
            provider = function() return (vim.env.DEVCONTAINER or vim.env.REMOTE_NVIM) and " " or "" end,
          },
        }
      )
    end

    return opts
  end,
}
