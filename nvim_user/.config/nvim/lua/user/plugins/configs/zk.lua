local M = {}
local journal_dir = vim.env.ZK_NOTEBOOK_DIR .. "/journal/daily"

local function create_commands()
  vim.api.nvim_create_user_command("ZkShowCalendar", M.show_calendar, { desc = "Open calendar" })
  vim.api.nvim_create_user_command("ZkOpenNotes", M.open_notes, { desc = "Open notes" })
  vim.api.nvim_create_user_command("ZkAnnotateTask", M.annotate_task, { desc = "Open notes" })
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
  require("user.configs.zk.note").grep_notes({ dir = vim.env.ZK_NOTEBOOK_DIR })
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

function M.open_notes()
  require("user.configs.zk.note").open_notes()
end

function M.annotate_task()
  require("user.configs.zk.note").annotate_task()
end

function M.init()
  vim.cmd([[
        function! OpenJournalNote(day, month, year, weekday, direction)
            " day : day

            " month : month
            " year year
            " weekday : day of week (monday=1)
            " dir : direction of calendar
            return luaeval('require("user.configs.zk").__open_journal_note(_A[1], _A[2], _A[3], _A[4], _A[5])',
                                                                 \ [a:day, a:month, a:year, a:weekday, a:direction])
        endfunction
        ]])
end

function M.__open_journal_note(day, month, year, _, _)
  local opts = {}
  opts.date = string.format("%04d-%02d-%02d", year, month, day)
  opts.group = "journal"
  opts.dir = vim.g.calendar_diary
  opts.title = opts.date

  M.find_or_create_note_without_picker(opts)
end

function M.show_calendar()
  vim.g.calendar_action = "OpenJournalNote"
  require("user.configs.calendar").show({ dir = journal_dir })
end

function M.config(_, opts)
  local zk = require("zk")

  zk.setup(opts)

  create_commands()
  local commands = require("zk.commands")

  commands.add("ZkOrphans", function(options)
    options = vim.tbl_extend("force", { orphan = true }, options or {})
    zk.edit(options, { title = "Zk Orphans" })
  end)
end

return M
