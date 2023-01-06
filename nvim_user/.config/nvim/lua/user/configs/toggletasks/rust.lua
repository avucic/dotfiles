local M = {}

function M.config()
  return {
    {
      name = "Build",
      cmd = "cargo build",
      close_on_exit = false,
      -- tags = { "ruby" },
    },
    {
      name = "Run",
      cmd = "cargo run",
      close_on_exit = false,
      -- tags = { "ruby" },
    },
  }
end

return M
