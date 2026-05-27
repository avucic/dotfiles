-- Clipboard for in-container nvim (remote-ui or `docker exec -it`).
-- No pbcopy / X display in the container, so copy via OSC 52.
--
-- Delivery: vim.api.nvim_ui_send() routes the escape to the attached UI
-- (host TUI client -> tmux -> iTerm2), so it works over remote-ui — unlike
-- io.stdout, which is a dead pipe for a headless server.
--
-- Inside tmux the OSC 52 is wrapped in a tmux passthrough (DCS) sequence, the
-- same wrapping that worked under `docker exec -it`. This forwards to the outer
-- terminal regardless of tmux's set-clipboard/Ms config. Requires
-- `set -g allow-passthrough on` in tmux (already set since the old script worked).
--
-- Paste is served from a local cache, NOT OSC 52 read: terminals usually block
-- clipboard reads and would hang ~1s+ per paste. To paste host-copied text, use
-- the terminal's own paste (Cmd+V / bracketed paste).

local function file_exists(name)
  local f = io.open(name, "r")
  if f then
    f:close()
    return true
  end
  return false
end

if file_exists "/.dockerenv" then
  local cache = { ["+"] = { {}, "v" }, ["*"] = { {}, "v" } }

  local function osc52_seq(reg, b64)
    local clip = reg == "+" and "c" or "p"
    local inner = string.format("\027]52;%s;%s\007", clip, b64)
    -- Always wrap in tmux passthrough (DCS + doubled ESCs). We can't detect tmux
    -- via $TMUX here: it's a host var and `docker exec` doesn't pass it into the
    -- container, so it's always nil in the remote server. This workflow always
    -- displays the remote UI through tmux, so wrapping unconditionally is correct.
    return "\027Ptmux;" .. inner:gsub("\027", "\027\027") .. "\027\\"
  end

  local function copy(reg)
    return function(lines, regtype)
      cache[reg] = { lines, regtype or "v" }
      vim.api.nvim_ui_send(osc52_seq(reg, vim.base64.encode(table.concat(lines, "\n"))))
    end
  end

  local function paste(reg)
    return function() return cache[reg][1], cache[reg][2] end
  end

  vim.g.clipboard = {
    name = "osc52-tmux-remote",
    copy = { ["+"] = copy "+", ["*"] = copy "*" },
    paste = { ["+"] = paste "+", ["*"] = paste "*" },
  }

  vim.opt.clipboard = "unnamedplus"
end

return {}
