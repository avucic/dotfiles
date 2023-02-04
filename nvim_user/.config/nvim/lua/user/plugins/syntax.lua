return {
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup()
        end,
        cmd = {
            "TodoLocList",
            "TodoQuickFix",
            "TodoTrouble",
            "TodoTelescope",
        },
    },
    {
        "folke/paint.nvim", -- highlight symbols in code like @something TODO:
        config = require("user.plugins.configs.paint")
    },
    -- {
    --  "dominikduda/vim_current_word",
    -- - event = "BufRead",
    -- },
}
