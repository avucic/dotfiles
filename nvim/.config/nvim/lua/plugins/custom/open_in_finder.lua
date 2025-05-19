local M = {}

function M.setup(opts)
  vim.api.nvim_create_user_command("OpenFile", function()
    -- vim.cmd([[execute ':silent !'.<q-args> | execute ':redraw!']])
    vim.cmd("execute ':silent ! open " .. vim.fn.expand "%" .. "'")
    vim.cmd "execute ':redraw!'"
  end, { desc = "Open file with system default application" })

  vim.api.nvim_create_user_command("OpenFolderInFinder", function()
    -- vim.cmd([[execute ':silent !'.<q-args> | execute ':redraw!']])
    vim.cmd("execute ':silent ! open " .. vim.fn.expand "%:h" .. "'")
    vim.cmd "execute ':redraw!'"
  end, { desc = "Open file in finder" })
end

return M
