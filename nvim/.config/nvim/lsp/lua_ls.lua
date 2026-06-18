-- Lua Language Server config
-- lazydev.nvim adds Neovim API completions automatically
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath('config') .. '/lua',
        },
      },
      completion = {
        callSnippet = 'Replace',
      },
      hint = { enable = true },
      telemetry = { enable = false },
    },
  },
}
