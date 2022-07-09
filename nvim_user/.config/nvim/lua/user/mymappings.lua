local M = {}
function M.config()
  local set = vim.opt
  local opts = { noremap = true, silent = true }
  local map = vim.api.nvim_set_keymap

  -- Set options
  set.relativenumber = true
  set.foldlevel = 20
  set.foldcolumn = "auto:9"
  set.fillchars = {
    vert = "▕",
    fold = " ",
    eob = " ",
    diff = "─",
    msgsep = "‾",
    foldopen = "▾",
    foldclose = "▸",
    foldsep = "│",
  }

  map("n", "<A-j>", "<Nop>", opts)
  map("n", "<A-k>", "<Nop>", opts)
  map("n", "<leader>d", "<Nop>", opts)
  map("n", "<leader>/", "<Nop>", opts)
  map("i", "i", "i", opts)
  map("i", "f", "f", opts)
  map("n", "<leader>o", "<Nop>", opts)
  map("n", "<leader>gg", "<Nop>", opts)
  -- Better window navigation
  map("n", "<C-h>", "<cmd>lua require'smart-splits'.move_cursor_left()<cr>", opts)
  map("n", "<C-j>", "<cmd>lua require'smart-splits'.move_cursor_down()<cr>", opts)
  map("n", "<C-k>", "<cmd>lua require'smart-splits'.move_cursor_up()<cr>", opts)
  map("n", "<C-l>", "<cmd>lua require'smart-splits'.move_cursor_right()<cr>", opts)

  map("n", "<M-Up>", "<cmd>lua require'smart-splits'.resize_up(2)<cr>", opts)
  map("n", "<M-Down>", "<cmd>lua require'smart-splits'.resize_down(2)<cr>", opts)
  map("n", "<M-Left>", "<cmd>lua require'smart-splits'.resize_left(2)<cr>", opts)
  map("n", "<M-Right>", "<cmd>lua require'smart-splits'.resize_right(2)<cr>", opts)
  map("n", "<M-Right>", "<cmd>lua require'smart-splits'.resize_right(2)<cr>", opts)

  map("n", "<esc>", "<cmd>silent! cclose<cr>", opts)

  -- Set key bindings
  -- Normal --
  map("n", "<c-q>", ":qall<cr>", opts)

  -- bookmarks
  map("n", "mm", ":BookmarkToggle<cr>", opts)
  map("n", "ma", ":lua require('telescope').extensions.vim_bookmarks.all()<cr>", opts)
  map("n", "mf", ":lua require('telescope').extensions.vim_bookmarks.current_file()<cr>", opts)

  -- G
  -- map("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  -- map("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- Z
  map("n", "z=", "<cmd>Telescope spell_suggest<CR>", opts)

  map("n", "<S-l>", "$", opts)
  map("n", "<S-h>", "^", opts)
  map("v", "<S-l>", "$", opts)
  map("v", "<S-h>", "^", opts)

  -- Move text up and down
  -- map("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
  -- map("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

  -- Insert --
  -- Press jk fast to enter
  -- map("i", "jk", "<ESC>", opts)

  -- Visual --
  -- Stay in indent mode
  map("v", "<", "<gv", opts)
  map("v", ">", ">gv", opts)

  -- Move text up and down
  map("v", "<A-j>", ":m .+1<CR>==", opts)
  map("v", "<A-k>", ":m .-2<CR>==", opts)
  map("v", "p", '"_dP', opts)

  -- Visual Block --
  -- Move text up and down
  map("x", "J", ":move '>+1<CR>gv-gv", opts)
  map("x", "K", ":move '<-2<CR>gv-gv", opts)
  map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
  map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

  map("n", "<esc><esc>", "<cmd>nohlsearch<cr>", opts)
  -- map("n", "Q", "<cmd>Bdelete!<CR>", opts)
  map("n", "<S-q>", "qall!", opts)
  map("n", "s", "<Plug>Lightspeed_s", opts)
  map("n", "S", "<Plug>Lightspeed_S", opts)
  vim.cmd([[vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>]])

  -- Navigate buffers
  map("n", "<leader><tab>", "<cmd>bNext<cr>", opts)
  map("n", "<leader><S-tab>", "<cmd>bprevious<cr>", opts)

  -- Navigator
  map("n", "<C-h>", "<CMD>NavigatorLeft<CR>", opts)
  map("n", "<C-l>", "<CMD>NavigatorRight<CR>", opts)
  map("n", "<C-k>", "<CMD>NavigatorUp<CR>", opts)
  map("n", "<C-j>", "<CMD>NavigatorDown<CR>", opts)
  map("n", "<C-p>", "<CMD>NavigatorPrevious<CR>", opts)

  -- quickfix
  map("n", "<C-n>", "<CMD>:cn<CR>", opts)
  map("n", "<C-p>", "<CMD>:cp<CR>", opts)

  -- multiple Cursor
  map("n", "<M-n>", "<Plug>(VM-Add-Cursor-Down)", opts)
  map("n", "<M-p>", "<Plug>(VM-Add-Cursor-up)", opts)

  -- inflect
  map("v", "gI", "<Plug>(Inflect)", opts)

  local smart_splits = require("user.core.utils").load_module("smart-splits")

  if smart_splits then
    vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
    vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
    vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
    vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
  end
  -- moving between splits
  -- vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
  -- vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
  -- vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
  -- vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

  -- toggle term
  map("n", [[<c-\>]], "<cmd>ToggleTermToggleAll<cr>", opts)
  map("t", [[<c-\>]], "<cmd>ToggleTermToggleAll<cr>", opts)

  -- search google
  map("n", "<leader>sg", ":BrowserSearch<cr>", opts)
  map("v", "<leader>sg", ":BrowserSearch<cr>", opts)

  -- command line
  vim.cmd([[
    cnoremap <C-A> <Home>
	  cnoremap <C-F> <Right>
	  cnoremap <C-B> <Left>
    ]])

  -- Set autocommands
  -- vim.cmd [[
  --   augroup packer_conf
  --     autocmd!
  --     autocmd bufwritepost init.lua source <afile> | PackerSync
  --   augroup end
  -- ]]
end

return M
