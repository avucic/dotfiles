-- function Edit(fn, line_number)
--   local edit_cmd = string.format(":e %s", fn)
--   if line_number ~= nil then
--     edit_cmd = string.format(":e +%d %s", line_number, fn)
--   end
--   vim.cmd(edit_cmd)
-- end

-- function Rename(file)
--   vim.cmd("bdelete!")
--   vim.cmd("edit " .. vim.fn.readfile(file)[1])
-- end

-- function Delete(file)
--   vim.cmd([[BWnex]])
-- end
