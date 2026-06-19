return {
  -- ── codecompanion ────────────────────────────────────────────────────────────
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      { "<Leader>:", "<cmd>CodeCompanion<cr>", desc = "AI Prompt" },
      { "<Leader>::", "<cmd>CodeCompanionChat<cr>", desc = "AI Chat" },
      { "<Leader>:a", "<cmd>CodeCompanionActions<cr>", desc = "AI Actions" },
      {
        "<Leader>:l",
        function()
          require("codecompanion").prompt("lsp")
        end,
        desc = "Explain LSP diagnostics",
      },
      { "<Leader>::", ":CodeCompanion ", mode = "v", desc = "AI inline" },
      {
        "<Leader>:l",
        function()
          require("codecompanion").prompt("lsp")
        end,
        mode = "v",
        desc = "Explain LSP diagnostics",
      },
    },
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    config = function()
      local adapters = require("plugins.custom.codecompanion_adapters")
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = (vim.g.project or {}).ai_adapter or "copilot",
            slash_commands = {
              ["file"] = {
                opts = { provider = "snacks" },
              },
              ["buffer"] = {
                opts = { provider = "snacks" },
              },
            },
          },
          inline = {
            adapter = (vim.g.project or {}).ai_adapter or "copilot",
            slash_commands = {
              ["file"] = {
                opts = { provider = "snacks" },
              },
              ["buffer"] = {
                opts = { provider = "snacks" },
              },
            },
          },

          agent = {
            adapter = (vim.g.project or {}).ai_adapter or "copilot",

            slash_commands = {
              ["file"] = {
                opts = { provider = "snacks" },
              },
              ["buffer"] = {
                opts = { provider = "snacks" },
              },
            },
          },
        },
        adapters = {
          http = {
            gemini = adapters.gemini,
            anthropic = adapters.anthropic,
            -- githubmodels = adapters.githubmodels,
            ollama = adapters.ollama,
            openrouter_free = adapters.openrouter_free,
            openrouter_auto = adapters.openrouter_auto,
          },
        },
        prompt_library = {
          ["My Commit Message"] = {
            strategy = "inline",
            description = "Generate a conventional commit message",
            opts = { auto_submit = true, placement = "before|false" },
            prompts = {
              {
                role = "user",
                content = function()
                  return string.format(
                    [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

```diff
%s
```

When unsure about the module names to use in the commit message, you can refer to the last 20 commit messages in this repository:

```
%s
```
Output only the commit message without any explanations and follow-up suggestions.

{List of details if necessary using bullets}

Return the code only and no markdown codeblocks.]],
                    vim.fn.system("git diff --no-ext-diff --staged"),
                    vim.fn.system('git log --pretty=format:"%s" -n 20')
                  )
                end,
                opts = { contains_code = true },
              },
            },
          },
        },
      })
    end,
  },

  -- ── copilot ───────────────────────────────────────────────────────────────────
  {
    "github/copilot.vim",
    cmd = "Copilot",
  },

  -- ── supermaven ────────────────────────────────────────────────────────────────
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-e>",
          clear_suggestion = "<C-c>",
          accept_word = "<C-f>",
        },
        disable_keymaps = false,
      })
    end,
  },
}
