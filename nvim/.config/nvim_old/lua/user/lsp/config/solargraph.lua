local cmd = { "bundle", "exec", "solargraph", "stdio" }
local bundle_gemfile = os.getenv("BUNDLE_GEMFILE") or "~/.config/nvim/Gemfile"

return {
  init_options = {
    formatting = true,
  },
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
  cmd = cmd,
  cmd_env = {
    BUNDLE_GEMFILE = bundle_gemfile,
  },
}
