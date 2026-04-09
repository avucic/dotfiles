local M = {}

function M.toggle()
  local cwd = vim.fn.getcwd()

  local cmd

  if vim.env.DEVCONTAINER then
    cmd = "cd " .. cwd .. " && nvim"
  else
    cmd = "cd " .. cwd .. " && devcontainer up --workspace-folder . && devcontainer exec --workspace-folder . nvim"
  end

  -- respawn current tmux pane with new command
  vim.fn.system("tmux respawn-pane -k -t $TMUX_PANE '" .. cmd .. "'")
end

return M
