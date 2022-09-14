local M = {}

function M.setup()
  -- vim.g.bullets_set_mappings = 1
  -- vim.keymap.set("n", "<leader>x", "<Nop>", { noremap = true })
end

function M.config()
  -- call s:add_local_mapping(1, 'imap', '<cr>', '<Plug>(bullets-newline)')
  --   call s:add_local_mapping(1, 'inoremap', '<C-cr>', '<cr>')
  --
  --   call s:add_local_mapping(1, 'nmap', 'o', '<Plug>(bullets-newline)')
  --
  --   " Renumber bullet list
  --   call s:add_local_mapping(1, 'vmap', 'gN', '<Plug>(bullets-renumber)')
  --   call s:add_local_mapping(1, 'nmap', 'gN', '<Plug>(bullets-renumber)')
  --
  --   " Toggle checkbox
  --   call s:add_local_mapping(1, 'nmap', '<leader>x', '<Plug>(bullets-toggle-checkbox)')
  --
  --   " Promote and Demote outline level
  --   call s:add_local_mapping(1, 'imap', '<C-t>', '<Plug>(bullets-demote)')
  --   call s:add_local_mapping(1, 'nmap', '>>', '<Plug>(bullets-demote)')
  --   call s:add_local_mapping(1, 'vmap', '>', '<Plug>(bullets-demote)')
  --   call s:add_local_mapping(1, 'imap', '<C-d>', '<Plug>(bullets-promote)')
  --   call s:add_local_mapping(1, 'nmap', '<<', '<Plug>(bullets-promote)')
  --   call s:add_local_mapping(1, 'vmap', '<', '<Plug>(bullets-promote)')
  -- local map = vim.api.nvim_set_keymap

  -- vim.keymap.set("i", "<C-CR>", "<Plug>(bullets-newline)", { noremap = true })
  -- vim.keymap.set("i", "<CR>", "<Plug>(bullets-newline)", { noremap = false })
  -- vim.keymap.set("n", "o", "<Plug>(bullets-newline)", { noremap = true })
  -- vim.keymap.set("n", ">>", "<cmd>BulletDemote<cr>", { noremap = true })
  -- vim.keymap.set("n", "<<", "<cmd>BulletPromote<cr>", { noremap = true })
  -- vim.keymap.set("v", ">", "<cmd>BulletDemote<cr>", { noremap = true })
  -- vim.keymap.set("v", "<", "<cmd>BulletPromote<cr>", { noremap = true })

  -- vim.cmd([[imap <CR> <plug>(bullets-newline) ]])
  -- vim.cmd([[inoremap <C-CR> <plug>(bullets-newline) ]])

  -- map("v", "gN", "<cmd>RenumberSelection<cr>", { noremap = true })
  -- map("n", "gN", "<cmd>RenumberList<cr>", { noremap = true })
end

return M
