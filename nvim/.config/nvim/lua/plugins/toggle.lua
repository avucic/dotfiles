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
    opts = {
      rememberBuffers = false,
      keybindings = {
        ["<cr>"] = "open_file()",
        ["<esc>"] = "close_window()",
        t = "open_file_tabnew()",
        q = "close_window()",
        ["<c-v>"] = "open_file_vs()",
        ["<c-s>"] = "open_file_sp()",
      },
      hooks = {
        onFindOtherFiles = function(matches) return matches end,
      },
      mappings = {
        -- {
        --   pattern = "/app/components/(.*).html.erb$",
        --   target = "/app/components/%1.rb",
        --   context = "component",
        -- },
        {
          pattern = "/app/components/(.*)/component.rb",
          target = {
            {
              target = "/app/components/%1/component.html.erb",
              context = "html",
            },
            {
              target = "/spec/components/%1/component_spec.rb",
              context = "spec",
            },
          },
        },
        {
          pattern = "/app/components/(.*)/component.html.erb$",
          target = {
            {
              target = "/app/components/%1/component.rb",
              context = "component",
            },
            {
              target = "/spec/components/%1/component_spec.rb",
              context = "spec",
            },
          },
        },
        {
          pattern = "/app/controllers/(.*)_controller.rb",
          target = {
            {
              target = "/spec/requests/%1_spec.rb",
              context = "request_spec",
            },
            {
              target = "/app/views/%1/index.html.erb",
              context = "views",
            },
          },
        },
        {
          pattern = "/spec/requests/(.*)_spec.rb",
          target = "/app/controllers/%1_controller.rb",
          context = "request_spec",
        },
        {
          pattern = "/spec/(.*)_spec.rb",
          target = "/app/%1.rb",
          context = "spec",
        },
        {
          pattern = "/app/(.*).rb",
          target = "/spec/%1_spec.rb",
          context = "file",
        },
        {
          pattern = "/lib/(.*).rb",
          target = "/spec/lib/%1_spec.rb",
          context = "file",
        },
        {
          pattern = "/spec/lib/(.*)_spec.rb",
          target = "/lib/%1.rb",
          context = "spec",
        },
        {
          pattern = "/lib/(.*).rake",
          target = "/spec/lib/%1_spec.rb",
          context = "file",
        },
        {
          pattern = "/spec/lib/(.*)_spec.rb",
          target = "/lib/%1.rake",
          context = "spec",
        },
        {
          pattern = "(.*).tsx",
          target = "%1.test.tsx",
          context = "spec",
        },

        {
          pattern = "(.*).test.tsx",
          target = "%1.tsx",
          context = "file",
        },

        {
          pattern = "(.*).tsx",
          target = "%1.stories.tsx",
          context = "spec",
        },

        {
          pattern = "(.*).stories.tsx",
          target = "%1.tsx",
          context = "file",
        },
      },
    },
  },
}
