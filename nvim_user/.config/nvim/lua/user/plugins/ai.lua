return {
    {
        "dense-analysis/neural",
        config = require("user.plugins.configs.neural"),
        dependencies = {
            "MunifTanjim/nui.nvim",
            "ElPiloto/significant.nvim",
        },
    },
    {
        "jackMort/ChatGPT.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            yank_register = [[*]],
            keymaps = {
                close = { "<C-q>" },
                yank_last = "<C-y>",
                scroll_up = "<C-u>",
                scroll_down = "<C-d>",
                toggle_settings = "<C-o>",
                cycle_windows = "<Tab>",
            },
        },
        config = require("user.plugins.configs.chatgpt"),
        cmd = {
            "ChatGPT",
            "ChatGPTActAs",
        },
    },
}
