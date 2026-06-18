return {
  {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        monorepo_keymaps = {
          {
            event = "FileType",
            pattern = {
              "typescript",
              "typescriptreact",
            },
            callback = function(args)
              local project = require "utils.project"

              if project.has_eslint() then
                vim.keymap.set("n", "<Leader>lwE", "<cmd>EslintWorkspace<cr>", {
                  buffer = args.buf,
                  desc = "Workspace ESLint",
                })
              end
            end,
          },
        },
      },
    },
  },
}
