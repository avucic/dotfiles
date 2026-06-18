local M = {}

function M.setup()
  vim.api.nvim_create_user_command('OpenFile', function()
    vim.cmd("execute ':silent ! open " .. vim.fn.expand('%') .. "'")
    vim.cmd("execute ':redraw!'")
  end, { desc = 'Open file with system default application' })

  vim.api.nvim_create_user_command('OpenFolderInFinder', function()
    vim.cmd("execute ':silent ! open " .. vim.fn.expand('%:h') .. "'")
    vim.cmd("execute ':redraw!'")
  end, { desc = 'Open folder in Finder' })
end

return M
