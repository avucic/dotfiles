---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      -- Configure core features of AstroNvim
      features = {
        large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
        autopairs = true, -- enable autopairs at start
        cmp = true, -- enable completion at start
        diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
        highlighturl = true, -- highlight URLs at start
        notifications = true, -- enable notifications at start
      },
      -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
      diagnostics = {
        virtual_text = true,
        underline = true,
      },
      -- passed to `vim.filetype.add`
      filetypes = {
        -- see `:h vim.filetype.add` for usage
        extension = {
          mdx = "markdown",
          mjml = "eruby",
          cedarschema = "cedar",
          jbuilder = "ruby",
        },
        filename = {
          [".foorc"] = "fooscript",
          ["todo.txt"] = "todotxt",
          ["done.txt"] = "todotxt",
        },
        pattern = {
          [".*/etc/foo/.*"] = "fooscript",
          [".env.*"] = "sh",
          ["vifmrc"] = "vim",
          ["todo.txt"] = "todotxt",
          ["done.txt"] = "todotxt",
        },
      },
      -- vim options can be configured here
      options = {
        opt = { -- vim.opt.<key>
          exrc = true,
          relativenumber = false, -- sets vim.opt.relativenumber
          number = true, -- sets vim.opt.number
          spell = true, -- sets vim.opt.spell
          signcolumn = "yes", -- sets vim.opt.signcolumn to yes
          wrap = false, -- sets vim.opt.wrap
          conceallevel = 2,
          foldenable = false,
          -- foldexpr = "v:lua.vim.treesitter.foldexpr()",
          -- foldtext = "v:lua.vim.treesitter.foldtext()",
        },
      },
      autocmds = {
        no_null_ls_format = {
          {
            event = "LspAttach",
            desc = "Strip formatting capability from null-ls",
            callback = function(args)
              local c = vim.lsp.get_client_by_id(args.data.client_id)
              if not c then return end

              local strip = (vim.g.project and vim.g.project.lsp and vim.g.project.lsp.disable_formatting) or {}

              for _, name in ipairs(strip) do
                if c.name == name or c.name == "null-ls" or c.name == "none-ls" then
                  c.server_capabilities.documentFormattingProvider = false
                  c.server_capabilities.documentRangeFormattingProvider = false
                  return
                end
              end
            end,
          },
        },
        -- vim.api.nvim_create_autocmd("FileType", {
        --   pattern = "markdown",
        --   callback = function()
        --     vim.opt_local.conceallevel = 2
        --   end,
        -- })
      },
      -- commands = {
      --   EslintAll = {
      --     function()
      --       require("lint").linters.eslint.cmd = "eslint"
      --
      --       vim.fn.jobstart({ "pnpm eslint", "." }, {
      --         stdout_buffered = true,
      --         on_stdout = function(_, data)
      --           vim.schedule(function()
      --             vim.fn.setqflist({}, " ", {
      --               title = "ESLint Workspace",
      --               lines = data,
      --             })
      --             vim.cmd "copen"
      --           end)
      --         end,
      --       })
      --     end,
      --     desc = "ESLint whole workspace",
      --   },
      -- },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    -- event = "User AstroGitFile",
    opts = function(_, opts)
      local old_on_attach = opts.on_attach
      opts.on_attach = function(bufnr)
        local astrocore = require "astrocore"
        old_on_attach(bufnr)

        local prefix, maps = "<Leader>g", astrocore.empty_map_table()
        maps.n[prefix .. "s"] = { "<cmd>Neogit kind=split<CR>", desc = "Git status" }
        astrocore.set_mappings(maps, { buffer = bufnr })
      end
    end,
  },
}
