local M = {}

function M.init()
  vim.g.calendar_mark = "left-fit"
  vim.g.calendar_weeknm = 4
  vim.g.calendar_diary = vim.env.ZK_NOTEBOOK_DIR .. "/journal/daily"
end

function M.show(args)
  local opts = args or {}
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

return M
