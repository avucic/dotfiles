local M = {}

function M.config()
  return {
    {
      name = "Ginkgo test file",
      cmd = 'cd ${file:h} && ginkgo --focus-file "${file:t}"',
      close_on_exit = false,
    },
    {
      name = "Ginkgo test case",
      cmd = 'cd ${file:h} && ginkgo --focus-file "${file:t}:${cursor_line}"',
      close_on_exit = false,
    },
  }
end

return M
