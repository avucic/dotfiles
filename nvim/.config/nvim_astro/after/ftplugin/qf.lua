vim.keymap.set("n", "<Leader>qe", function()
  local qf = vim.fn.getqflist()
  local lines = {}

  for _, item in ipairs(qf) do
    table.insert(lines, string.format("%s:%d:%d: %s", vim.fn.bufname(item.bufnr), item.lnum, item.col, item.text))
  end

  vim.fn.writefile(lines, "quickfix.txt")
  print "Quickfix exported to quickfix.txt"
end, { desc = "Export quickfix to file" })
