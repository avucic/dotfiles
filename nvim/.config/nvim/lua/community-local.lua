-- lua/plugins/community-local.lua  (novi fajl)
local project = vim.g.project or {}
local packs = project.astro_packs or {}

local specs = {}
for _, pack in ipairs(packs) do
  table.insert(specs, { import = pack })
end

return specs
