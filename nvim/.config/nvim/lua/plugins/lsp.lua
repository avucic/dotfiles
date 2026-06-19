return {
  -- ── glance.nvim (LSP peek/preview) ───────────────────────────────────────────
  {
    'dnlhc/glance.nvim',
    keys = {
      { 'gd',  '<cmd>Glance definitions<cr>',      desc = 'Peek definition' },
      { 'gD',  '<cmd>Glance declarations<cr>',     desc = 'Peek declaration' },
      { 'gpi', '<cmd>Glance implementations<cr>',  desc = 'Peek implementations' },
      { 'gpy', '<cmd>Glance type_definitions<cr>', desc = 'Peek type definition' },
    },
    config = function()
      local actions = require('glance').actions
      require('glance').setup({
        border = { enable = true, top_char = '―', bottom_char = '―' },
        theme  = { enable = true, mode = 'darken' },
        mappings = {
          list = {
            ['<CR>']  = actions.jump,
            ['<C-v>'] = actions.jump_vsplit,
            ['<C-s>'] = actions.jump_split,
            ['<C-t>'] = actions.jump_tab,
            ['q']     = actions.close,
            ['<Esc>'] = actions.close,
          },
          preview = {
            ['<C-v>'] = actions.jump_vsplit,
            ['<C-s>'] = actions.jump_split,
            ['<C-t>'] = actions.jump_tab,
            ['q']     = actions.close,
            ['<Esc>'] = actions.close,
          },
        },
      })
    end,
  },

  -- ── Mason: installs binaries ──────────────────────────────────────────────────
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = { ui = { border = "rounded" } },
  },

  -- ── mason-lspconfig: bridges mason ↔ native LSP ───────────────────────────────
  -- lazy = false: must run at startup so automatic_enable fires before any
  -- buffer opens (otherwise vim.lsp.enable() would miss the FileType event).
  {
    'mason-org/mason-lspconfig.nvim',
    lazy         = false,
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'jsonls', 'yamlls' },
        automatic_enable = false,
      })

      -- vim.lsp.enable() doesn't reliably trigger auto-start in nvim 0.12.2.
      -- Use installed servers dynamically so any MasonInstall'd server is picked up.
      -- Formatters that mason-lspconfig incorrectly maps as LSP servers.
      local not_lsp = { stylua = true }
      local missing = {}
      for _, server in ipairs(require('mason-lspconfig').get_installed_servers()) do
        if not_lsp[server] then goto continue end
        local cfg = vim.lsp.config[server]
        if cfg and cfg.filetypes then
          vim.api.nvim_create_autocmd('FileType', {
            pattern  = cfg.filetypes,
            callback = function()
              vim.lsp.start(vim.lsp.config[server])
            end,
          })
        else
          table.insert(missing, server)
        end
        ::continue::
      end
      if #missing > 0 then
        vim.notify(
          'LSP: missing config for: ' .. table.concat(missing, ', ') .. '\nCreate lsp/<server>.lua with cmd + filetypes.',
          vim.log.levels.WARN
        )
      end
    end,
  },

  -- ── Non-LSP tools (formatters, etc.) ─────────────────────────────────────────
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event        = "VimEnter",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = { "stylua", "tree-sitter-cli" },
      auto_update = false,
      run_on_start = true,
    },
  },

  -- ── lazydev: Lua LSP extras for Neovim config ─────────────────────────────────
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      enabled = true,
      library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
    },
  },

  -- ── rustaceanvim: manages its own LSP ────────────────────────────────────────
  {
    "mrcjkb/rustaceanvim",
    version = "^9",
    ft = "rust",
  },
}
