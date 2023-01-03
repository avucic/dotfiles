local M = {}

function M.config()
  return {
    {
      name = "Start Rails debug server",
      cmd = "rdbg --open --port 12345  --stop-at-load --nonstop --command -- bundle exec rails s",
      close_on_exit = false,
      -- tags = { "ruby" },
    },
    {

      name = "Start Rails server",
      cmd = "bundle exec rails server",
      close_on_exit = false,
      -- tags = { "ruby" },
    },
  }
end

return M
