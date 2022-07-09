local M = {}

function M.config()
  local telescope = require("user.core.utils").load_module("telescope")

  if not telescope then
    return {}
  end

  local actions = require("telescope.actions")

  telescope.load_extension("fzf")

  return {
    defaults = {
      file_ignore_patterns = { "node_modules", "%.jpg", "%.png" },
      prompt_prefix = "❯ ",
      selection_caret = "❯ ",
      path_display = { "truncate" },
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "bottom",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },

      mappings = {
        i = {
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,

          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,

          ["<C-d>"] = require("telescope.actions").delete_buffer,

          -- ["<C-c>"] = actions.close,
          --
          -- ["<Down>"] = actions.move_selection_next,
          -- ["<Up>"] = actions.move_selection_previous,
          --
          -- ["<CR>"] = actions.select_default,
          -- ["<C-x>"] = actions.select_horizontal,
          -- ["<C-v>"] = actions.select_vertical,
          -- ["<C-t>"] = actions.select_tab,
          --
          -- ["<C-u>"] = actions.preview_scrolling_up,
          -- ["<C-d>"] = actions.preview_scrolling_down,
          --
          -- ["<PageUp>"] = actions.results_scrolling_up,
          -- ["<PageDown>"] = actions.results_scrolling_down,
          --
          -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          -- ["<C-l>"] = actions.complete_tag,
        },

        n = {
          ["q"] = actions.close,
          --   ["<CR>"] = actions.select_default,
          --   ["<C-x>"] = actions.select_horizontal,
          --   ["<C-v>"] = actions.select_vertical,
          --   ["<C-t>"] = actions.select_tab,
          --
          --   ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          --   ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          --   ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          --   ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          --
          -- ["<C-c>"] = require("telescope.actions").create_note,
          ["n"] = actions.move_selection_next,
          ["p"] = actions.move_selection_previous,
          ["<C-d>"] = require("telescope.actions").delete_buffer,
          --   ["H"] = actions.move_to_top,
          --   ["M"] = actions.move_to_middle,
          --   ["L"] = actions.move_to_bottom,
          --
          --   ["<Down>"] = actions.move_selection_next,
          --   ["<Up>"] = actions.move_selection_previous,
          --   ["gg"] = actions.move_to_top,
          --   ["G"] = actions.move_to_bottom,
          --
          --   ["<C-u>"] = actions.preview_scrolling_up,
          --   ["<C-d>"] = actions.preview_scrolling_down,
          --
          --   ["<PageUp>"] = actions.results_scrolling_up,
          --   ["<PageDown>"] = actions.results_scrolling_down,
        },
      },
    },
    -- pickers = {
    --   harpoon = {
    --     mappings = {
    --       i = {
    --         ["<C-n>"] = require("harpoon.ui").nav_next,
    --         ["<C-p>"] = require("harpoon.ui").nav_prev,
    --       },
    --       n = {
    --         ["<C-n>"] = require("harpoon.ui").nav_next,
    --         ["<C-p>"] = require("harpoon.ui").nav_prev,
    --       },
    --     },
    --   },
    -- },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      lsp_handlers = {
        code_action = {
          telescope = require("telescope.themes").get_dropdown({}),
        },
      },
    },
  }
end

return M
