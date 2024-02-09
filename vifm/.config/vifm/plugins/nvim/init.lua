local send_to_nvim = function(cmd, path)
  -- local handle = io.popen("nvr --nostart --remote-silent -l " .. path)
  local handle = io.popen("nvr --nostart --remote-send 'lua " .. cmd .. "(" .. path .. ")'")
  local result = handle:read("*a")
  handle:close()
end

vifm.events.listen({
  event = "app.fsop",
  ---@param event vifm.events.FsopEvent
  handler = function(event)
    vifm.sb.info(event.op)
    if event.op == "move" then
      if event.totrash then
        -- send_to_nvim("Delete", event.target)
      elseif event.fromtrash then
        -- pass
      else
        send_to_nvim("Rename", event.target)
      end
      -- elseif event.op == "remove" then
      -- rm(event)
    end
  end,
})
return {}
