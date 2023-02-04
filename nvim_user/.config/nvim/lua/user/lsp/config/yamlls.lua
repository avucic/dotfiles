return {
  settings = {
    yaml = {
      schemas = {
        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      },
    },
    -- json = {
    --   schemas = {
    --     resume = {
    --       description = "JSON Resume",
    --       fileMatch = { "resume.json" },
    --       url = "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json",
    --     },
    --   },
    -- },
  },
}
