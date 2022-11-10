local M = {}

local neotree = require("neo-tree")
local renderer = require("neo-tree.ui.renderer")

-- Expand a node and load filesystem info if needed.
local function open_dir(state, dir_node)
  local fs = require("neo-tree.sources.filesystem")
  fs.toggle_directory(state, dir_node, nil, true, false)
end

-- Expand a node and all its children, optionally stopping at max_depth.
local function recursive_open(state, node, max_depth)
  local max_depth_reached = 1
  local stack = { node }
  while next(stack) ~= nil do
    node = table.remove(stack)
    if node.type == "directory" and not node:is_expanded() then
      open_dir(state, node)
    end

    local depth = node:get_depth()
    max_depth_reached = math.max(depth, max_depth_reached)

    if not max_depth or depth < max_depth - 1 then
      local children = state.tree:get_nodes(node:get_id())
      for _, v in ipairs(children) do
        table.insert(stack, v)
      end
    end
  end

  return max_depth_reached
end

--- Open the fold under the cursor, recursing if count is given.
local function neotree_zo(state, open_all)
  local node = state.tree:get_node()

  if open_all then
    recursive_open(state, node)
  else
    recursive_open(state, node, node:get_depth() + vim.v.count1)
  end

  renderer.redraw(state)
end

--- Recursively open the current folder and all folders it contains.
local function neotree_zO(state)
  neotree_zo(state, true)
end

-- The nodes inside the root folder are depth 2.
local MIN_DEPTH = 2

--- Close the node and its parents, optionally stopping at max_depth.
local function recursive_close(state, node, max_depth)
  if max_depth == nil or max_depth <= MIN_DEPTH then
    max_depth = MIN_DEPTH
  end

  local last = node
  while node and node:get_depth() >= max_depth do
    if node:has_children() and node:is_expanded() then
      node:collapse()
    end
    last = node
    node = state.tree:get_node(node:get_parent_id())
  end

  return last
end

--- Close a folder, or a number of folders equal to count.
local function neotree_zc(state, close_all)
  local node = state.tree:get_node()
  if not node then
    return
  end

  local max_depth
  if not close_all then
    max_depth = node:get_depth() - vim.v.count1
    if node:has_children() and node:is_expanded() then
      max_depth = max_depth + 1
    end
  end

  local last = recursive_close(state, node, max_depth)
  renderer.redraw(state)
  renderer.focus_node(state, last:get_id())
end

-- Close all containing folders back to the top level.
local function neotree_zC(state)
  neotree_zc(state, true)
end

--- Open a closed folder or close an open one, with an optional count.
local function neotree_za(state, toggle_all)
  local node = state.tree:get_node()
  if not node then
    return
  end

  if node.type == "directory" and not node:is_expanded() then
    neotree_zo(state, toggle_all)
  else
    neotree_zc(state, toggle_all)
  end
end

--- Recursively close an open folder or recursively open a closed folder.
local function neotree_zA(state)
  neotree_za(state, true)
end

--- Set depthlevel, analagous to foldlevel, for the neo-tree file tree.
local function set_depthlevel(state, depthlevel)
  if depthlevel < MIN_DEPTH then
    depthlevel = MIN_DEPTH
  end

  local stack = state.tree:get_nodes()
  while next(stack) ~= nil do
    local node = table.remove(stack)

    if node.type == "directory" then
      local should_be_open = depthlevel == nil or node:get_depth() < depthlevel
      if should_be_open and not node:is_expanded() then
        open_dir(state, node)
      elseif not should_be_open and node:is_expanded() then
        node:collapse()
      end
    end

    local children = state.tree:get_nodes(node:get_id())
    for _, v in ipairs(children) do
      table.insert(stack, v)
    end
  end

  vim.b.neotree_depthlevel = depthlevel
end

--- Refresh the tree UI after a change of depthlevel.
-- @bool stay Keep the current node revealed and selected
local function redraw_after_depthlevel_change(state, stay)
  local node = state.tree:get_node()

  if stay then
    require("neo-tree.ui.renderer").expand_to_node(state.tree, node)
  else
    -- Find the closest parent that is still visible.
    local parent = state.tree:get_node(node:get_parent_id())
    while not parent:is_expanded() and parent:get_depth() > 1 do
      node = parent
      parent = state.tree:get_node(node:get_parent_id())
    end
  end

  renderer.redraw(state)
  renderer.focus_node(state, node:get_id())
end

--- Update all open/closed folders by depthlevel, then reveal current node.
local function neotree_zx(state)
  set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
  redraw_after_depthlevel_change(state, true)
end

