local M = {}

function M.config()
  local plugins_count = vim.fn.len(vim.fn.globpath(vim.fn.stdpath("data") .. "/site/pack/packer/start", "*", 0, 1))
  local function alpha_button(sc, txt)
    local sc_ = sc:gsub("%s", ""):gsub("LDR", "<leader>")
    if vim.g.mapleader then
      sc = sc:gsub("LDR", vim.g.mapleader == " " and "SPC" or vim.g.mapleader)
    end
    return {
      type = "button",
      val = txt,
      on_press = function()
        local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
        vim.api.nvim_feedkeys(key, "normal", false)
      end,
      opts = {
        position = "center",
        text = txt,
        shortcut = sc,
        cursor = 5,
        width = 36,
        align_shortcut = "right",
        hl = "DashboardCenter",
        hl_shortcut = "DashboardShortcut",
      },
    }
  end

  return {
    layout = {
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
      { type = "padding", val = 5 },
      {
        type = "group",
        val = {
          alpha_button("LDR f f", "  Find File  "),
          alpha_button("LDR f o", "  Recents  "),
          alpha_button("LDR f w", "  Find Word  "),
          alpha_button("LDR f n", "  New File  "),
          alpha_button("LDR f m", "  Bookmarks  "),
          alpha_button("LDR S l", "  Last Session  "),
        },
        opts = { spacing = 1 },
      },

      {
        type = "text",
        val = {
          " ",
          " ",
          " ",
          " AstroNvim loaded " .. plugins_count .. " plugins ",
        },
        opts = {
          position = "center",
          hl = "DashboardFooter",
        },
      },
    },
    opts = {},
  }
end

return M
