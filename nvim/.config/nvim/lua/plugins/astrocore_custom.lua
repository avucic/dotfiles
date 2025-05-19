local ft = require "Comment.ft"
ft.set("cedar", { "//%s" })

---@type LazySpec
return {
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
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
        [".env.*"] = "sh",
        ["vifmrc"] = "vim",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = true, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        conceallevel = 3,
        foldenable = false,
        -- foldexpr = "v:lua.vim.treesitter.foldexpr()",
        -- foldtext = "v:lua.vim.treesitter.foldtext()",
      },
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
        maps.n[prefix .. "s"] = { "<cmd>Neogit kind=auto<CR>", desc = "Git status" }
        astrocore.set_mappings(maps, { buffer = bufnr })
      end
    end,
  },
}
