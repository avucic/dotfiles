local M = {}

function M.setup()
  vim.api.nvim_create_user_command("PickDate", M.open_calendar, { desc = "Open calendar" })

  vim.cmd [[
        function! InsertDate(day, month, year, weekday, direction)
            " day : day
            " month : month
            " year year
            " weekday : day of week (monday=1)
            " dir : direction of calendar
            " wincmd p
            " exe "normal! a" . "FFFFFF" . "\<Esc>"
            " execute "normal! i\<C-r>\<C-r>=text\<CR>\<Esc>"
            return luaeval('require("user.plugins.date_picker").pick_date(_A[1], _A[2], _A[3], _A[4], _A[5])',
                                                                 \ [a:day, a:month, a:year, a:weekday, a:direction])
        endfunction
        ]]
end

function M.open_calendar()
  vim.g.calendar_action = "InsertDate"
  require("user.plugins.configs.calendar").show()
end

function M.pick_date(day, month, year, _, _)
  local date = os.time { year = year, month = month, day = day }
  local s = os.date("%d-%m-%Y", date)

  vim.cmd [[ q ]]
  vim.cmd [[ wincmd p ]]
  vim.cmd("exe 'normal! a " .. s .. "'")
end

return M
