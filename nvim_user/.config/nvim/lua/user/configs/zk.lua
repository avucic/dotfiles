local M = {}
local journal_dir = vim.env.ZK_NOTEBOOK_DIR .. "/Journal/Daily"

local function create_commands()
  vim.api.nvim_create_user_command("ZkShowCalendar", M.show_calendar, { desc = "Open calendar" })
  vim.api.nvim_create_user_command("ZkOpenNotebook", M.open_notebook, { desc = "Open notebook" })
  vim.api.nvim_create_user_command("ZkGrep", M.grep_notes, { desc = "Search for notes" })
  vim.api.nvim_create_user_command("ZkFindOrCreateNote", function(opts)
    local args = load("return " .. opts.args)()
    assert(args.group ~= nil, "Missing group argument")
    assert(args.dir ~= nil, "Missing dir argument")
    M.find_or_create_note(args)
  end, {
    nargs = "?",
    desc = "Open or create node",
    complete = "lua",
    -- complete = function()
    --   -- return system("git branch --sort=-committerdate --format='%(refname:short)'") ?
    --   return { "Permanent Notes", "Fleeting Notes", "Literature Notes" }
    -- end,
  })

  vim.api.nvim_create_user_command("ZkFindOrCreateJournalDailyNote", function()
    local opts = {}
    opts.date = os.date("%Y-%m-%d")
    opts.group = "journal"
    opts.dir = "journal/daily"
    opts.title = opts.date
    M.find_or_create_note_without_picker(opts)
  end, { desc = "Create today journal note" })

  vim.api.nvim_create_user_command("ZkFindOrCreateProjectNote", function()
    M.find_or_create_project_note()
  end, { desc = "Create today journal note" })
end

function M.grep_notes()
  require("user.configs.zk.note").grep_notes({ dir = journal_dir })
end

function M.open_notebook()
  require("user.configs.zk.note").open_notebook()
end

function M.find_or_create_note(opts)
  require("user.configs.zk.note").find_or_create_note(opts)
end

function M.find_or_create_note_without_picker(opts)
  require("user.configs.zk.note").find_or_create_note_without_picker(opts)
end

function M.find_or_create_project_note()
  require("user.configs.zk.note").find_or_create_project_note()
end

function M.show_calendar()
  require("user.configs.zk.calendar").show({ dir = journal_dir })
end

function M.setup()
  require("user.configs.zk.calendar").setup({ dir = journal_dir })
end

function M.config()
  local zk = require("user.core.utils").load_module("zk")
  if not zk then
    return {}
  end

  zk.setup({
    -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
    -- it's recommended to use "telescope" or "fzf"
    picker = "telescope",

    lsp = {
      -- `config` is passed to `vim.lsp.start_client(config)`
      config = {
        cmd = { "zk", "lsp" },
        name = "zk",
        on_attach = function(bufnr)
          -- TODO: it's note triggered. This mappings are defined in autocmds
          -- vim.keymap.set("n", "<cr>", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Declaration" })
          -- vim.keymap.set("n", "<bs>", ":ZkBacklinks<cr>", { buffer = bufnr, desc = "Back links" })
        end,
      },

      -- automatically attach buffers in a zk notebook that match the given filetypes
      auto_attach = {
        enabled = true,
        filetypes = { "markdown" },
      },
    },
  })

  create_commands()
  local commands = require("zk.commands")

  commands.add("ZkOrphans", function(options)
    options = vim.tbl_extend("force", { orphan = true }, options or {})
    zk.edit(options, { title = "Zk Orphans" })
  end)
end

return M
