return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "ribru17/blink-cmp-spell",
      {
        "saghen/blink.compat",
        opts = {
          enable_events = true,
        },
      },

      {
        "Exafunction/codeium.nvim",
        event = "BufEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
          enable_chat = true,
          enabled = function()
            local path = vim.api.nvim_buf_get_name(0)
            if string.find(path, "oil://", 1, true) == 1 then return false end
            return true
          end,
        },
      },

      { "L3MON4D3/LuaSnip", version = "v2.*" },
      -- {
      --   "Exafunction/windsurf.nvim",
      --   dependencies = {
      --     "nvim-lua/plenary.nvim",
      --   },
      --   cmd = "Codeium",
      --   build = ":Codeium Auth",
      --   opts = { virtual_text = { enabled = true } },
      --   config = function() require("codeium").setup {} end,
      -- },
    },
    opts = {
      snippets = { preset = "luasnip" },
      sources = {
        -- transform_items = function(_, items)
        --   local wanted = {}
        --   for _, item in ipairs(items) do
        --     print(item.kind)
        --     if item.kind ~= require("blink.cmp.types").CompletionItemKind.Snippet then wanted[#wanted + 1] = item end
        --   end
        --   return wanted
        -- end,
        default = {
          "snippets",
          "lsp",
          "path",
          "codeium",
          "buffer",
          "spell",
        },
        per_filetype = { sql = { "dadbod" } },
        providers = {
          dadbod = { module = "vim_dadbod_completion.blink" },
          -- minuet = {
          --   name = "minuet",
          --   module = "minuet.blink",
          --   score_offset = 8, -- Gives minuet higher priority among suggestions
          -- },
          spell = {
            name = "Spell",
            module = "blink-cmp-spell",
            opts = {
              -- EXAMPLE: Only enable source in `@spell` captures, and disable it
              -- in `@nospell` captures.
              enable_in_context = function()
                local curpos = vim.api.nvim_win_get_cursor(0)
                local captures = vim.treesitter.get_captures_at_pos(0, curpos[1] - 1, curpos[2] - 1)
                local in_spell_capture = false
                for _, cap in ipairs(captures) do
                  if cap.capture == "spell" then
                    in_spell_capture = true
                  elseif cap.capture == "nospell" then
                    return false
                  end
                end
                return in_spell_capture
              end,
            },
          },
          codeium = {
            -- IMPORTANT: use the same name as you would for nvim-cmp
            name = "codeium",
            module = "blink.compat.source",

            -- all blink.cmp source config options work as normal:
            -- score_offset = -3,

            -- this table is passed directly to the proxied completion source
            -- as the `option` field in nvim-cmp's source config
            --
            -- this is NOT the same as the opts in a plugin's lazy.nvim spec
            opts = {},
          },
        },
      },

      -- It is recommended to put the "label" sorter as the primary sorter for the
      -- spell source.
      -- If you set use_cmp_spell_sorting to true, you may want to skip this step.
      fuzzy = {
        sorts = {
          function(a, b)
            local sort = require "blink.cmp.fuzzy.sort"
            if a.source_id == "spell" and b.source_id == "spell" then return sort.label(a, b) end
          end,
          -- This is the normal default order, which we fall back to
          "score",
          "kind",
          "label",
        },
      },
    },
  },

  -- {
  --   "milanglacier/minuet-ai.nvim",
  --   config = function()
  --     require("minuet").setup {
  --       provider = "gemini",
  --     }
  --   end,
  -- },
}
