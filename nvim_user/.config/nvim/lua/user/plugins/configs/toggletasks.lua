local function file_exists(file)
  local f = io.open(file, "rb")
  if f then
    f:close()
  end
  return f ~= nil
end

local function parse_makefile_tasks(file)
  if not file_exists(file) then
    return {}
  end

  local tasks = {}
  for line in io.lines(file) do
    local match = line:match("^(%S+):")
    if match then
      table.insert(tasks, {
        name = "make " .. match,
        cmd = "make " .. match,
        close_on_exit = false,
      })
    end
  end
  return tasks
end

return function()
  local toggletasks = require("toggletasks")
  local make_tasks = parse_makefile_tasks(vim.fn.getcwd() .. "/Makefile")

  toggletasks.setup({
    search_paths = {
      "toggletasks",
      ".toggletasks",
      ".nvim/toggletasks",
    },
    scan = {
      global_cwd = true, -- vim.fn.getcwd(-1, -1)
      tab_cwd = false, -- vim.fn.getcwd(-1, tab)
      win_cwd = true, -- vim.fn.getcwd(win)
      lsp_root = true, -- root_dir for first LSP available for the buffer
      -- dirs = function(win)
      --   return {
      --     vim.fn.getcwd(win) .. "/.toggletasks",
      --   }
      -- end,
      rtp = false, -- scan directories in &runtimepath
      rtp_ftplugin = false, -- scan in &rtp by filetype, e.g. ftplugin/c/toggletasks.json
    },
    toggleterm = {
      close_on_exit = true,
      hidden = false,
    },
    tasks = function(win)
      local ft = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), "filetype")
      local tasks = {
        {
          name = "Kill port",
          cmd = "echo 'Enter port'; read port;kill -9 $(lsof -i tcp:$port -t)",
        },
      }

      local lng_tasks = require("user.core.utils").load_module("user.plugins.configs.toggletasks." .. ft)
      if lng_tasks then
        for _, v in ipairs(lng_tasks.config()) do
          table.insert(tasks, v)
        end
      end

      for _, v in ipairs(make_tasks) do
        table.insert(tasks, v)
      end

      return tasks
    end,

    telescope = {
      spawn = {
        open_single = true, -- auto-open terminal window when spawning a single task
        show_running = true, -- include already running tasks in picker candidates
        -- Replaces default select_* actions to spawn task (and change toggleterm
        -- direction for select horiz/vert/tab)
        mappings = {
          select_float = "<C-f>",
          spawn_smart = "<C-a>", -- all if no entries selected, else use multi-select
          spawn_all = "<M-a>", -- all visible entries
          spawn_selected = nil, -- entries selected via multi-select (default <tab>)
        },
      },
      -- Replaces default select_* actions to open task terminal (and change toggleterm
      -- direction for select horiz/vert/tab)
      select = {
        mappings = {
          select_float = "<C-f>",
          select_horiz = "<C-h>",
          select_vert = "<C-v>",
          select_tab = "<C-t>",
          open_smart = "<C-a>",
          open_all = "<M-a>",
          open_selected = nil,
          kill_smart = "<c-q>",
          kill_all = "<M-q>",
          kill_selected = "dd",
          respawn_smart = "<C-s>",
          respawn_all = "<M-s>",
          respawn_selected = nil,
        },
      },
    },
  })
end
