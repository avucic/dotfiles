local M = {}

M.config = function()
  local neorg = require("user.core.utils").load_module("neorg")
  if not neorg then
    return {}
  end

  neorg.setup({
    ensure_installed = { "norg", "norg_meta", "norg_table", "latex", "markdown" },
    highlight = {
      enable = true,
    },
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
      ["core.integrations.treesitter"] = {
        config = {
          norg = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg",
            files = { "src/parser.c", "src/scanner.cc" },
            branch = "main",
          },
          norg_meta = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
            files = { "src/parser.c" },
            branch = "main",
          },
          norg_table = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
            files = { "src/parser.c" },
            branch = "main",
          },
        },
      },
      ["core.integrations.telescope"] = {},
      -- ["core.norg.concealer"] = {},
      ["core.norg.concealer"] = {
        config = {
          icons = {
            todo = {
              -- done = { icon = "✓" },
              -- pending = { icon = "▶" },
              -- uncertain = { icon = "⁇" },
              -- on_hold = {
              --   icon = "",
              --   query = "(todo_item_on_hold) @icon",
              -- },
              -- urgent = {
              --   icon = "!",
              --   query = "(todo_item_urgent) @icon",
              -- },
              -- pending = {
              --   enabled = true,
              --   icon = "",
              --   highlight = "NeorgTodoItemPendingMark",
              --   query = "(todo_item_pending) @icon",
              --   extract = function()
              --     return 1
              --   end,
              -- },
              -- undone = { icon = "■" },
              ----------------------
              -- todo checkbox
              done = {
                enabled = true,
                icon = "",
                -- highlight = "NeorgTodoItemDoneMark",
                query = "(todo_item_done) @icon",
                extract = function()
                  return 1
                end,
              },

              pending = {
                enabled = true,
                icon = "",
                -- highlight = "NeorgTodoItemPendingMark",
                query = "(todo_item_pending) @icon",
                extract = function()
                  return 1
                end,
              },

              undone = {
                enabled = true,
                icon = "×",
                -- highlight = "NeorgTodoItemUndoneMark",
                query = "(todo_item_undone) @icon",
                extract = function()
                  return 1
                end,
              },

              uncertain = {
                enabled = true,
                icon = "",
                -- highlight = "NeorgTodoItemUncertainMark",
                query = "(todo_item_uncertain) @icon",
                extract = function()
                  return 1
                end,
              },

              on_hold = {
                enabled = true,
                icon = "",
                -- highlight = "NeorgTodoItemOnHoldMark",
                query = "(todo_item_on_hold) @icon",
                extract = function()
                  return 1
                end,
              },

              cancelled = {
                enabled = true,
                icon = "",
                -- highlight = "NeorgTodoItemCancelledMark",
                query = "(todo_item_cancelled) @icon",
                extract = function()
                  return 1
                end,
              },

              urgent = {
                enabled = true,
                icon = "!",
                -- highlight = "NeorgTodoItemUrgentMark",
                query = "(todo_item_urgent) @icon",
                extract = function()
                  return 1
                end,
              },
            },
            -- todo list icon
            list = {
              enabled = true,

              level_1 = {
                enabled = true,
                icon = "•",
                -- highlight = "@neorg.headings.1.title",
                query = "(unordered_list1_prefix) @icon",
              },

              level_2 = {
                enabled = true,
                icon = " ❂",
                -- highlight = "@neorg.headings.2.title",
                query = "(unordered_list2_prefix) @icon",
              },

              level_3 = {
                enabled = true,
                icon = "  ✸",
                -- highlight = "@neorg.headings.3.title",
                query = "(unordered_list3_prefix) @icon",
              },

              level_4 = {
                enabled = true,
                icon = "   ★", -- ○ ★ ⚝ ○ ◉ ★
                -- highlight = "@neorg.headings.4.title",
                query = "(unordered_list4_prefix) @icon",
              },

              level_5 = {
                enabled = true,
                icon = "     •",
                -- highlight = "@neorg.headings.5.title",
                query = "(unordered_list5_prefix) @icon",
              },

              level_6 = {
                enabled = true,
                icon = "      ✦",
                -- highlight = "@neorg.headings.6.title",
                query = "(unordered_list6_prefix) @icon",
              },
            },

            marker = {
              enabled = true,
              icon = " ❚",
              highlight = "NeorgMarker",
              query = "[ (marker_prefix) (link_target_marker) ] @icon",
            },
          },
        },
      },
      ["core.gtd.base"] = {
        config = {
          workspace = "me",
          inbox = "inbox.norg",
          syntax = {
            context = "#contexts",
            start = "#time.start",
            due = "#time.due",
            waiting = "#waiting.for",
          },
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
      ["core.tangle"] = {},
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
      ["external.kanban"] = {
        config = {
          task_states = {
            "undone",
            "done",
            "pending",
            "cancelled",
            "uncertain",
            "urgent",
            "recurring",
            "on_hold",
          },
        },
      },
    },
  })
end

return M
