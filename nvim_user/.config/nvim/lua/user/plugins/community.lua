return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.code-runner.overseer-nvim" },
  { import = "astrocommunity.syntax.hlargs-nvim" },
  -- { import = "astrocommunity.test.neotest" },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
}
