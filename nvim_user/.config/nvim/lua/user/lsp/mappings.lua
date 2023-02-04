local open_diagnostic = function()
    local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
        scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
end

return {
    n = {
        -- ["<leader>la"] = false,
        -- ["<leader>lf"] = false,
        -- ["<leader>lh"] = false,
        -- ["<leader>lr"] = false,
        ["gr"] = ":Glance references<cr>",
        ["K"] = false,
        ["<c-space>"] = { open_diagnostic },
        -- ["gD"] = ":Glance definitions<cr>",
    },
}
