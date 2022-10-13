local M = {}

function M.config()
  local zk = require("user.core.utils").load_module("zk")
  if not zk then
    return {}
  end

  zk.setup({
    -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
    -- it's recommended to use "telescope" or "fzf"
    picker = "telescope",

    lsp = {
      -- `config` is passed to `vim.lsp.start_client(config)`
      config = {
        cmd = { "zk", "lsp" },
        name = "zk",
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<cr>", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Declaration" })
          vim.keymap.set("n", "<bs>", ":ZkBacklinks<cr>", { buffer = bufnr, desc = "Back links" })
        end,
      },

      -- automatically attach buffers in a zk notebook that match the given filetypes
      auto_attach = {
        enabled = true,
        filetypes = { "markdown" },
      },
    },
  })

  function M.grep_notes(opts)
    local collection = {}
    local list_opts = { select = { "title", "path", "absPath" } }
    require("zk.api").list(vim.env.ZK_NOTEBOOK_DIR, list_opts, function(_, notes)
      for _, note in ipairs(notes) do
        collection[note.absPath] = note.title or note.path
      end
    end)
    local options = vim.tbl_deep_extend("force", {
      prompt_title = "Notes",
      search_dirs = { vim.env.ZK_NOTEBOOK_DIR },
      disable_coordinates = true,
      path_display = function(_, path)
        return collection[path]
      end,
    }, opts or {})
    require("telescope.builtin").live_grep(options)
  end

  local actions = require("telescope.actions")
  local state = require("telescope.actions.state")

  local parse_text = function(text)
    local formatted_text = text:gsub("%.md", ""):gsub("%.", " ")
    return formatted_text
  end

  local titleize = function(s)
    s = s:gsub("%-", " ")
    return s:sub(1, 1):upper() .. s:sub(2)
  end

  function M.open_note(path, dirType)
    assert(path ~= nil, "No text for note path")
    assert(path ~= "", "No text for note path")
    local dir, group
    local pathDir, filename = path:match("([^,]+)/([^,]+)")

    if filename == nil then
      filename = path
    end

    if dirType == "fleeting" then
      dir = "Fleeting notes"
      group = "fleeting_notes"
    elseif dirType == "permanent" then
      dir = "Permanent Notes"
      group = "permanent_notes"
    elseif dirType == "literature" then
      group = "literature_notes"
      dir = "Literature Notes"
    end

    assert(path ~= nil or dir ~= nil, "No directory for the note")
    assert(group ~= nil or dir ~= nil, "No group for the note")

    local title = titleize(parse_text(filename))

    require("zk").new({ title = title, group = group, dir = dir or pathDir })
  end

  function M.open_notebook()
    M.open_note("index")
  end

  function M.find_or_create_note(opts)
    local dir = opts.args
    local options = vim.tbl_deep_extend("force", {
      prompt_title = titleize(dir) .. " Notes",
      cwd = vim.env.ZK_NOTEBOOK_DIR,
      find_command = {
        "fd",
        "--type",
        "file",
        "--strip-cwd-prefix",
        "-e",
        "md",
      },
      attach_mappings = function(_, map)
        actions.select_default:replace(function()
          return true
        end)

        local run_expand_command = function()
          local num_of_line_prefix_or_whatever = 4 -- first n characters in line before actual text.T TODO

          local selection = state.get_selected_entry()
          local cursor = vim.api.nvim_win_get_cursor(0)
          local line = vim.api.nvim_get_current_line()
          local text
          local nline

          if selection ~= nil then
            nline = line:sub(0, cursor[2] + 1) .. selection.value .. line:sub(cursor[2] + 2)
            text = parse_text(selection.value)
          else
            local input_text = state.get_current_line()
            text = parse_text(input_text)
          end

          nline = line:sub(0, cursor[2] - (line:len() - num_of_line_prefix_or_whatever))
            .. text
            .. line:sub(cursor[2] + 2)

          vim.api.nvim_set_current_line(nline)
          vim.api.nvim_win_set_cursor(0, { cursor[1], cursor[2] + text:len() })

          return true
        end

        local open_note = function(prompt_bufnr, _)
          local selection = state.get_selected_entry()
          local input_text = state.get_current_line()
          if selection ~= nil then
            M.open_note(selection.value, dir)
            actions.close(prompt_bufnr)
          else
            vim.ui.input({ prompt = "Do you want to create note " .. input_text .. " (y/N) " }, function(input)
              if input ~= nil and input == "y" then
                M.open_note(input_text, dir)
              end

              actions.close(prompt_bufnr)
            end)
          end
        end

        local create_note = function(prompt_bufnr, _)
          local input_text = state.get_current_line()
          M.open_note(input_text, dir)

          actions.close(prompt_bufnr)
        end

        map("i", "<C-e>", run_expand_command)
        map("i", "<tab>", run_expand_command)
        map("i", "<CR>", open_note)
        map("i", "<C-o>", create_note)
        map("n", "<CR>", open_note)

        return true
      end,

      path_display = function(_, path)
        local icon

        if path:match("^Fleeting Notes/.*") then
          icon = "📓"
        elseif path:match("^Literature Notes/.*") then
          icon = "📙"
        elseif path:match("^Permanent Notes/.*") then
          icon = "📗"
        end

        if icon then
          return icon .. " " .. path:match("(.+)%..+")
        else
          return path:match("(.+)%..+")
        end
      end,
    }, opts or {})
    require("telescope.builtin").find_files(options)
  end

  vim.api.nvim_create_user_command("ZkOpenNotebook", M.open_notebook, {})
  vim.api.nvim_create_user_command("ZkGrep", M.grep_notes, {})
  vim.api.nvim_create_user_command("ZkFindOrCreateNote", M.find_or_create_note, {
    nargs = "?",
    desc = "Open or create node",
    complete = function()
      -- return system("git branch --sort=-committerdate --format='%(refname:short)'") ?
      return { "Permanent Notes", "Fleeting Notes", "Literature Notes" }
    end,
  })
end

return M
