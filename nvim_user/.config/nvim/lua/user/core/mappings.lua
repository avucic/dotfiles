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
      ["<A-j>"] = { "<Nop>" },
      ["<A-k>"] = { "<Nop>" },
      ["<leader>d"] = { "<Nop>" },
      ["<leader>/"] = { "<Nop>" },
      ["<leader>o"] = { "<Nop>" },
      ["<leader>gg"] = { "<Nop>" },
      ["q"] = { "<cmd>silent! cclose<cr><cmd>nohlsearch<cr>" },
      ["<esc>"] = { "<cmd>nohlsearch<cr>" },
      ["<esc><esc>"] = { "<cmd>nohlsearch<cr>" },
      ["<c-q>"] = { "<cmd>qall<cr>" },
      ["Q"] = { "<cmd>qall!<cr>" },
      ["<S-l>"] = { "$" },
      ["<S-h>"] = { "^" },
      ["z="] = { "<cmd>Telescope spell_suggest<CR>" },
      ["<leader>W"] = { "<cmd>:noa w<cr>" },
      -- Better window navigation
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
      ["<leader><tab>"] = { "<cmd>bNext<cr>" },
      ["<leader><S-tab>"] = { "<cmd>bprevious<cr>" },

      -- Navigator
      ["<C-h>"] = { "<CMD>NavigatorLeft<CR>" },
      ["<C-l>"] = { "<CMD>NavigatorRight<CR>" },
      ["<C-k>"] = { "<CMD>NavigatorUp<CR>" },
      ["<C-j>"] = { "<CMD>NavigatorDown<CR>" },
      ["<C-p>"] = { "<CMD>NavigatorPrevious<CR>" },

      -- quickfix
      -- ["<C-n>"] = { "<CMD>:cn<CR>" },
      -- ["<C-p>"] = { "<CMD>:cp<CR>" },

      -- multiple Cursor
      ["<M-n>"] = { "<Plug>(VM-Add-Cursor-Down)" },
      ["<M-p>"] = { "<Plug>(VM-Add-Cursor-up)" },

      -- toggle term
      ["<c-\\>"] = { "<cmd>ToggleTermToggleAll<cr>" },

      -- search google
      ["<leader>sg"] = { ":BrowserSearch<cr>" },
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
      ["gI"] = { "<Plug>(Inflect)" },
      -- search google
      ["<leader>sg"] = { ":BrowserSearch<cr>" },
    },
    x = {
      -- Move text up and down
      ["J"] = { ":move '>+1<CR>gv-gv" },
      ["K"] = { ":move '<-2<CR>gv-gv" },
      ["A-j"] = { ":move '>+1<CR>gv-gv" },
      ["A-k"] = { ":move '<-2<CR>gv-gv" },
    },
    t = {
      ["<c-\\>"] = { "<cmd>ToggleTermToggleAll<cr>" },
    },
  }

  local smart_splits = require("user.core.utils").load_module("smart-splits")

  if smart_splits then
    map.n["<M-Up>"] = { "<cmd>lua require'smart-splits'.resize_up(2)<cr>" }
    map.n["<M-Down>"] = { "<cmd>lua require'smart-splits'.resize_down(2)<cr>" }
    map.n["<M-Left>"] = { "<cmd>lua require'smart-splits'.resize_left(2)<cr>" }
    map.n["<M-Right>"] = { "<cmd>lua require'smart-splits'.resize_right(2)<cr>" }
  end
  return map
end

return M
