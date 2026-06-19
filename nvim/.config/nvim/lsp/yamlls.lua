return {
  cmd      = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  settings = {
    yaml = {
      validate = true,
      hover    = true,
      completion = true,
      schemaStore = { enable = true, url = 'https://www.schemastore.org/api/json/catalog.json' },
    },
  },
}
