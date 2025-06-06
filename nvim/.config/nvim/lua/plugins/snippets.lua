return {
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      local vscode_snippets_path = vim.fn.expand "~/.config/nvim/snippets"
      local snip_loader = require "luasnip.loaders.from_vscode"

      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call

      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
      luasnip.filetype_extend("typescript", { "typescriptreact" })

      snip_loader.lazy_load {
        paths = { vscode_snippets_path },
        override = true,
      }
    end,
  },
}
