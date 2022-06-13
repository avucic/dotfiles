local M = {}

function M.config()
  local which_key = require("user.utils").load_module("which-key")

  local ctrl_opts = {
    mode = "n",
    prefix = "",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
  }

  local ctrl_mappings = {
    ["<c-w>"] = {
      name = "Window",
      q = { "<cmd>:q<cr>", "Close" },
      d = { "<cmd>lua require('user.utils').delete_window()<cr>", "Close" },
      D = { "<cmd>:only<cr>", "Close other windows" },
      t = { "<c-w>t", "Move to new tab" },
      ["="] = { "<cmd>FocusEqualise<CR><cmd>FocusDisable<CR>", "Equally size" },
      w = { "<c-w>x", "Swap" },
      m = { "<cmd>FocusEnable<CR><cmd>FocusSplitCycle<CR>", "Maximazie" },
      -- v = { ":FocusSplitRight<CR>", "Focus split right" },
      -- s = { ":FocusSplitDown<CR>", "Focus split down" },
    },
    ["<c-t>"] = {
      name = "Tab",
      q = { "<cmd>:tabclose<cr>", "Close" },
      n = { "<cmd>:tabnew<CR>", "New tab" },
    },
  }

  which_key.register(ctrl_mappings, ctrl_opts)

  local settings = {
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = "center",
    },
  }

  local mappings = {
    ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
    ["q"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
    ["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy buffer find" },
    ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    ["p"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

    -- S = {
    --   name = "Session",
    --   s = { "<cmd>SaveSession<cr>", "Save Session" },
    --   l = { "<cmd>RestoreSession<cr>", "Restore Session" },
    -- },
    --
    b = {
      name = "Buffers",
      j = { "<cmd>BufferLinePick<cr>", "Jump to buffer" },
      q = { "<cmd>Bdelete!<CR>", "Close Buffer" },
      b = { "<cmd>Telescope buffers <CR>", "List of buffers" },
      D = { "<cmd>w | %bd | e#<CR>", "Close other buffers" },
    },

    j = {
      name = "Jump",
      -- c = { "<cmd>HopChar1<cr>", "Jump to char" },
      -- w = { "<cmd>HopWordMW<cr>", "Jump to word" },
      w = { "<cmd>lua require('user.utils').focus_window()<cr>", "Pick Window" },
      -- l = { "<cmd>HopLine<cr>", "Jump to line" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Jump to Document symbol" },
      S = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Jump to Workspace symbol" },
    },

    -- d = {
    --   name = "Trouble",
    --   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
    --   d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostic" },
    --   l = { "<cmd>Trouble loclist<cr>", "Loclist" },
    --   q = { "<cmd>Trouble quickfix<cr>", "Quickfix" },
    --   t = { "<cmd>TodoTrouble<cr>", "Todos" },
    --   r = { "<cmd>Trouble lsp_references<cr>", "LSP References" },
    -- },
    P = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      d = { "<cmd>PackerClean<cr>", "Clean" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    f = {
      name = "Files",
      b = { "<cmd>lua require('telescope.builtin').file_browser()<cr>", "File browser" },
      f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find File" },
      -- l = { "<cmd>Lf<cr>", "Open LF" },
      r = { "<cmd>lua require('telescope').extensions.frecency.frecency()<cr>", "Open Recent File" },
      s = { "<cmd>w<cr>", "Save Buffer" },
      t = { "<cmd>Neotree focus<CR>", "Focus Tree" },
      -- T = { "<cmd>NvimTreeFindFile<CR>", "Find in Tree" },
      z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
      y = { ':let @*=expand("%")<cr>', "Copy file path" },
      F = { ":!ls %:p<CR>", "Show file path" },
      R = { ":e %<CR>", "Reload" },
    },

    g = {
      name = "Git",
      j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      -- s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      -- t = "Open Gitui", -- comand in toggleterm.lua
      g = {
        "<cmd>lua require('user.utils').toggle_term_cmd('lazygit --use-config-file ~/.config/lazygit/config.yml', {direction = 'float'})<CR>",
        "Lazygit",
      },
      s = {
        "<cmd>lua require('user.utils').toggle_term_cmd('lazygit --use-config-file ~/.config/lazygit/config.yml', {direction = 'float'})<CR>",
        "Lazygit",
      },
      -- s = { "<cmd>Neogit<CR>", "Git status" },
      -- u = {
      --   "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      --   "Undo Stage Hunk",
      -- },
      -- g = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      -- b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      l = { false },
      b = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Toogle Blame" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
      -- d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
      d = { "<cmd>DiffviewOpen<cr>", "Diff view" },
      h = { "<cmd>DiffviewFileHistory %<cr>", "Diff view file history" },
      o = { "<cmd>OpenGithubFile<cr>", "Open on Github" },
    },

    h = {
      name = "Harpoon",
      a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add file" },
      -- h = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Open Menu" },
      h = { "<cmd>Telescope harpoon marks<cr>", "Open Menu" },
      ["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Open File 1" },
      ["2"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Open File 2" },
      ["3"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Open File 3" },
      ["4"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Open File 4" },
    },

    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
      w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
      n = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
      p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
      l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      R = { "<cmd>Telescope lsp_references<CR>", "References" },
    },
    s = {
      name = "Search",
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      -- h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      c = { "<cmd>Telescope commands<cr>", "Commands" },
      h = { "<cmd>Telescope command_history<cr>", "Command History" },
      -- c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
      -- e = { "<cmd>Telescope symbols<cr>", "Emoji" },
      T = { "<cmd>Telescope<cr>", "Telescope" },
      -- s = { "<cmd>Telescope live_grep<cr>", "Text" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },

      r = {
        name = "Replace",
        r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
        w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
        f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
      },
    },

    -- t = {
    -- 	name = "Tabs",
    -- 	-- n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    -- 	c = { "<cmd>tabnew<cr>", "New" },
    -- 	n = { "<cmd>tabNext<cr>", "Next" },
    -- 	p = { "<cmd>tabprevious<cr>", "Previous" },
    -- 	d = { "<cmd>tabclose<cr>", "Close" },
    -- },
    --
    o = {
      o = { "<cmd>AerialToggle! right<cr>", "Symbols Outline" },
      t = {
        name = "Terminal",
        -- n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
        -- u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
        -- t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
        f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
        h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
        H = { "<cmd>2ToggleTerm direction=horizontal<cr>", "Horizontal" },
        v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
        V = { "<cmd>2ToggleTerm direction=vertical<cr>", "Vertical" },
        t = { "<cmd>ToggleTerm  direction=tab<cr>", "Tab" },
        ["."] = { "<cmd>term<cr>", "Here" },
      },
      d = {
        name = "DB",
        -- o = { "<cmd>DB<cr><cmd>DBUIToggle<cr>", "Open DB Connection" },
        o = { "<cmd>lua require('user.configs.dadbod').db_tasks()<cr>", "Open DB Connection" },
        t = { "<cmd>DBUIToggle<cr>", "Toggle DB UI" },
      },
    },

    x = {
      name = "LanguageTool",
      g = {
        c = { "<cmd>GrammarousCheck<cr>", "Grammar check" },
        i = { "<Plug>(grammarous-open-info-window)", "Open the info window" },
        r = { "<Plug>(grammarous-reset)", "Reset the current check" },
        f = { "<Plug>(grammarous-fixit)", "Fix the error under the cursor" },
        x = {
          "<Plug>(grammarous-close-info-window)",
          "Close the information window",
        },
        e = {
          "<Plug>(grammarous-remove-error)",
          "Remove the error under the cursor",
        },
        n = {
          "<Plug>(grammarous-move-to-next-error)",
          "Move cursor to the next error",
        },
        p = {
          "<Plug>(grammarous-move-to-previous-error)",
          "Move cursor to the previous error",
        },
        d = {
          "<Plug>(grammarous-disable-rule)",
          "Disable the grammar rule under the cursor",
        },
      },
      i = {
        "<Plug>(Inflect)",
        "Inflect",
      },
    },

    z = {
      name = "Spelling",
      n = { "]s", "Next" },
      p = { "[s", "Previous" },
      a = { "zg", "Add word" },
      f = { "1z=", "Use 1. correction" },
      l = { "<cmd>Telescope spell_suggest<cr>", "List corrections" },
    },

    y = {
      f = { "<cmd>cp :let @' = expand('%')<cr>", "Copy file path" },
    },

    d = {
      name = "Debug",
      o = { "<cmd>lua require('dap').open()<cr>", "Open" },
      d = { "<cmd>lua require('dap').continue()<cr>", "Start Debug" },
      c = { "<cmd>lua require('dap').continue()<cr>", "Start Debug" },
      q = {
        "<cmd>lua require('dap').terminate()<cr><cmd>lua require('dap').close()<cr><cmd>lua require('dap').disconnect()<cr><cmd>lua require('dapui').close()<cr><cmd>lua require('dap').repl.close()<cr>",
        "Close",
      },

      -- q = { "<cmd>lua require('dap').close()<cr>", "Close" },
      b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle breakpoint" },
      [":"] = { "<cmd>lua require('dap').repl.toggle()<cr>", "Repl" },
      n = { "<cmd>lua require('dap').step_over()<cr>", "Step over" },
      i = { "<cmd>lua require('dap').step_into()<cr>", "Step knto" },
      p = { "<cmd>lua require('dap').step_out()<cr>", "Step out" },
      u = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle UI" },
      -- h = { "<cmd>lua require('dap.ui.variables').hover()<cr>", "Variable Hover" },
      -- v = { "<cmd>lua require('dap.ui.variables').hover()<cr>", "Variable Hover Visual" },
    },
    r = {
      name = "Run",
      t = { "<cmd>lua require('telescope').extensions.vstask.tasks()<cr>", "Tasks" },
      p = {},
    },
    t = {
      name = "Tasks",
      t = { "<cmd>lua require('telescope').extensions.vstask.tasks()<cr>", "Tasks" },
      p = {},
      z = {
        name = "Zen",
        p = { "<cmd>TZAtaraxis<cr>", "Poet mode" },
        f = { "<cmd>TZFocus<cr>", "Focus mode" },
        m = { "<cmd>TZMinimalist:<cr>", "Minimalist mode" },
      },
      m = { "<cmd>MinimapToggle<cr>", "Minimap" },
    },
    n = {
      name = "Notes",
      n = { "<cmd>Neorg keybind all core.norg.dirman.new.note<cr>", "New note" },
      i = { "<cmd>e ~/Dropbox/Neorg/me/index.norg<cr>", "Index" },
      f = { "<cmd>Neorg keybind allcore.integrations.telescope.find_linkable<cr>", "Find note" },
      v = { "<cmd>Neorg gtd views<cr>", "Views" },
      e = { "<cmd>Neorg gtd edit<cr>", "Edit" },
      c = { "<cmd>Neorg gtd capture<cr>", "Capture" },
      m = { "<cmd>Neorg inject-metadata<cr>", "Metadata" },
      j = {
        name = "Journal",
        d = { "<cmd>Neorg journal today<cr>", "Today" },
        t = { "<cmd>Neorg journal tommorow<cr>", "Tommorow" },
      },
    },
    -- x = {
    --   name = "Text",
    --   t = { "<cmd>lua require('telescope').extensions.vstask.tasks()<cr>", "Tasks" },
    --   p = {},
    -- },
  }

  return {
    settings = settings,
    mappings = mappings,
  }
end

return M
