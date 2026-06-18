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
    typescript = { 'prettierd' },
  },

  -- Override linters per filetype
  linters = {
    javascript = { 'eslint_d' },
  },

  -- LSP tweaks
  lsp = {
    -- Strip formatting capability from these servers (so conform is used instead)
    disable_formatting = { 'ts_ls' },

    -- Per-server settings, merged via vim.lsp.config()
    servers = {
      ts_ls = {
        settings = { typescript = { inlayHints = { enabled = 'all' } } },
      },
    },
  },

  -- Extra Mason tools to auto-install when opening this project
  mason_tools = { 'prettierd', 'eslint-lsp' },

  -- Extra LSP servers to enable (must have a built-in or lsp/<name>.lua config)
  lsp_servers = { 'eslint' },
})
```

### How it works

| Key | Consumed by | Timing |
|---|---|---|
| `ai_adapter` | `plugins/ai.lua` | on CodeCompanion load |
| `git_browse_main_branch` | `config/keymaps.lua` | on keymap trigger |
| `disable_format_on_save` | `plugins/formatting.lua` | on each BufWritePre |
| `lsp.disable_formatting` | `config/autocmds.lua` | on each LspAttach |
| `lsp.servers` | `project` → `vim.lsp.config()` | VimEnter |
| `lsp_servers` | `project` → `vim.lsp.enable()` | VimEnter |
| `mason_tools` | `project` → mason-tool-installer | VimEnter |
| `formatters` | `project` → conform | VimEnter or LazyLoad |
| `linters` | `project` → nvim-lint | VimEnter or LazyLoad |
