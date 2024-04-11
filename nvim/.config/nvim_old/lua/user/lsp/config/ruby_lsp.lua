local cmd = { "bundle", "exec", "solargraph", "stdio" }
local bundle_gemfile = os.getenv("BUNDLE_GEMFILE") or "~/.config/nvim/Gemfile"

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

-- if not configs.ruby_lsp then
local enabled_features = {
  "documentHighlights",
  "documentSymbols",
  "foldingRanges",
  "selectionRanges",
  "diagnostics",
  -- "semanticHighlighting",
  "formatting",
  "codeActions",
}

-- configs.ruby_lsp = {
-- }
-- end

-- lspconfig.ruby_lsp.setup({ on_attach = on_attach, capabilities = capabilities })

return {
  cmd = { "bundle", "exec", "ruby-lsp" },
  filetypes = { "ruby" },
  root_dir = "~/.config/nvim/Gemfile",
  init_options = {
    -- enabledFeatures = enabled_features,
    -- formatting = true,
    -- formatter = "auto",
  },
  settings = {},
  -- settings = {
  --   solargraph = {
  --     -- autoformat = true,
  --     completion = true,
  --     diagnostic = true,
  --     -- folding = true,
  --     references = true,
  --     rename = true,
  --     symbols = true,
  --     -- useBundler = true,
  --     -- bundlerPath = os.getenv("HOME") .. "/.asdf/shims/bundle",
  --   },
  -- },
  -- cmd = cmd,
  -- cmd_env = {
  --   BUNDLE_GEMFILE = bundle_gemfile,
  -- },
}
