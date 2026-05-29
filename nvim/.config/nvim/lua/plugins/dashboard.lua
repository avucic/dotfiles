-- Service name from the in-container cwd (/app/services/<svc> -> <svc>).
local function service_name()
  local cwd = vim.fn.getcwd()
  return cwd:match "/services/([^/]+)" or vim.fn.fnamemodify(cwd, ":t")
end

-- Env badge as snacks dashboard text chunks (nil on host so nothing renders).
local function env_badge()
  if vim.env.DEVCONTAINER then
    return { { "DEV ", hl = "DashboardDev" }, { service_name(), hl = "DashboardDevText" } }
  end
  if vim.env.REMOTE_NVIM then return { { "REMOTE", hl = "DashboardRemote" } } end
  return nil
end

local function dashboard_sections()
  local sections = { { section = "header" } }
  local badge = env_badge()
  if badge then sections[#sections + 1] = { text = badge, align = "center", padding = 1 } end
  sections[#sections + 1] = { section = "keys", gap = 1, padding = 1 }
  sections[#sections + 1] = { section = "startup" }
  return sections
end

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    dashboard = {
      preset = {
        -- hl = "DashboardHeader",
        header = table.concat({
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
          "                                                                                     ",
          "                                                                                     ",
          "                               ...remember who you are...                            ",
        }, "\n"),
        keys = {},
      },
      sections = dashboard_sections(),
    },
  },
}
