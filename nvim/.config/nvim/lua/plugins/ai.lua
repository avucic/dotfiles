return {
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

          maps.v["<leader>:"] = { ":CodeCompanion " }
        end,
      },
    },
    cmd = { "CodeCompanionChat", "CodeCompanionCmd", "CodeCompanion", "CodeCompanionActions" },
    config = function()
      local adapter = {
        adapter = "ollama",
        -- model = "yi-coder:1.5b",
        -- model = "yi-coder:9b",
        model = "deepseek-coder",
      }
      require("codecompanion").setup {
        strategies = {
          -- chat = adapter,
          chat = { adapter = "gemini" },
          inline = { adapter = "gemini" },
          agent = { adapter = "gemini" },
        },
        --
        -- adapters = {
        --   deepseek = function()
        --     return require("codecompanion.adapters").extend("openai_compatible", {
        --       env = {
        --         url = "https://api.deepseek.com",
        --         api_key = vim.env.DEEPSEEK_API_KEY,
        --       },
        --     })
        --   end,
        -- },
        -- strategies = {
        --   chat = { adapter = "deepseek" },
        --   inline = { adapter = "deepseek" },
        --   agent = { adapter = "deepseek" },
        -- },
        --
        --
        --
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              name = "qwen",
              parameters = {
                sync = true,
              },
              schema = {
                model = {
                  default = "deepseek-coder",
                },
              },
            })
          end,

          -- ollama = {
          --   enabled = true,
          --   model = "deepseek-coder", -- The model you pulled with Ollama
          --   host = "http://localhost:11434", -- Default Ollama API endpoint
          --   context_window = 4096, -- Adjust based on your model's context window
          -- },
          -- ollama = function()
          --   return require("codecompanion.adapters").extend("ollama", {
          --     enabled = true,
          --     model = "deepseek-coder", -- The model you pulled with Ollama
          --     host = "http://localhost:11434", -- Default Ollama API endpoint
          --     context_window = 4096, -- Adjust based on your model's context window
          --   })
          -- end,

          -- ollama = function()
          --   return require("codecompanion.adapters").extend("openai_compatible", {
          --     -- env = {
          --     --   -- url = "http[s]://open_compatible_ai_url", -- optional: default value is ollama url http://127.0.0.1:11434
          --     --   -- api_key = "OPENAI_API_KEY", -- optional: if your endpoint is authenticated
          --     --   chat_url = "/v1/chat/completions", -- optional: default value, override if different
          --     -- },
          --     schema = {
          --       model = {
          --         default = "deepseek-coder:1.3b",
          --       },
          --     },
          --   })
          -- end,

          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              env = {
                --   -- url = "http[s]://open_compatible_ai_url", -- optional: default value is ollama url http://127.0.0.1:11434
                api_key = os.getenv "GEMINI_API_KEY", -- optional: if your endpoint is authenticated
                --   chat_url = "/v1/chat/completions", -- optional: default value, override if different
              },
            })
          end,
        },
        prompt_library = {
          ["Commit Message"] = {
            strategy = "inline",
            description = "Generate a commit message",
            opts = {
              short_name = "commit_message",
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
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function() require("copilot").setup {} end,
  },
}
