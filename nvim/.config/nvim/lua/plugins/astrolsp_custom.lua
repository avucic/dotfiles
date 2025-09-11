-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client)
      --   -- disable formatting for lua_ls
      --   if client.name == "null-ls" then
      --     return false
      --     -- local supported_filetypes = { "markdown", "lua", "json", "yaml", "yml" }
      --     -- return vim.tbl_contains(supported_filetypes, vim.bo.filetype)
      --   end
      --
      --   -- enable all other clients
      --   return true
      -- end,
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
      jsonls = {
        settings = {
          json = {
            format = {
              enable = false,
            },
          },
          validate = { enable = true },
        },
      },
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
      ruby_lsp = {
        -- cmd = {
        --   "/Users/vucinjo/.asdf/shims/ruby-lsp",
        -- },
        -- -- cmd_env = { BUNDLE_GEMFILE = vim.fn.getenv "GLOBAL_GEMFILE" },
        -- -- cmd = { "ruby-lsp" },
        -- filetypes = { "ruby", "eruby" },
        -- root_dir = function() return vim.loop.cwd() end,
        -- settings = {
        init_options = {
          cmd_env = {
            BUNDLE_GEMFILE = vim.loop.cwd() .. "/.ruby-lsp/Gemfile.custom",
          },
          linters = { "standard", "reek" },
          addonSettings = {
            ["Ruby LSP Reek"] = {},
          },
          -- enabledFeatures = {
          --   "codeActions",
          --   "documentHighlights",
          --   "documentSymbols",
          --   "foldingRange",
          --   "formatting",
          --   "hover",
          --   "inlayHints",
          --   "linkedEditingRange",
          --   "selectionRange",
          --   "semanticTokens",
          --   "signatureHelp",
          --   "typeDefinition",
          -- },
          formatter = "standard", -- or "rubocop", etc.,
        },
      },
      -- },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end
      -- function(server, opts)
      --   -- require("lspconfig")[server].setup(opts)
      --   if server == "ruby_lsp" then
      --     require("lspconfig").ruby_lsp.setup {
      --       init_options = {
      --         addonSettings = {
      --           ["Ruby LSP Rails"] = {
      --             enablePendingMigrationsPrompt = true, -- Optional: disable migrations prompt
      --           },
      --         },
      --       },
      --     }
      --   end
      -- end,

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_codelens_refresh = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "InsertLeave", "BufEnter" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        ["<Leader>dc"] = {
          "<cmd> RustLsp debug<cr>",
          desc = "Start rust debugger",
          cond = function(client) return client.name == "rust-analyzer" end,
        },

        ["gd"] = { "<cmd>Glance definitions<CR>", desc = "Definition" },
        ["gI"] = { "<cmd>Glance implementations<cr>", desc = "Implementations" },
        ["<Leader>le"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Diagnostic buffer" },
        ["<Leader>lw"] = { desc = "Workspace" },
        ["<Leader>lwe"] = { "<cmd>lua vim.diagnostic.setqflist()<cr>", desc = "Diagnostic workspace" },
        ["<Leader>lwa"] = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", desc = "Add" },
        ["<Leader>lwr"] = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", desc = "Remove" },
        ["<Leader>lws"] = {
          "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>",
          desc = "Workspace symbols",
        },

        ["<Leader>l?"] = { desc = "Info" },
        ["<Leader>l?l"] = {
          "<Cmd>LspInfo<CR>",
          desc = "LSP information",
          cond = function() return vim.fn.exists ":LspInfo" > 0 end,
        },

        ["<Leader>l?n"] = {
          "<Cmd>NullLsInfo<CR>",
          desc = "Null-ls information",
          cond = function() return vim.fn.exists ":NullLsInfo" > 0 end,
        },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
      if client.name == "vtsls" then
        vim.keymap.set("n", "<leader>lwt", "<cmd>TSC<cr>", { desc = "Run tsc errors check", buffer = bufnr })
      end

      if client.name == "cssls" then
        local capabilities = require("blink-cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

        -- add this line
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        require("lspconfig")["cssls"].setup {
          capabilities = capabilities,
        }
      end
    end,
  },
}
