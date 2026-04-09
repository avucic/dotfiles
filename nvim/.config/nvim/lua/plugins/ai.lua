return {
  {
    "github/copilot.vim",
    cmd = "Copilot",
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<leader>:"] = { desc = "AI" }

          maps.n["<leader>:l"] = {
            function() require("codecompanion").prompt "lsp" end,
            desc = "Explain the LSP diagnostics for the selected code",
          }

          maps.v["<leader>:l"] = {
            function() require("codecompanion").prompt "lsp" end,
            desc = "Explain the LSP diagnostics for the selected code",
          }

          maps.n["<leader>::"] = {
            "<cmd>CodeCompanionChat<cr>",
            desc = "Chat",
          }

          maps.n["<leader>:a"] = {
            "<cmd>CodeCompanionActions<cr>",
            desc = "Actions",
          }

          maps.n["<leader>:"] = {
            "<cmd>CodeCompanion<cr>",
            desc = "Prompt",
          }

          maps.v["<leader>::"] = { ":CodeCompanion " }
        end,
      },
    },
    cmd = { "CodeCompanionChat", "CodeCompanionCmd", "CodeCompanion", "CodeCompanionActions" },

    config = function()
      ---@type ProjectConfig
      local project = vim.g.project or {}
      local adapter = project.ai_adapter or "copilot"

      require("codecompanion").setup {
        strategies = {
          chat = { adapter = adapter },
          inline = { adapter = adapter },
          agent = { adapter = adapter },
        },
        adapters = {
          http = {
            openrouter_auto = require("plugins.custom.codecompanion").adapters.openrouter_auto,
            openrouter_free = require("plugins.custom.codecompanion").adapters.openrouter_free,
            ollama = require("plugins.custom.codecompanion").adapters.ollama,
            gemini = require("plugins.custom.codecompanion").adapters.gemini,
          },
        },
        prompt_library = {
          ["My Commit Message"] = {
            strategy = "inline",
            description = "Generate a commit message",
            opts = {
              auto_submit = true,
              placement = "before|false",
            },
            prompts = {
              {
                role = "user",
                content = function()
                  return string.format(
                    [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

                ` ` `diff
                %s
                ` ` `

                When unsure about the module names to use in the commit message, you can refer to the last 20 commit messages in this repository:

                ` ` `
                %s
                ` ` `
                Output only the commit message without any explanations and follow-up suggestions.

                {List of details if necessary using bullets}

                Return the code only and no markdown codeblocks.
                ]],
                    vim.fn.system "git diff --no-ext-diff --staged",
                    vim.fn.system 'git log --pretty=format:"%s" -n 20'
                  )
                end,
                opts = {
                  contains_code = true,
                },
              },
            },
          },
        },
      }
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    config = function()
      require("supermaven-nvim").setup {
        keymaps = {
          accept_suggestion = "<C-e>",
          clear_suggestion = "<C-c>",
          accept_word = "<C-f>",
        },
        -- disable_inline_completion = false,
        disable_keymaps = false,
      }
    end,
  },
}
