return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- local alpha = require("user.core.utils").load_module("alpha-nvim")
      -- if not alpha then
      --   return opts
      -- end

      local plugins_count = vim.fn.len(vim.fn.globpath(vim.fn.stdpath("data") .. "/site/pack/packer/start", "*", 0, 1))
      local lines = {}

      opts.config.layout =
      {
        { type = "padding", val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) }) },
        {
          type = "text",
          val = {
            "      @@@@@@@@@@@@@@@@@@                                       &@@@@@@@@@@@@@@@@@@@@ ",
            "    @@@@@@@@@@@@@@@@@@@@@@@@@@                            @@@@@@@@@@@@@@@@@@@@@@@@@@ ",
            "     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ",
            "     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ",
            "     *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  ",
            "      %@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      @@@@@@@@@@@@@@@@@@@@@@@@@@   ",
            "        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@            @@@@@@@@ ,@@@@@@@@@@@@    ",
            "         @@@@@@@@@#  @@@@@@@@@# /@@@@@@@@@@@@%      *@,      @@@@@     #@@@@@@@      ",
            "            @@       @@@@@@@@     @@@@@@@@@@@      @@@@@     @@@@@                   ",
            "                     @@@@@@@@@@@@@@@@@@@@@@@@%      %@       @@@@                    ",
            "                      @@@@@@@@@@@@@@@@@@@@@@@@@            @@@@@@                    ",
            "                      @@@@@@@@@@@@@@@@@@@@@@@@@@@@      @@@@@@@@                     ",
            "                      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                     ",
            "                      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                      ",
            "                      ,@@@@@@@@@@@@@@@@@     @@@@@@@@@@@@@@@@@@                      ",
            "                       @@@@@@@@@@@@@@(          @@@@@@@@@@@@@@                       ",
            "                       @@@@@@@@@@@@@@@#       @@@@@@@@@@@@@@@@                       ",
            "                        @@@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@@@@                        ",
            "                           @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%                         ",
            "                               @@@@@@@@@@@@@@@@@@@@@@@@%                             ",
            "                                   @@@@@@@@@@@@@@@@%                                 ",
          },
          opts = { position = "center", hl = "DashboardHeader" },
        },
        { type = "padding", val = 3 },
        {
          type = "text",
          val = {
            "AstroNvim loaded " .. plugins_count .. " plugins ",
          },
          opts = {
            position = "center",
            hl = "DashboardFooter",
          },
        },
        { type = "padding", val = 3 },
        {
          type = "text",
          val = lines,
          opts = {
            position = "center",
            hl = "DashboardTasks",
          },
        },
        { type = "padding", val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) }) },
        -- { type = "padding", val = 5 },
        -- {
        --   type = "terminal",
        --   command = "task next",
        --   width = 70,
        --   height = 10,
        --   opts = {
        --     redraw = true,
        --     window_config = {},
        --   },
        -- },

        -- {
        --   type = "group",
        --   val = {
        --     alpha_button("LDR f p", "  Find Project  "),
        --     alpha_button("LDR f o", "  Recents  "),
        --     alpha_button("LDR f f", "  Find File  "),
        --     alpha_button("LDR f g", "  Find Word  "),
        --     alpha_button("LDR f n", "  New File  "),
        --     alpha_button("LDR f m", "  Bookmarks  "),
        --     alpha_button("LDR S l", "  Last Session  "),
        --   },
        --
        --   opts = { spacing = 1 },
        -- },
      }

      vim.defer_fn(function()
        if vim.o.filetype == "alpha" then
          local handle = io.popen("task next")
          local result = handle:read("*a")
          handle:close()

          for s in result:gmatch("[^\r\n]+") do
            table.insert(lines, s)
          end
          vim.cmd([[AlphaRedraw]])
        end
      end, 1)

      return opts
    end

  }
}
