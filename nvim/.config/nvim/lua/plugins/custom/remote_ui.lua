local M = {}

local config = {
  port = 5555,
  workdir = nil, -- fallback only; per-container working_dir is queried from docker
  nvim_cmd = "nvim",
}

function M.setup(opts) config = vim.tbl_deep_extend("force", config, opts or {}) end

local function notify(msg, level) vim.notify(msg, level or vim.log.levels.INFO, { title = "RemoteUI" }) end

local function in_container() return vim.env.DEVCONTAINER ~= nil or vim.fn.executable "docker" == 0 end

local function list_containers()
  local raw = vim.fn.systemlist { "docker", "ps", "--format", "{{.Names}}" }
  if vim.v.shell_error ~= 0 then return nil end
  return vim.tbl_filter(function(s) return s ~= "" end, raw)
end

local function pick_container(cb)
  if in_container() then
    notify("Run this from host nvim — no docker available here", vim.log.levels.WARN)
    return
  end
  local names = list_containers()
  if not names then
    notify("docker ps failed", vim.log.levels.ERROR)
    return
  end
  if #names == 0 then
    notify("No running containers", vim.log.levels.WARN)
    return
  end
  vim.ui.select(names, { prompt = "Container:" }, cb)
end

local function host_port(container, port)
  local out = vim.fn.system { "docker", "port", container, port .. "/tcp" }
  if vim.v.shell_error ~= 0 then return nil end
  for line in out:gmatch "[^\r\n]+" do
    local hp = line:match ":(%d+)$"
    if hp then return tonumber(hp) end
  end
  return nil
end

-- Liveness check from the host side, independent of container tooling (the dev
-- image may lack pgrep/ps). Connect to the published port and do one RPC call:
-- a real nvim answers; a bare docker-proxy with no backend drops the connection.
local function server_listening(hp)
  if not hp then return false end
  local ok, chan = pcall(vim.fn.sockconnect, "tcp", "127.0.0.1:" .. hp, { rpc = true })
  if not ok or type(chan) ~= "number" or chan <= 0 then return false end
  local alive = pcall(vim.rpcrequest, chan, "nvim_get_api_info")
  pcall(vim.fn.chanclose, chan)
  return alive
end

local function container_workdir(container)
  local out = vim.fn.system { "docker", "inspect", container, "--format", "{{.Config.WorkingDir}}" }
  if vim.v.shell_error ~= 0 then return nil end
  local dir = vim.trim(out)
  return dir ~= "" and dir or nil
end

local function start_nvim(container)
  local workdir = container_workdir(container) or config.workdir
  local cd = workdir and ("cd " .. workdir .. " 2>/dev/null; ") or ""
  local inner = string.format(
    "%senv -u XDG_CONFIG_HOME REMOTE_NVIM=1 %s --headless --listen 0.0.0.0:%d",
    cd,
    config.nvim_cmd,
    config.port
  )
  vim.fn.system { "docker", "exec", "-d", container, "sh", "-c", inner }
end

local function respawn_pane(cmd)
  if vim.env.TMUX == nil then
    notify("Not inside tmux. Run from a tmux pane, or run this from a shell: " .. cmd, vim.log.levels.ERROR)
    return false
  end
  vim.fn.system("tmux respawn-pane -k -t $TMUX_PANE " .. vim.fn.shellescape(cmd))
  return true
end

function M.start()
  pick_container(function(container)
    if not container then return end

    local hp = host_port(container, config.port)
    if not hp then
      notify(
        ('Port %d not published from %s. Add \'ports: ["%d:%d"]\' (or "%d") to compose.'):format(
          config.port,
          container,
          config.port,
          config.port,
          config.port
        ),
        vim.log.levels.ERROR
      )
      return
    end

    if not server_listening(hp) then
      notify(("Starting headless nvim in %s …"):format(container))
      start_nvim(container)
      if not vim.wait(10000, function() return server_listening(hp) end, 200) then
        notify("Timed out waiting for nvim to start in " .. container, vim.log.levels.ERROR)
        return
      end
    end

    -- Toggle feel: after the remote UI exits (detach/quit), cd back to the dir the
    -- host nvim was launched from and relaunch host nvim. When that nvim quits,
    -- drop to an interactive shell so the tmux pane survives instead of closing.
    local cwd = vim.fn.shellescape(vim.fn.getcwd())
    respawn_pane(
      ('nvim --server 127.0.0.1:%d --remote-ui; cd %s; nvim; exec "${SHELL:-/bin/zsh}"'):format(hp, cwd)
    )
  end)
end

function M.quit() vim.cmd "qa!" end

function M.stop()
  pick_container(function(container)
    if not container then return end
    local hp = host_port(container, config.port)
    if not (hp and server_listening(hp)) then
      notify("No running nvim server in " .. container, vim.log.levels.WARN)
      return
    end
    -- ask the remote nvim to quit (kills the server); host-side, no container tools
    vim.fn.system { "nvim", "--server", "127.0.0.1:" .. hp, "--remote-send", "<C-\\><C-N>:qa!<CR>" }
    notify("Stopped nvim server in " .. container)
  end)
end

local function open_float(lines, title)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "remoteinfo"

  local width = 0
  for _, l in ipairs(lines) do
    width = math.max(width, vim.fn.strdisplaywidth(l))
  end
  width = math.min(width + 4, vim.o.columns - 4)
  local height = math.min(#lines, vim.o.lines - 4)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2 - 1),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
    title = title and (" " .. title .. " ") or nil,
    title_pos = "center",
  })
  for _, key in ipairs { "q", "<Esc>" } do
    vim.keymap.set("n", key, function()
      if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
    end, { buffer = buf, nowait = true, silent = true })
  end
  return win
end

function M.info()
  -- inside a container we can't talk to docker; report what we can
  if in_container() then
    open_float({
      "This instance",
      ("  mode        : %s"):format(vim.env.REMOTE_NVIM and "REMOTE (headless server)" or "container"),
      ("  servername  : %s"):format(vim.v.servername ~= "" and vim.v.servername or "(none)"),
      ("  cwd         : %s"):format(vim.fn.getcwd()),
      "",
      "Docker not available here — run :RemoteInfo from host nvim for container details.",
    }, "RemoteUI")
    return
  end

  local lines = {
    "This instance",
    ("  mode        : %s"):format(vim.env.REMOTE_NVIM and "REMOTE" or "HOST"),
    ("  servername  : %s"):format(vim.v.servername ~= "" and vim.v.servername or "(none)"),
    ("  listen port : %d"):format(config.port),
    "",
    "Containers",
  }

  local names = list_containers()
  if not names then
    table.insert(lines, "  docker ps failed")
  elseif #names == 0 then
    table.insert(lines, "  (none running)")
  else
    for _, name in ipairs(names) do
      local hp = host_port(name, config.port)
      local up = server_listening(hp)
      table.insert(lines, ("  %s %s"):format(up and "" or "", name))
      table.insert(lines, ("      workdir : %s"):format(container_workdir(name) or "?"))
      table.insert(lines, ("      server  : %s"):format(up and "running" or "stopped"))
      table.insert(lines, ("      address : %s"):format(hp and ("127.0.0.1:" .. hp) or "(port not published)"))
    end
  end

  table.insert(lines, "")
  table.insert(lines, "press q / <Esc> to close")
  open_float(lines, "RemoteUI")
end

return M
