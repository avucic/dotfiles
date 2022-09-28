local M = {}

function M.config()
  local mind = require("user.core.utils").load_module("mind")
  local telescope = require("user.core.utils").load_module("telescope")

  if not mind or not telescope then
    return {}
  end

  local mind_ = require("mind.node")

  local function close_mind()
    require("mind.commands").commands.quit()
    vim.cmd([[q]])
  end

  mind.setup({
    persistence = {
      state_path = "/Users/vucinjo/Dropbox/Notes/mind.json",
      data_dir = "/Users/vucinjo/Dropbox/Notes",
    },
    template = {
      fer = {
        file = "/Users/vucinjo/Dropbox/Notes/.zk/templates/fer.md",
        name = function()
          return "/Fer/" .. os.date("%d.%m.%Y")
        end,
      },
      journal_daily = {
        file = "/Users/vucinjo/Dropbox/Notes/.zk/templates/daily.md",
        name = function()
          return "/Journal/Daily/" .. os.date("%d.%m.%Y")
        end,
      },
    },
    keymaps = {
      normal = {
        q = close_mind,
        -- x = nil,
        -- ["<space>"] = "select",
      },
      select = {
        q = close_mind,
      },
    },
  })

  local actions = require("telescope.actions")
  local state = require("telescope.actions.state")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local entry_maker = function(item)
    return {
      display = item.label or item.value,
      ordinal = item.label or item.value,
      value = item.value,
    }
  end

  local mind_indexing = require("mind.indexing")

  local search_index = function(tree, prompt, filter, f, opts)
    mind_indexing.index_tree(tree, filter, opts)
    local index_tree = mind_indexing.index
    local paths = {}

    for _, v in pairs(index_tree) do
      table.insert(paths, { label = v.path, value = v.path })
    end

    pickers
      .new({}, {
        prompt_title = prompt,
        -- initial_mode = "normal",
        finder = finders.new_table({
          results = paths,
          entry_maker = entry_maker,
        }),
        -- previewer = previewers.new_buffer_previewer({
        --   title = "My preview",
        --   define_preview = function(self, entry, status)
        --     vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { "line 1", "line 2" })
        --   end,
        -- }),
        sorter = conf.generic_sorter(opts),
        -- on_complete = {
        --   function(picker)
        --     local prompt_bufnr = picker.prompt_bufnr
        --     vim.keymap.set("n", ":echo 'fooo' ", { buffer = prompt_bufnr })
        --   end,
        -- },
        -- on_complete = {
        --   function(picker)
        --     -- remove this on_complete callback
        --     picker:clear_completion_callbacks()
        --     -- if we have exactly one match, select it
        --     if picker.manager.linked_states.size == 1 then
        --       require("telescope.actions").select_default(picker.prompt_bufnr)
        --     end
        --   end,
        -- },
        -- on_complete = {
        --   function()
        --     vim.cmd("stopinsert")
        --   end,
        -- },
        attach_mappings = function(_, map)
          actions.select_default:replace(function()
            return true
          end)

          local run_expand_command = function()
            local selection = state.get_selected_entry()
            local cursor = vim.api.nvim_win_get_cursor(0)
            local line = vim.api.nvim_get_current_line()
            local nline = line:sub(0, cursor[2] + 1) .. selection.value .. line:sub(cursor[2] + 2)

            vim.api.nvim_set_current_line("")
            vim.api.nvim_set_current_line(nline)
            vim.api.nvim_win_set_cursor(0, { cursor[1], cursor[2] + selection.value:len() })
          end

          local select_input_text = function()
            local input_text = state.get_current_line()
            f(input_text, false)
          end

          local select_selection = function()
            local selection = state.get_selected_entry()
            f(selection.value, true)
          end

          map("i", "<C-e>", run_expand_command)
          map("i", "<tab>", run_expand_command)
          map("i", "<c-o>", select_selection)
          map("i", "<CR>", select_input_text)
          map("n", "<CR>", select_selection)

          return true
        end,
      })
      :find()
  end

  vim.api.nvim_create_user_command("MindFindOrCreateNote", function(opts)
    local wrap_fn = mind.wrap_main_tree_fn
    if opts.fargs[1] == "project" then
      wrap_fn = mind.wrap_project_tree_fn
    end

    wrap_fn(function(args)
      local tree = args.get_tree()
      local template_name

      if opts.fargs[2] ~= nil then
        template_name = opts.fargs[2]
        local template = args.opts.template[template_name]
        local template_file = template.file
        local name = template.name()
        local content

        local file = io.open(template_file, "rb")
        if file ~= nil then
          content = file:read("*a")
          file:close()
        end

        local _, node = require("mind.node").get_node_by_path(tree, name, true)
        require("mind.commands").open_data(tree, node, args.data_dir, args.opts)

        file = io.open(vim.fn.expand("%"), "wb")
        if file ~= nil then
          file:write(content)
          file:close()
        end

        args.save_tree()
        vim.cmd([[e %]])
      else
        search_index(
          tree,
          "Create new note by path",
          -- filter function
          function(node)
            return args.opts.tree.automatic_data_creation or node.data ~= nil or node.url ~= nil
          end,
          -- sink function
          function(item)
            local _, node = require("mind.node").get_node_by_path(tree, item, true)
            require("mind.commands").open_data(tree, node, args.data_dir, args.opts)
            args.save_tree()
            vim.cmd([[e %]])
          end
        )
      end
    end)
  end, {
    nargs = "*",
    desc = "Open or create node",
  })
end

local mind_node = require("mind.node")
local mind_ui = require("mind.ui")

-- temp work around
M.delete_node_line = function()
  local mind = require("user.core.utils").load_module("mind")
  local mind_commands = require("mind.commands")
  mind.wrap_main_tree_fn(function(args)
    local tree = args.get_tree()
    local line = vim.api.nvim_win_get_cursor(0)[1] - 1
    local parent, node = mind_node.get_node_and_parent_by_line(tree, line)

    if node == nil then
      print("nema node")
      return
    end

    if parent == nil then
      print("nema parent")
      return
    end

    local index = mind_node.find_parent_index(parent, node)

    for k = index, #tree.children do
      print(".." .. k)
      tree.children[index] = tree.children[index + 1]
    end

    if #tree.children == 0 then
      tree.children = nil
    end

    args.save_tree()

    -- mind_ui.with_confirmation(string.format("Delete '%s'?", node.contents[1].text), function()
    --   -- mind_node.delete_node(parent, index)
    --   -- mind_ui.rerender(tree, args.opts)
    -- end)
  end)
end

return M
