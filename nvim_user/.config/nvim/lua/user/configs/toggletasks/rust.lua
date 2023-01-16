local M = {}

function M.config()
  return {
    {
      name = "Test workspace",
      cmd = "cargo test",
      close_on_exit = false,
      -- tags = { "ruby" },
    },
    {
      name = "Watch",
      cmd = "cargo watch -x run",
      close_on_exit = false,
      -- tags = { "ruby" },
    },
    {
      name = "Check",
      cmd = "cargo check",
      close_on_exit = false,
      -- tags = { "ruby" },
    },
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
    {
      name = "Test",
      cmd = "cargo test",
      close_on_exit = false,
      -- tags = { "ruby" },
    },
  }
end

return M
