local M = {}
function M.config()
  local cmp = require("user.core.utils").load_module("cmp")

  if not cmp then
    return
  end

  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      -- { name = "cmdline_history", group_index = 1 },
      { name = "cmdline_history" },
      { name = "cmdline" },
    },
  })

  return {
    sources = {
      -- { name = "nvim_lsp" },
      -- { name = "luasnip" },
      -- { name = "buffer" },
      -- { name = "path" },
      -- { name = "cmp_tabnine" },
      { name = "emoji" },
      { name = "vsnip" },
      { name = "neorg" },
      { name = "spell" },
      { name = "crates" },
    },

    -- mapping = {
    --   ["<C-p>"] = cmp.mapping.select_prev_item(),
    --   ["<C-n>"] = cmp.mapping.select_next_item(),
    -- },
  }
end

return M
