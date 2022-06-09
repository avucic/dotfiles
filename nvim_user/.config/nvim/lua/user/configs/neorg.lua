local M = {}

M.config = function()
  local neorg = require("user.utils").load_module("neorg")

  neorg.setup({
    ensure_installed = { "norg", "norg_meta", "norg_table", "latex", "markdown" },
    highlight = { enable = true },
    load = {
      ["core.defaults"] = {},
      ["core.keybinds"] = {
        config = {
          default_keybinds = true,
          -- neorg_leader = "N",
          hook = function(keybinds)
            keybinds.map_event_to_mode("norg", {
              n = {
                { "<CR>", "core.norg.esupports.hop.hop-link" },
                -- { "<leader>nb", "core.norg.dirman.new.note" },
                { "<M-CR>", "core.norg.esupports.hop.hop-link", "vsplit" },
              },
            })
            keybinds.remap_event("all", "n", "<leader>nn", "core.norg.dirman.new.note")
          end,
        },
      },
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            work = "/Users/vucinjo/Dropbox/Neorg/work", -- Format: <name_of_workspace> = <path_to_workspace_root>
            me = "/Users/vucinjo/Dropbox/Neorg/me",
          },
          autochdir = true, -- Automatically change the directory to the current workspace's root every time
          index = "index.norg", -- The name of the main (root) .norg file
        },
      },
      ["core.integrations.telescope"] = {},
      ["core.norg.concealer"] = {},
      ["core.gtd.base"] = {
        config = {
          workspace = "me",
          inbox = "inbox.norg",
        },
      },
      ["core.gtd.ui"] = {},
      ["core.integrations.nvim-cmp"] = {},
      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.norg.journal"] = {
        config = {
          workspace = "me",
          strategy = "flat",
        },
      },
      ["core.norg.qol.toc"] = {},
      ["core.presenter"] = {
        config = {
          zen_mode = "truezen",
        },
      },
      ["core.norg.manoeuvre"] = {
        config = { -- Note that this table is optional and doesn't need to be provided
          -- Configuration here
        },
      },
      ["core.export"] = {},
      ["core.export.markdown"] = {},
      ["core.norg.esupports.metagen"] = {
        config = { -- Note that this table is optional and doesn't need to be provided
          type = "auto",
        },
      },

      -- community
      ["external.gtd-project-tags"] = {},
      ["external.context"] = {},
      ["external.kanban"] = {},
    },
  })
end

return M
