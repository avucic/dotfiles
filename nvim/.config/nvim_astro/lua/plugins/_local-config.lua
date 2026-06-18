local project = vim.g.project or {}

-- packovi
local packs = project.astro_packs or {}
local specs = { "AstroNvim/astrocommunity" }
for _, pack in ipairs(packs) do
  table.insert(specs, { import = pack })
end

-- mason tools
local tools = project.mason_tools or {}
if #tools > 0 then
  table.insert(specs, {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, tools)
    end,
  })
end

local cwd = vim.fn.getcwd()
local devcontainer = os.getenv "DEVCONTAINER" or os.getenv "REMOTE_CONTAINERS"

if devcontainer then
  local f = cwd .. "/.nvim.lua.devcontainer"
  if vim.fn.filereadable(f) == 1 then dofile(f) end
end

return specs
