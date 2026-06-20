## Plugins & features

| Feature | File | Details |
|---|---|---|
| Formatters | formatting.lua | prettier (JS/TS/JSON/CSS/HTML/MD/YAML), rubocop (Ruby via bundle exec), rustfmt |
| nvim-lint | formatting.lua | rubocop linter auto-runs on save/read/insert-leave |
| mini.bufremove | ui.lua | bq/bQ/bC/bO/bD all use smart close — keeps splits open |
| Trouble | ui.lua | `<Leader>qq` doc, `<Leader>qw` workspace, `<Leader>qQ` qflist, `<Leader>ql` loclist, `<Leader>qr` references |
| Aerial | ui.lua | `<Leader>la` toggle outline, `{`/`}` prev/next symbol in buffer |
| git-conflict | git.lua | `<Leader>gco/t/b/0` choose ours/theirs/both/none, `]x`/`[x` navigate |
| vim-illuminate | editing.lua | automatic word highlighting, `]]`/`[[` next/prev reference |
| Glance | lsp.lua | `gd` peek definition, `gD` peek declaration, `gpi` implementations, `gpy` type definition |
| persistence.nvim | session.lua | `<Leader>Ss` save, `<Leader>Sl` load cwd, `<Leader>Sr` restore last, `<Leader>Sd` stop |
| neo-tree | file_explorer.lua | `<Leader>E` toggle sidebar, width=30, follows current file |

---

## Per-project config (`.nvim.lua`)

Create a `.nvim.lua` file in any project root. Neovim loads it automatically via `exrc`.
LSP completions and type hints work inside `.nvim.lua` for any project that has one (lazydev activates automatically).

Optionally, create `.nvim.devcontainer.lua` alongside it — loaded only inside Docker containers or remote-ui. Use the same `require('project').setup({})` API; it merges with `.nvim.lua`.

```lua
-- .nvim.lua
require('project').setup({
  -- CodeCompanion AI adapter ('anthropic', 'gemini', 'openai', …)
  ai_adapter = 'anthropic',

  -- Branch used by <Leader>gO (git browse main)
  git_browse_main_branch = 'main',

  -- Disable conform format-on-save for this project
  disable_format_on_save = true,

  -- Override formatters per filetype
  formatters = {
    javascript      = { 'prettierd' },
    typescript      = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    typescriptreact = { 'prettierd' },
  },

  -- Override linters per filetype
  linters = {
    javascript = { 'eslint_d' },
  },

  lsp = {
    -- Enable servers that automatic_enable doesn't cover (no mason-lspconfig mapping)
    -- e.g. eslint: Mason package is 'eslint-lsp' but mason-lspconfig has no entry for it
    enable = { 'eslint' },

    -- Disable globally-started servers for this project
    disable = { 'ts_ls' },

    -- Keep server running but strip formatting capability
    disable_formatting = { 'vtsls', 'eslint' },

    -- Per-server settings merged via vim.lsp.config()
    servers = {
      ts_ls = {
        settings = { typescript = { inlayHints = { enabled = 'all' } } },
      },
    },
  },

  -- Mason tools to auto-install
  mason_tools = { 'prettierd', 'eslint-lsp' },
})
```

### LSP — how servers start

All Mason-installed servers with a mason-lspconfig mapping start automatically (`automatic_enable = true`). Their `root_dir` scopes when they actually attach — e.g. `ts_ls` only attaches if a `tsconfig.json` or `package.json` is found.

Use `lsp.enable` only for servers **without** a mason-lspconfig mapping (e.g. `eslint` — Mason package `eslint-lsp` has no mason-lspconfig entry).

### How it works

| Key | Consumed by | Timing |
|---|---|---|
| `ai_adapter` | `plugins/ai.lua` | on CodeCompanion load |
| `git_browse_main_branch` | `config/keymaps.lua` | on keymap trigger |
| `disable_format_on_save` | `plugins/formatting.lua` | on each BufWritePre |
| `formatters` | `project` → conform | VimEnter or LazyLoad |
| `linters` | `project` → nvim-lint | VimEnter or LazyLoad |
| `lsp.enable` | `project` → FileType autocmd + `vim.lsp.start()` | VimEnter |
| `lsp.disable` | `project` → `client:stop()` + LspAttach guard | VimEnter |
| `lsp.disable_formatting` | `project` → LspAttach | VimEnter |
| `lsp.servers` | `project` → `vim.lsp.config()` | VimEnter |
| `mason_tools` | `project` → mason-registry | VimEnter |
