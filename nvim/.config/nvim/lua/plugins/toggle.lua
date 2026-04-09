return {
  {
    "rgroli/other.nvim",
    cmd = { "Other", "OtherClear" },
    init = function(_)
      require("astrocore").set_mappings {
        n = {
          ["<Leader>to"] = { "<cmd>Other<cr>", desc = "Other file" },
          ["<Leader>tO"] = { "<cmd>OtherClear<cr>", desc = "Other clear" },
        },
      }
    end,
    config = function(_, opts) require("other-nvim").setup(opts) end,
    opts = function(_, opts)
      local mappings = {
        -- "rails",
        -- "react",
        -- "rust",
      }

      local project = vim.g.project or {}
      local custom_other_mappings = project.custom_other_mappings or {}

      vim.list_extend(mappings, custom_other_mappings)

      return {
        -- rememberBuffers = false,
        -- keybindings = {
        --   ["<cr>"] = "open_file()",
        --   ["<esc>"] = "close_window()",
        --   t = "open_file_tabnew()",
        --   q = "close_window()",
        --   ["<c-v>"] = "open_file_vs()",
        --   ["<c-s>"] = "open_file_sp()",
        -- },
        -- hooks = {
        --   onFindOtherFiles = function(matches) return matches end,
        -- },
        mappings = mappings,
      }
    end,
  },
}
