local M = {}

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
  local alpha = require("user.configs.alpha").config()
  local aerial = require("user.configs.aerial").config()
  local _lazygit = require("user.configs.lazygit").config()
  local session_manager = require("user.configs.session_manager").config()
  local mappings = require("user.core.mappings").config()

  return {
    -- Set colorscheme
    colorscheme = colorscheme,
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
      -- remotes = { -- easily ad new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
      -- },
    },

    -- set vim options here (vim.<first_key>.<second_key> =  value)
    options = {
      opt = {
        relativenumber = false, -- sets vim.opt.relativenumber
        spell = true,
        spelllang = { "en_us" },
      },
      g = {
        mapleader = " ", -- sets vim.g.mapleader
        autoformat_on_save = 1,
        ["vim_current_word#highlight_current_word"] = 0,
      },
    },

    -- Default theme configuration
    default_theme = {
      diagnostics_style = { italic = true },
      -- Modify the color table
      colors = {
        -- fg = "#abb2bf",
      },
      -- Modify the highlight groups
      highlights = function(highlights)
        local C = require("default_theme.colors")

        highlights.Normal = { fg = C.fg, bg = C.bg }
        return highlights
      end,

      -- Disable default plugins
      plugins = {
        aerial = true,
        -- alpha = true,
        beacon = false,
        bufferline = true,
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
        vimwiki = false,
        ["which-key"] = wk["settings"],
      },
    },

    ui = {
      nui_input = true,
      telescope_select = true,
    },

    -- Configure plugins
    plugins = {
      -- Add plugins, the packer syntax without the "use"
      init = plugins,
      -- All other entries override the setup() call for default plugins
      packer = {
        max_jobs = 5,
        compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
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
    },

    -- Add paths for including more VS Code style snippets in luasnip
    luasnip = {
      vscode_snippet_paths = {},
    },

    ["which-key"] = {
      -- Add bindings
      register_mappings = wk["mappings"],
    },

    lsp = lsp,

    -- CMP Source Priorities
    -- modify here the priorities of default cmp sources
    -- higher value == higher priority
    -- The value can also be set to a boolean for disabling default sources:
    -- false == disabled
    -- true == 1000
    cmp = {
      source_priority = {
        nvim_lsp = 1000,
        spell = 900,
        cmp_tabnine = 800,
        luasnip = 750,
        buffer = 500,
        path = 250,
      },
    },

    -- Diagnostics configuration (for vim.diagnostics.config({}))
    diagnostics = {
      virtual_text = true,
      underline = true,
    },

    -- null-ls configuration
    ["null-ls"] = null_ls,
    mappings = mappings,

    -- This function is run last
    -- good place to configure mappings and vim options
    polish = function()
      -- require("user.mymappings").config()
      if colorscheme == "onedark" then
        require("user.configs.colors.onedark").config()
      end

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
end

return M
