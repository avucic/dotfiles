local M = {}

function M.setup()
        vim.g.markdown_fenced_languages = { "ruby", "go", "javascript" }
end

function M.config()
    local mdeval = require("user.core.utils").load_module("mdeval")
    if not mdeval then
        return {}
    end

    mdeval.setup({ require_confirmation = false })
end

return M
