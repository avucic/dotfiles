return {
  {
    "Hashino/doing.nvim",
    lazy = false,
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local doing = require "doing"
          local maps = opts.mappings
          maps.n["<Leader>nt"] = { desc = "Tasks" }
          maps.n["<Leader>nts"] = {
            function() vim.notify(doing.status(true), vim.log.levels.INFO, { title = "Doing:", icon = "" }) end,
            desc = "Status",
          }
          maps.n["<Leader>nta"] = { function() require("doing").add() end, desc = "Add task" }
          maps.n["<Leader>nte"] = { function() require("doing").edit() end, desc = "Edit task" }
          maps.n["<Leader>ntd"] = { function() require("doing").done() end, desc = "Mark as done" }
          maps.n["<Leader>ntt"] = { function() require("doing").toggle() end, desc = "Toggle" }
        end,
      },

      -- {
      --   "rebelot/heirline.nvim",
      --   opts = function(_, opts)
      --     -- Ensure opts.statusline is a table
      --     local original_statusline = opts.statusline or {}
      --
      --     -- Add the new provider as a component to the statusline
      --     table.insert(opts.statusline, {
      --       provider = function()
      --         local doing = require "doing"
      --         return " " .. doing.status() .. " +" .. tostring(doing.tasks_left())
      --       end,
      --       update = { "BufEnter", "User", pattern = "TaskModified" },
      --     })
      --     -- opts.statusline = {
      --     --   { provider = "PREPEND" }, -- Align left
      --     --   { provider = "%=" }, -- Align left
      --     --   {
      --     --     provider = function()
      --     --       local doing = require "doing"
      --     --       return " " .. doing.status() .. " +" .. tostring(doing.tasks_left())
      --     --     end,
      --     --     update = { "BufEnter", "User", pattern = "TaskModified" },
      --     --   },
      --     --   { provider = "%=" }, -- Align right
      --     -- }
      --     --
      --     -- for _, v in ipairs(original_statusline) do
      --     --   table.insert(opts.statusline, v)
      --     -- end
      --   end,
      -- },
    },
  },
}
