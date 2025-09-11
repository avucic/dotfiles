local M = {}
local journal_dir = vim.env.ZK_NOTEBOOK_DIR .. "/journal/daily"

local function create_commands()
  vim.api.nvim_create_user_command("ZkOpenNotes", M.open_notes, { desc = "Open notes" })
  vim.api.nvim_create_user_command("ZkOpenNotebook", M.open_notebook, { desc = "Open notebook" })
  vim.api.nvim_create_user_command("ZkGrep", M.grep_notes, { desc = "Search for notes" })
  vim.api.nvim_create_user_command("ZkFindOrCreateNote", M.find_or_create_note, { desc = "Find or create note" })
  vim.api.nvim_create_user_command(
    "ZkFindOrCreateNoteFromVisualSelection",
    M.find_or_create_note_from_selection,
    { desc = "Find or create note", range = true, nargs = "?", force = true, complete = "lua" }
  )
  vim.api.nvim_create_user_command("ZkFindOrCreateJournalDailyNote", function()
    local opts = {}
    opts.date = os.date "%d-%m-%Y"
    opts.group = "journal"
    opts.dir = "journal/daily"
    opts.title = opts.date
    M.find_or_create_note_without_picker(opts)
  end, { desc = "Create today journal note" })
end

function M.grep_notes() require("plugins.custom.zk.note").grep_notes { dir = vim.env.ZK_NOTEBOOK_DIR } end

function M.open_notebook() require("plugins.custom.zk.note").open_notebook() end

function M.find_or_create_note(opts) require("plugins.custom.zk.note").pick_zk_group(opts) end
function M.find_or_create_note_from_selection(opts) require("plugins.custom.zk.note").pick_zk_group(opts) end

function M.find_or_create_note_without_picker(opts)
  require("plugins.custom.zk.note").find_or_create_note_without_picker(opts)
end

function M.open_notes() require("plugins.custom.zk.note").open_notes() end

function M.init()
  vim.cmd [[
        function! OpenJournalNote(day, month, year, weekday, direction)
            " day : day

            " month : month
            " year year
            " weekday : day of week (monday=1)
            " dir : direction of calendar
            return luaeval('require("plugins.custom.zk").__open_journal_note(_A[1], _A[2], _A[3], _A[4], _A[5])',
                                                                 \ [a:day, a:month, a:year, a:weekday, a:direction])
        endfunction
        ]]
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
  require("plugins.custom.calendar").show { dir = journal_dir }
end

function M.config(_, opts)
  local zk = require "zk"

  zk.setup(opts)

  create_commands()
  local commands = require "zk.commands"

  commands.add("ZkOrphans", function(options)
    options = vim.tbl_extend("force", { orphan = true }, options or {})
    zk.edit(options, { title = "Zk Orphans" })
  end)
end

return M
