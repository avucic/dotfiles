local M = {}

function M.config()
  vim.cmd([[vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>]])

  -- command line
  vim.cmd([[
    cnoremap <C-A> <Home>
	  cnoremap <C-F> <Right>
	  cnoremap <C-B> <Left>
    ]])

  local map = {
    n = {
      -- remove from Astrovim. TODO: better way?
      ["<A-j>"] = { "<Nop>" },
      ["<A-k>"] = { "<Nop>" },
      ["<leader>d"] = false,
      ["<leader>/"] = false,
      ["<leader>o"] = false,
      ["<leader>x"] = false,
      ["<c-w>"] = false,
      -- ["n"] = "<nop>",

      -- ["<leader>p"] = false,
      -- ["<leader>p"] = "<Nop>",
      ["<leader>gs"] = false,
      ["<leader>gg"] = false,
      ["<leader>tn"] = false,
      ["<leader>tu"] = false,
      ["<leader>tt"] = false,
      ["<leader>tp"] = false,
      ["<leader>tl"] = false,
      ["<leader>tf"] = false,
      ["<leader>th"] = false,
      ["<leader>tv"] = false,
      ["<leader>gj"] = false,
      ["<leader>gk"] = false,
      ["<leader>gl"] = false,
      ["<leader>gp"] = false,
      ["<leader>gh"] = false,
      ["<leader>gr"] = false,
      ["<leader>gu"] = false,
      ["<leader>gd"] = false,
      ["<leader>fw"] = false,
      ["<leader>fW"] = false,
      ["<leader>gt"] = false,
      ["<leader>gb"] = false,
      ["<leader>gc"] = false,
      ["<leader>ff"] = false,
      ["<leader>f"] = false,
      ["<leader>fF"] = false,
      ["<leader>fb"] = false,
      ["<leader>fh"] = false,
      ["<leader>fm"] = false,
      ["<leader>fn"] = false,
      ["<leader>fo"] = false,
      ["<leader>fc"] = false,
      ["<leader>sb"] = false,
      ["<leader>sh"] = false,
      ["<leader>sm"] = false,
      ["<leader>sn"] = false,
      ["<leader>sr"] = false,
      ["<leader>sk"] = false,
      ["<leader>sc"] = false,
      ["<leader>ls"] = false,
      ["<leader>lG"] = false,
      ["<leader>lD"] = false,
      ["<leader>lr"] = false,
      ["<leader>lR"] = false,
      ["<leader>e"] = false,

      ["<leader>ua"] = false,
      ["<leader>ub"] = false,
      ["<leader>uc"] = false,
      ["<leader>uC"] = false,
      ["<leader>ud"] = false,
      ["<leader>ug"] = false,
      ["<leader>ui"] = false,
      ["<leader>ul"] = false,
      ["<leader>un"] = false,
      ["<leader>us"] = false,
      ["<leader>up"] = false,
      ["<leader>ut"] = false,
      ["<leader>uu"] = false,
      ["<leader>uw"] = false,
      ["<leader>uy"] = false,
      ["<leader>uf"] = false,
      ["<leader>t"] = false,
      ["<leader>Sl"] = false,
      ["<leader>Ss"] = false,
      ["<leader>Sd"] = false,
      ["<leader>Sf"] = false,
      ["<leader>S."] = false,

      ["<leader>p"] = "<cmd>lua require('telescope').extensions.project.project{}<CR>",
      -- ["<C-h>"] = false,
      -- ["<C-l>"] = false,

      -- ["<leader>e"] = { "<cmd>lua require'mind'.close()<cr><cmd>Neotree toggle<cr>" },

      ["<c-q>"] = { "<cmd>silent! cclose<cr><cmd>nohlsearch<cr><cmd>ToggleTermToggleAll<cr>" },
      ["<esc>"] = { "<cmd>nohlsearch<cr>" },
      ["<esc><esc>"] = { "<cmd>nohlsearch<cr>" },
      ["Q"] = { "<cmd>qall!<cr>" },
      ["<S-l>"] = { "$" },
      ["<S-h>"] = { "^" },
      ["z="] = { "<cmd>lua require('telescope.builtin').spell_suggest()<CR>" },
      ["<leader>W"] = { "<cmd>:noa w<cr>", desc = "Save without format" },

      ["ww"] = { "<cmd>lua require('nvim-window').pick()<cr>" },

      -- Bookmarks
      ["mm"] = { ":BookmarkToggle<cr>" },
      -- ["ma"] = { ":lua require('telescope').extensions.vim_bookmarks.all()<cr>", desc = "List all Bookmarks" },
      ["ma"] = {
        ":lua require('user.configs.vim_bookmarks').open_bookmarks_workaround()<cr>",
        desc = "List all Bookmarks",
      },
      ["mf"] = {
        ":lua require('telescope').extensions.vim_bookmarks.current_file()<cr>",
        desc = "List current file Bookmarks",
      },
      ["mD"] = "<cmd>normal mx<cr>",

      -- portal
      ["<c-o>"] = [[<cmd>lua require("portal").jump_backward()<cr>]],
      ["<c-i>"] = [[<cmd>lua require("portal").jump_forward()<cr>]],

      -- Lighspeed
      -- ["s"] = { "<Plug>Lightspeed_s" },
      -- ["S"] = { "<Plug>Lightspeed_S" },

      -- Leap
      ["s"] = { "<Plug>(leap-forward-to)" },
      ["ss"] = { "<Plug>(leap-forward-till)" },
      ["S"] = { "<Plug>(leap-backward-to)" },
      ["SS"] = { "<Plug>(leap-backward-till)" },
      ["gs"] = "<Plug>(leap-cross-window)",
      ["sp"] = { "<cmd>lua require('user.configs.leap').paranormal()<cr>" },

      -- Navigate buffers
      -- ["<leader><tab>"] = { "<cmd>bNext<cr>" },
      -- ["<leader><S-tab>"] = { "<cmd>bprevious<cr>" },

      -- Jump by paragraph
      -- ["<C-k>"] = { "<S-{>" },
      -- ["<C-j>"] = { "<S-}>" },

      -- Navigator
      ["<C-h>"] = { "<CMD>NavigatorLeft<CR>" },
      ["<C-l>"] = { "<CMD>NavigatorRight<CR>" },
      ["<C-k>"] = { "<CMD>NavigatorUp<CR>" },
      ["<C-j>"] = { "<CMD>NavigatorDown<CR>" },
      -- ["<C-p>"] = { "<CMD>NavigatorPrevious<CR>" },

      -- quickfix
      -- ["<C-n>"] = { "<CMD>:cn<CR>" },
      -- ["<C-p>"] = { "<CMD>:cp<CR>" },

      -- multiple Cursor
      ["<C-n>"] = "<Nop>",
      ["<C-p>"] = "<Nop>",
      ["<M-n>"] = { "<Plug>(VM-Add-Cursor-Down)" },
      ["<M-p>"] = { "<Plug>(VM-Add-Cursor-up)" },

      -- toggle term
      ["\\"] = "<Nop>",
      ["\\\\"] = { "<cmd>ToggleTermToggleAll<cr>" },

      -- search google
      -- ["<leader>sw"] = { ":BrowserSearch<cr>" },
      -- EasyAlign
      -- ["ga"] = { "<Plug>(EasyAlign)" },
      -- Markdown bullets
      -- ["=q"] = function()
      --   local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
      --   local action = qf_winid > 0 and "cclose" or "copen"
      --   vim.cmd("botright " .. action)
      -- end,
      -- ["=l"] = function()
      --   local win = vim.api.nvim_get_current_win()
      --   local qf_winid = vim.fn.getloclist(win, { winid = 0 }).winid
      --   local action = qf_winid > 0 and "lclose" or "lopen"
      --   vim.cmd(action)
      -- end,

      -- treesj
      ["gS"] = { "<cmd>TSJSplit<cr>" },
      ["gJ"] = { "<cmd>TSJJoin<cr>" },
    },
    i = {
      -- ["i"] = { "i" },
      -- ["f"] = { "f" },
    },
    v = {
      ["<S-l>"] = { "$", desc = "Jump to end of line" },
      ["<S-h>"] = { "^", desc = "Jump to the begging of line" },
      -- Stay in indent mode
      ["<"] = { "<gv", desc = "Move left" },
      [">"] = { "gv>", desc = "Move right" },
      ["p"] = { '"_dP' },
      -- inflect
      -- ["gI"] = { "<Plug>(Inflect)" },
      -- search google
      -- ["<leader>sg"] = { ":BrowserSearch<cr>" },

      -- Leap
      ["s"] = { "<Plug>(leap-forward-to)" },
      ["ss"] = { "<Plug>(leap-forward-till)" },
      ["S"] = { "<Plug>(leap-backward-to)" },
      ["SS"] = { "<Plug>(leap-backward-till)" },
    },
    x = {
      -- Move text up and down
      ["J"] = { ":move '>+1<CR>gv-gv" },
      ["K"] = { ":move '<-2<CR>gv-gv" },
      -- ["A-j"] = { ":move '>+1<CR>gv-gv" },
      -- ["A-k"] = { ":move '<-2<CR>gv-gv" },
      -- EasyAlign
      -- ["ga"] = { "<Plug>(EasyAlign)" },
    },
    t = {
      --ToggleTerm
      ["\\\\"] = { "<cmd>ToggleTermToggleAll<cr>" },
    },

    -- function M.set_terminal_keymaps()
    --   local opts = { buffer = 0 }
    --   vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    --   vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
    --   vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    --   vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    --   vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    --   vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    -- end
  }

  -- local smart_splits = require("user.core.utils").load_module("smart-splits")
  --
  -- if smart_splits then
  --   map.n["<M-Up>"] = { "<cmd>lua require'smart-splits'.resize_up(2)<cr>" }
  --   map.n["<M-Down>"] = { "<cmd>lua require'smart-splits'.resize_down(2)<cr>" }
  --   map.n["<M-Left>"] = { "<cmd>lua require'smart-splits'.resize_left(2)<cr>" }
  --   map.n["<M-Right>"] = { "<cmd>lua require'smart-splits'.resize_right(2)<cr>" }
  -- end
  return map
end

return M
