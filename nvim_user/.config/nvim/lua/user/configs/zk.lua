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
        -- on_attach = ...
        -- etc, see `:h vim.lsp.start_client()`
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

  vim.api.nvim_create_user_command("ZkGrep", M.grep_notes, {})
end

return M
