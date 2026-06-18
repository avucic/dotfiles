return {
  {
    'saghen/blink.cmp',
    event        = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'saghen/blink.lib',
      'ribru17/blink-cmp-spell',
    },
    build = function()
      local ok, cmp = pcall(require, 'blink.cmp')
      if ok then cmp.download() end
    end,
    config = function()
      require('blink.cmp').setup({
        enabled = function() return vim.g.cmp_enabled ~= false end,

        snippets = {
          preset = 'default',
          expand  = function(snippet) vim.snippet.expand(snippet) end,
          active  = function(filter) return vim.snippet.active(filter) end,
          jump    = function(direction) vim.snippet.jump(direction) end,
        },

        keymap = {
          preset     = 'default',
          ['<CR>']   = { 'accept', 'fallback' },
          ['<Tab>']  = {
            function()
              local ok, supermaven = pcall(require, 'supermaven-nvim.completion_preview')
              if ok and supermaven.has_suggestion() then
                vim.schedule(supermaven.on_accept_suggestion)
                return true
              end
            end,
            'select_next',
            'fallback',
          },
          ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
        },

        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant       = 'mono',
        },

        sources = {
          default = { 'lsp', 'snippets', 'path', 'buffer', 'spell' },
          per_filetype = {
            sql   = { 'dadbod', 'lsp', 'buffer' },
            mysql = { 'dadbod', 'lsp', 'buffer' },
          },
          providers = {
            codecompanion = {
              name    = 'CodeCompanion',
              module  = 'codecompanion.providers.completion.blink',
              enabled = true,
            },
            dadbod = { module = 'vim_dadbod_completion.blink' },
            spell  = {
              name   = 'Spell',
              module = 'blink-cmp-spell',
              opts   = {
                enable_in_context = function()
                  local pos = vim.api.nvim_win_get_cursor(0)
                  local captures = vim.treesitter.get_captures_at_pos(0, pos[1] - 1, pos[2] - 1)
                  for _, cap in ipairs(captures) do
                    if cap.capture == 'spell'   then return true end
                    if cap.capture == 'nospell' then return false end
                  end
                  return false
                end,
              },
            },
          },
        },

        fuzzy = {
          implementation = 'prefer_rust',
          sorts = {
            function(a, b)
              local sort = require('blink.cmp.fuzzy.sort')
              if a.source_id == 'spell' and b.source_id == 'spell' then return sort.label(a, b) end
            end,
            'score', 'kind', 'label',
          },
        },

        completion = {
          menu = {
            border = 'rounded',
            draw   = { treesitter = { 'lsp' } },
          },
          documentation = {
            auto_show          = true,
            auto_show_delay_ms = 200,
            window             = { border = 'rounded' },
          },
          ghost_text = { enabled = false },
        },

        signature = {
          enabled = true,
          window  = { border = 'rounded' },
        },
      })
    end,
  },
}
