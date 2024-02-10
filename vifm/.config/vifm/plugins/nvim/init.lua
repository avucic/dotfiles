local fifo
local send_to_nvim
local path
local shell = {}

function shell.escape(args)
  local ret = {}
  for _, a in pairs(args) do
    s = tostring(a)
    if s:match("[^A-Za-z0-9_/:=-]") then
      s = "'" .. s:gsub("'", "'\\''") .. "'"
    end
    table.insert(ret, s)
  end
  return table.concat(ret, " ")
end

do
  path = os.getenv("NVIM_PIPE")

  function shell.run(args)
    local h = io.popen(shell.escape(args))
    local outstr = h:read("*a")
    return h:close(), outstr
  end

  function shell.execute(args)
    return os.execute(shell.escape(args))
  end
end

vifm.events.listen({
  event = "app.fsop",
  ---@param event vifm.events.FsopEvent
  handler = function(event)
    -- vifm.sb.info(event.op)
    if event.op == "move" then
      if event.totrash then
        -- send_to_nvim("Delete", event.target)
      elseif event.fromtrash then
        -- pass
      else
        if not event.isdir then
          shell.run({
            "nvr",
            "--servername",
            "/tmp/nvim.pipe",
            "--remote-silent",
            "-l",
            "--remote-send",
            ":lua Rename('" .. event.path .. "', '" .. event.target .. "')<cr>",
            -- ":lua _VIFM_TOGGLE()",
          })
        end
      end
      -- elseif event.op == "remove" then
      -- rm(event)
    end
  end,
})

return {}
