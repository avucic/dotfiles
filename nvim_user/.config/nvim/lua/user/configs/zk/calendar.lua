local M = {}

local zk = require("user.configs.zk")

function M.setup(opts)
  vim.g.calendar_diary = opts.dir

  vim.cmd([[
      " function! MyCalSign(day, month, year)
      "       return luaeval('require("telekasten").CalendarSignDay(_A[1], _A[2], _A[3])', [a:day, a:month, a:year])
      "   endfunction
        function! MyCalAction(day, month, year, weekday, dir)
            " day : day
            " month : month
            " year year
            " weekday : day of week (monday=1)
            " dir : direction of calendar
            return luaeval('require("user.configs.zk.calendar").calendar_action(_A[1], _A[2], _A[3], _A[4], _A[5])',
                                                                 \ [a:day, a:month, a:year, a:weekday, g:calendar_diary])
        endfunction
        function! MyCalBegin()
            " too early, windown doesn't exist yet
            " cannot resize
        endfunction
        " let g:calendar_sign = 'MyCalSign'
        let g:calendar_action = 'MyCalAction'
        " let g:calendar_begin = 'MyCalBegin'
        let g:calendar_mark = 'left-fit'
        let g:calendar_weeknm = 4
        ]])
end

function M.show(opts)
  opts.cmd = "CalendarVR"
  opts.vertical_resize = 1

  vim.cmd(opts.cmd)
  if opts.vertical_resize then
    vim.cmd("vertical resize +" .. opts.vertical_resize)
  end
  vim.cmd([[
      set signcolumn=no
      set nonumber
      set norelativenumber
      set hidden
    ]])
end

function M.calendar_action(day, month, year, _, dir)
  local opts = {}
  opts.date = string.format("%04d-%02d-%02d", year, month, day)
  opts.group = "journal"
  opts.dir = dir
  opts.title = opts.date

  zk.find_or_create_note_without_picker(opts)
end

return M