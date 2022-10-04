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

      ["<leader>P"] = false,
      ["<leader>p"] = false,
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
      -- ["<C-h>"] = false,
      -- ["<C-l>"] = false,

      -- ["<leader>e"] = { "<cmd>lua require'mind'.close()<cr><cmd>Neotree toggle<cr>" },

      ["<c-q>"] = { "<cmd>silent! cclose<cr><cmd>nohlsearch<cr><cmd>ToggleTermToggleAll<cr>" },
      ["<esc>"] = { "<cmd>nohlsearch<cr>" },
      ["<esc><esc>"] = { "<cmd>nohlsearch<cr>" },
      ["Q"] = { "<cmd>qall!<cr>" },
      ["<S-l>"] = { "$" },
      ["<S-h>"] = { "^" },
      ["z="] = { "<cmd>Telescope spell_suggest<CR>" },
      ["<leader>W"] = { "<cmd>:noa w<cr>" },

      -- Bookmarks
      ["mm"] = { ":BookmarkToggle<cr>" },
      ["ma"] = { ":lua require('telescope').extensions.vim_bookmarks.all()<cr>", desc = "List all Bookmarks" },
      ["mf"] = {
        ":lua require('telescope').extensions.vim_bookmarks.current_file()<cr>",
        desc = "List current file Bookmarks",
      },
      -- Lighspeed
      ["s"] = { "<Plug>Lightspeed_s" },
      ["S"] = { "<Plug>Lightspeed_S" },

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
      -- ["<M-n>"] = { "<Plug>(VM-Add-Cursor-Down)" },
      -- ["<M-p>"] = { "<Plug>(VM-Add-Cursor-up)" },

      -- toggle term
      ["<c-\\>"] = { "<cmd>ToggleTermToggleAll<cr>" },

      -- search google
      -- ["<leader>sg"] = { ":BrowserSearch<cr>" },
      -- EasyAlign
      -- ["ga"] = { "<Plug>(EasyAlign)" },
      -- Markdown bullets
    },
    i = {
      ["i"] = { "i" },
      ["f"] = { "f" },
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
      ["<c-\\>"] = { "<cmd>ToggleTermToggleAll<cr>" },
    },
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
