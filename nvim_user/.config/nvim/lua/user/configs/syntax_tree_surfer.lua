local M = {}

function M.config()
  local sts = require("user.core.utils").load_module("syntax-tree-surfer")
  if not sts then
    return {}
  end

  sts.setup({
    highlight_group = "STS_highlight",
  })
  -- -- Syntax Tree Surfer
  -- local opts = { noremap = true, silent = true }
  --
  -- -- Normal Mode Swapping:
  -- -- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
  -- vim.keymap.set("n", "vU", function()
  --   vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
  --   return "g@l"
  -- end, { silent = true, expr = true })
  -- vim.keymap.set("n", "vD", function()
  --   vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
  --   return "g@l"
  -- end, { silent = true, expr = true })
  --
  -- -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
  -- vim.keymap.set("n", "vd", function()
  --   vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
  --   return "g@l"
  -- end, { silent = true, expr = true })
  --
  -- vim.keymap.set("n", "vu", function()
  --   vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
  --   return "g@l"
  -- end, { silent = true, expr = true })
  -- --> If the mappings above don't work, use these instead (no dot repeatable)
  -- -- vim.keymap.set("n", "vd", '<cmd>STSSwapCurrentNodeNextNormal<cr>', opts)
  -- -- vim.keymap.set("n", "vu", '<cmd>STSSwapCurrentNodePrevNormal<cr>', opts)
  -- -- vim.keymap.set("n", "vD", '<cmd>STSSwapDownNormal<cr>', opts)
  -- -- vim.keymap.set("n", "vU", '<cmd>STSSwapUpNormal<cr>', opts)
  --
  -- -- Visual Selection from Normal Mode
  -- vim.keymap.set("n", "vx", "<cmd>STSSelectMasterNode<cr>", opts)
  -- vim.keymap.set("n", "vn", "<cmd>STSSelectCurrentNode<cr>", opts)
  --
  -- -- Select Nodes in Visual Mode
  -- vim.keymap.set("x", "J", "<cmd>STSSelectNextSiblingNode<cr>", opts)
  -- vim.keymap.set("x", "K", "<cmd>STSSelectPrevSiblingNode<cr>", opts)
  -- vim.keymap.set("x", "H", "<cmd>STSSelectParentNode<cr>", opts)
  -- vim.keymap.set("x", "L", "<cmd>STSSelectChildNode<cr>", opts)
  --
  -- -- Swapping Nodes in Visual Mode
  -- vim.keymap.set("x", "<A-j>", "<cmd>STSSwapNextVisual<cr>", opts)
  -- vim.keymap.set("x", "<A-k>", "<cmd>STSSwapPrevVisual<cr>", opts)
  --
  -- -- Syntax Tree Surfer V2 Mappings
  -- -- Targeted Jump with virtual_text
  -- vim.keymap.set("n", "gv", function() -- only jump to variable_declarations
  --   sts.targeted_jump({ "variable_declaration" })
  -- end, opts)
  -- vim.keymap.set("n", "gfu", function() -- only jump to functions
  --   sts.targeted_jump({ "function", "arrrow_function", "function_definition" })
  --   --> In this example, the Lua language schema uses "function",
  --   --  when the Python language uses "function_definition"
  --   --  we include both, so this keymap will work on both languages
  -- end, opts)
  -- vim.keymap.set("n", "gif", function() -- only jump to if_statements
  --   sts.targeted_jump({ "if_statement" })
  -- end, opts)
  -- vim.keymap.set("n", "gfo", function() -- only jump to for_statements
  --   sts.targeted_jump({ "for_statement" })
  -- end, opts)
  -- vim.keymap.set("n", "gj", function() -- jump to all that you specify
  --   sts.targeted_jump({
  --     "function",
  --     "if_statement",
  --     "else_clause",
  --     "else_statement",
  --     "elseif_statement",
  --     "for_statement",
  --     "while_statement",
  --     "switch_statement",
  --   })
  -- end, opts)
end

return M
