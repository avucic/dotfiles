local M = {}
--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key

function M.config()
  local colorscheme = "default_theme"
  local present, _ = pcall(require, "onedark")
  if present then
    colorscheme = "onedark"
  end

  local plugins = require("user.core.plugins").config()
  local wk = require("user.configs.which_key").config()
  local treesitter = require("user.configs.treesitter").config()
  local telescope = require("user.configs.telescope").config()
  local neotree = require("user.configs.neo-tree").config()
  local toogleterm = require("user.configs.toggleterm").config()
  local cmp = require("user.configs.cmp").config()
  local bufferline = require("user.configs.bufferline").config()
  local lsp = require("user.configs.lsp").config()
  local null_ls = require("user.configs.null-ls").config()
  local mason_null_ls = require("user.configs.mason_null").config()
  local alpha = require("user.configs.alpha").config()
  local aerial = require("user.configs.aerial").config()
  local _lazygit = require("user.configs.lazygit").config()
  local session_manager = require("user.configs.session_manager").config()
  local mappings = require("user.core.mappings").config()
  local mason = require("user.configs.mason").config()
  local window_picker = require("user.configs.window_picker").config()
  local dressing = require("user.configs.dressing").config()
  local indent_blankline = require("user.configs.indent_blankline").config()

  local config = {

    -- Configure AstroNvim updates
    updater = {
      remote = "origin", -- remote to use
      channel = "nightly", -- "stable" or "nightly"
      version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
      branch = "main", -- branch name (NIGHTLY ONLY)
      commit = nil, -- commit hash (NIGHTLY ONLY)
      pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
      skip_prompts = false, -- skip prompts about breaking changes
      show_changelog = true, -- show the changelog after performing an update
      auto_reload = false, -- automatically reload and sync packer after a successful update
      auto_quit = false, -- automatically quit the current session after a successful update
      -- remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
      -- },
    },

    -- Set colorscheme to use
    colorscheme = "default_theme",

    -- Add highlight groups in any theme
    highlights = {
      -- init = { -- this table overrides highlights in all themes
      --   Normal = { bg = "#000000" },
      -- }
      -- duskfox = { -- a table of overrides/changes to the duskfox theme
      --   Normal = { bg = "#000000" },
      -- },
    },

    -- set vim options here (vim.<first_key>.<second_key> = value)
    options = {
      opt = {
        -- set to true or false etc.
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        spelllang = { "en_us" },
        conceallevel = 2,
      },
      g = {
        mapleader = " ", -- sets vim.g.mapleader
        autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
        cmp_enabled = true, -- enable completion at start
        autopairs_enabled = true, -- enable autopairs at start
        diagnostics_enabled = true, -- enable diagnostics at start
        status_diagnostics_enabled = true, -- enable diagnostics in statusline
        icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
        ui_notifications_enabled = true, -- disable notifications when toggling UI elements
        autoformat_on_save = true,
        ["vim_current_word#highlight_current_word"] = 0,
      },
    },
    -- If you need more control, you can use the function()...end notation
    -- options = function(local_vim)
    --   local_vim.opt.relativenumber = true
    --   local_vim.g.mapleader = " "
    --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
    --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
    --
    --   return local_vim
    -- end,

    -- Set dashboard header
    header = {
      " █████  ███████ ████████ ██████   ██████",
      "██   ██ ██         ██    ██   ██ ██    ██",
      "███████ ███████    ██    ██████  ██    ██",
      "██   ██      ██    ██    ██   ██ ██    ██",
      "██   ██ ███████    ██    ██   ██  ██████",
      " ",
      "    ███    ██ ██    ██ ██ ███    ███",
      "    ████   ██ ██    ██ ██ ████  ████",
      "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
      "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
      "    ██   ████   ████   ██ ██      ██",
    },

    -- Default theme configuration
    default_theme = {
      -- Modify the color palette for the default theme
      colors = {
        fg = "#abb2bf",
        bg = "#1e222a",
      },
      highlights = function(hl) -- or a function that returns a new table of colors to set
        local C = require("default_theme.colors")

        hl.Normal = { fg = C.fg, bg = C.bg }

        -- New approach instead of diagnostic_style
        hl.DiagnosticError.italic = true
        hl.DiagnosticHint.italic = true
        hl.DiagnosticInfo.italic = true
        hl.DiagnosticWarn.italic = true

        return hl
      end,
      -- enable or disable highlighting for extra plugins
      plugins = {
        aerial = true,
        beacon = false,
        bufferline = true,
        cmp = true,
        dashboard = true,
        highlighturl = true,
        hop = false,
        indent_blankline = true,
        lightspeed = false,
        ["neo-tree"] = true,
        notify = true,
        ["nvim-tree"] = false,
        ["nvim-web-devicons"] = true,
        rainbow = true,
        symbols_outline = false,
        telescope = true,
        treesitter = true,
        vimwiki = false,
        ["which-key"] = true,
      },
    },

    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },

    -- Extend LSP configuration
    lsp = lsp,

    -- Mapping data with "desc" stored directly by vim.keymap.set().
    --
    -- Please use this mappings table to set keyboard mapping since this is the
    -- lower level configuration and more robust one. (which-key will
    -- automatically pick-up stored data by this setting.)
    mappings = mappings,

    -- Configure plugins
    plugins = {
      -- Add plugins, the packer syntax without the "use"
      init = plugins,
      -- All other entries override the setup() call for default plugins
      packer = {
        max_jobs = 5,
        -- compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
      },

      treesitter = treesitter,
      telescope = telescope,
      ["neo-tree"] = neotree,
      toggleterm = toogleterm,
      cmp = cmp,
      bufferline = bufferline,
      ["which-key"] = wk["settings"],
      alpha = alpha,
      aerial = aerial,
      session_manager = session_manager,
      -- use mason-lspconfig to configure LSP installations
      ["mason-lspconfig"] = mason["mason-lspconfig"],
      -- use mason-tool-installer to configure DAP/Formatters/Linter installation
      ["mason-tool-installer"] = mason["mason-tool-installer"],
      ["mason-null-ls"] = mason["mason-null-ls"],
      ["window-picker"] = window_picker,

      dressing = dressing,
      ["null-ls"] = null_ls,
      ["mason-null-ls"] = mason_null_ls,
      indent_blankline = indent_blankline,
    },

    -- LuaSnip Options
    luasnip = {
      -- Extend filetypes
      filetype_extend = {
        -- javascript = { "javascriptreact" },
      },
      -- Configure luasnip loaders (vscode, lua, and/or snipmate)
      vscode = {
        -- Add paths for including more VS Code style snippets in luasnip
        paths = {},
      },
    },

    -- CMP Source Priorities
    -- modify here the priorities of default cmp sources
    -- higher value == higher priority
    -- The value can also be set to a boolean for disabling default sources:
    -- false == disabled
    -- true == 1000
    cmp = {
      source_priority = {
        nvim_lsp = 1000,
        luasnip = 750,
        buffer = 500,
        path = 250,
      },
    },

    -- Modify which-key registration (Use this with mappings table in the above.)
    ["which-key"] = {
      -- Add bindings
      register = wk["mappings"],
    },

    -- This function is run last and is a good place to configuring
    -- augroups/autocommands and custom filetypes also this just pure lua so
    -- anything that doesn't fit in the normal config locations above can go here
    polish = function()
      -- Set up custom filetypes
      -- vim.filetype.add {
      --   extension = {
      --     foo = "fooscript",
      --   },
      --   filename = {
      --     ["Foofile"] = "fooscript",
      --   },
      --   pattern = {
      --     ["~/%.config/foo/.*"] = "fooscript",
      --   },
      -- }

      -- load plugins
      local psd = require("user.core.utils").load_module("user.plugins.gen_pass")
      if psd then
        psd.config()
      end

      local date_picker = require("user.core.utils").load_module("user.plugins.date_picker")
      if date_picker then
        date_picker.config()
      end

      -- load autocommands
      local sources = {
        "user.configs.autocmds",
      }

      for _, source in ipairs(sources) do
        local status_ok, fault = pcall(require, source)
        if not status_ok then
          error("Failed to load " .. source .. "\n\n" .. fault)
        end
      end

      vim.g.vim_base64_disable_default_key_mappings = 1
      vim.g.did_load_filetypes = nil

      if vim.g.colorscheme then
        colorscheme = vim.g.colorscheme
        vim.cmd([[colorscheme ]] .. colorscheme)
      end

      if colorscheme == "onedark" then
        require("user.configs.colors.onedark").config()
      end
      -- Set autocommands
      -- vim.api.nvim_create_augroup("packer_conf", {})
      -- vim.api.nvim_create_autocmd("BufWritePost", {
      --   desc = "Sync packer after modifying plugins.lua",
      --   group = "packer_conf",
      --   pattern = "plugins.lua",
      --   command = "source <afile> | PackerSync",
      -- })

      -- hi Folded guifg = #69707D  guibg=NONE
      -- hi CurrentWordTwins guibg=#3e4452 gui=NONE cterm=NONE
      -- vim.cmd [[ colorscheme onedark ]]

      -- Set autocommands
      -- vim.cmd [[
      --   augroup packer_conf
      --     autocmd!
      --     autocmd bufwritepost plugins.lua source <afile> | PackerSync
      --   augroup end
      -- ]]
    end,
  }

  return config
end

return M
