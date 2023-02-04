return {
    {
        "jcdickinson/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "hrsh7th/nvim-cmp",
        },
        event = "InsertEnter",
        config = function()
            require("codeium").setup({})
        end,
    },
    {
        "hrsh7th/cmp-cmdline",
        event = "InsertEnter",
    },
    {
        "dmitmel/cmp-cmdline-history",
        event = "InsertEnter",
    },
    {
        "hrsh7th/vim-vsnip",
        event = "InsertEnter",
    },
    {
        "hrsh7th/cmp-emoji",
        event = "InsertEnter",
    },
    {
        "hrsh7th/cmp-vsnip",
        event = "InsertEnter",
    },
    {
        "f3fora/cmp-spell",
        event = "InsertEnter",
    },

}