--- Update all open/closed folders by depthlevel.
local function neotree_zX(state)
  set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
  redraw_after_depthlevel_change(state, false)
end

-- Collapse more folders: decrease depthlevel by 1 or count.
local function neotree_zm(state)
  local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
  set_depthlevel(state, depthlevel - vim.v.count1)
  redraw_after_depthlevel_change(state, false)
end

-- Collapse all folders. Set depthlevel to MIN_DEPTH.
local function neotree_zM(state)
  set_depthlevel(state, MIN_DEPTH)
  redraw_after_depthlevel_change(state, false)
end

-- Expand more folders: increase depthlevel by 1 or count.
local function neotree_zr(state)
  local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
  set_depthlevel(state, depthlevel + vim.v.count1)
  redraw_after_depthlevel_change(state, false)
end

-- Expand all folders. Set depthlevel to the deepest node level.
local function neotree_zR(state)
  local top_level_nodes = state.tree:get_nodes()

  local max_depth = 1
  for _, node in ipairs(top_level_nodes) do
    max_depth = math.max(max_depth, recursive_open(state, node))
  end

  vim.b.neotree_depthlevel = max_depth
  redraw_after_depthlevel_change(state, false)
end

local function system_open(state)
  local node = state.tree:get_node()
  local path = node:get_id()
  -- macOs: open file in default application in the background.
  -- Probably you need to adapt the Linux recipe for manage path with spaces. I don't have a mac to try.
  vim.api.nvim_command("silent !open -g " .. path)
  -- Linux: open file in default application
  vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
end

local function yank_path(state)
  local node = state.tree:get_node()
  local content = node.path
  -- relative
  -- local content = node.path:gsub(state.path, ""):sub(2)
  vim.fn.setreg('"', content)
  vim.fn.setreg("1", content)
  vim.fn.setreg("+", content)
end

-- local function pick_window(state)
--   local node = state.tree:get_node()
--   local success, picker = pcall(require, "window-picker")
--   if not success then
--     print(
--       "You'll need to install window-picker to use this command: https://github.com/s1n7ax/nvim-window-picker"
--     )
--     return
--   end
--   local picked_window_id = picker.pick_window()
--   if picked_window_id then
--     vim.api.nvim_set_current_win(picked_window_id)
--     vim.cmd("edit " .. vim.fn.fnameescape(node.path))
--   end
-- end,
-- end

function M.config()
  local neo_tree = require("user.core.utils").load_module("neo-tree")
  if not neo_tree then
    return
  end

  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_respect_buf_cwd = 1

  -- local tree_cb = require("nvim-tree.config").nvim_tree_callback
  -- Make sure nvim-tree loads itself when lazy loaded
  -- vim.defer_fn(require("nvim-tree").refresh, 25)

  local global_commands = {
    system_open = system_open,
    yank_path = yank_path,

    neotree_zo = neotree_zo,
    neotree_zO = neotree_zO,
    neotree_zc = neotree_zc,
    neotree_zC = neotree_zC,
    neotree_za = neotree_za,
    neotree_zA = neotree_zA,
    neotree_zx = neotree_zx,
    neotree_zX = neotree_zX,
    neotree_zm = neotree_zm,
    neotree_zM = neotree_zM,
    neotree_zr = neotree_zr,
    neotree_zR = neotree_zR,
  }

  return {
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
      commands = global_commands,
      -- follow_current_file = false,
    },
    buffers = {
      commands = global_commands,
      window = {
        mappings = {
          ["d"] = "buffer_delete",
        },
      },
    },
    git_status = {
      commands = global_commands,
    },
    window = {
      width = 40,

      mappings = {
        ["<esc>"] = "revert_preview",
        ["q"] = "close_window",
        ["o"] = "open_with_window_picker",
        ["<tab>"] = "open_with_window_picker",
        ["<cr>"] = "open_with_window_picker",
        ["S"] = "split_with_window_picker",
        ["s"] = "vsplit_with_window_picker",
        ["x"] = "system_open",
        ["Y"] = "yank_path",
        ["P"] = { "toggle_preview", config = { use_float = true } },

        ["z"] = "none",

        ["zo"] = "neotree_zo",
        ["zO"] = "neotree_zO",
        ["zc"] = "neotree_zc",
        ["zC"] = "neotree_zC",
        ["za"] = "neotree_za",
        ["zA"] = "neotree_zA",
        ["zx"] = "neotree_zx",
        ["zX"] = "neotree_zX",
        ["zm"] = "neotree_zm",
        ["zM"] = "neotree_zM",
        ["zr"] = "neotree_zr",
        ["zR"] = "neotree_zR",
      },
    },
  }
end

return M
