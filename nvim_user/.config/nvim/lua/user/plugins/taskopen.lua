local M = {}
local actions = require("telescope.actions")
local state = require("telescope.actions.state")

local taskopen = function(opts)
  local cwd = opts.cwd or vim.env.ZK_NOTEBOOK_DIR
  local options = vim.tbl_deep_extend("force", {
    prompt_title = opts.title or "Notes",
    path_display = path_display,
    attach_mappings = function(_, map)
      actions.select_default:replace(function()
        return true
      end)

      function dump(o)
        if type(o) == "table" then
          local s = "{ "
          for k, v in pairs(o) do
            if type(k) ~= "number" then
              k = '"' .. k .. '"'
            end
            s = s .. "[" .. k .. "] = " .. dump(v) .. ","
          end
          return s .. "} "
        else
          return tostring(o)
        end
      end

      local select_note = function(prompt_bufnr, _)
        local selection = state.get_selected_entry()
        -- Created task 4
        -- local command = "task add " .. selection.value.title .. " && " .. "taskopen " .. selection.value.absPath
        local handle = io.popen("task add " .. selection.value.title)
        local result = handle:read("*a")
        handle:close()
        local id = result:gsub("\n", ""):match("%d[%d]*")

        handle = io.popen("task " .. id .. " annotate -- " .. selection.value.absPath)
        result = handle:read("*a")
        handle:close()

        actions.close(prompt_bufnr)
      end

      map("i", "<CR>", select_note)
      map("n", "<CR>", select_note)

      return true
    end,
  }, opts or {})
  require("zk").edit({ path = cwd }, { picker = "telescope", telescope = options })
end

function M.config()
  --
  vim.api.nvim_create_user_command("TaskOpen", taskopen, { desc = "Open task and attach file" })
end

return M
