return {
  {
    "Vonr/align.nvim",
    event = { "User AstroFile" },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings

          maps.v["<leader>xac"] = { "<cmd>lua require'align'.align_to_char({ length = 1 })<cr>", desc = "1 character" }
          maps.v["<leader>xas"] =
            { "<cmd>lua require'align'.align_to_char({ length = 2, preview = true })<cr>", desc = "2 characters" }
          maps.v["<leader>xaw"] =
            { "<cmd>lua require'align'.align_to_string({ preview = true, regex = false })<cr>", desc = "String" }
          maps.v["<leader>xar"] =
            { "<cmd>lua require'align'.align_to_char({ preview = true, regex = true })<cr>", desc = "Pattern" }
        end,
      },
    },
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      -- vim.g.VM_default_mappings = 0
      -- vim.g.VM_mouse_mappings = 1
      -- vim.g.VM_skip_empty_lines = 1
      -- vim.g.VM_leader = ","

      -- vim.g.VM_maps = {}
      -- vim.g.VM_maps["Find Under"] = "<M-n>"
      -- vim.g.VM_maps["Find Subword Under"] = "<M-n>"
      -- vim.g.VM_maps["Select Cursor Down"] = "<M-j>"
      -- vim.g.VM_maps["Select Cursor Up"] = "<M-k>"

      vim.cmd [[
        let g:VM_default_mappings = 0
        let g:VM_mouse_mappings = 1
        let g:VM_skip_empty_lines = 1

        let g:VM_leader = ','
        let g:VM_maps = {}
        let g:VM_maps['Find Under'] = '<M-n>'
        let g:VM_maps['Find Subword Under'] = '<M-n>'
        let g:VM_maps['Select Cursor Down'] = '<M-j>'
        let g:VM_maps['Select Cursor Up'] = '<M-k>'
        " let g:VM_maps = {}
        " let g:VM_maps["Add Cursor At Pos"]            = '<c-c>'
        " let g:VM_maps['Visual Add']                   = '<c-c>'
        " let g:VM_maps["Select All"]                   = '<c-a>'
        " let g:VM_maps['Visual All']                   = '<c-a>'
      ]]
    end,
    -- dependencies = {
    --   {
    --     "AstroNvim/astrocore",
    --     opts = function(_, opts)
    --       local maps = opts.mappings
    --       -- maps.n["<C-n>"] = "<Nop>"
    --       -- maps.n["<C-p>"] = "<Nop>"
    --       maps.n["<M-j>"] = { "<Plug>(VM-Add-Cursor-Down)" }
    --       maps.n["<M-k>"] = { "<Plug>(VM-Add-Cursor-up)" }
    --       maps.n["<M-n>"] = { "<Plug>(VM-Find-Under)" }
    --       maps.x["<M-n>"] = { "<Plug>(VM-Find-Subword-Under)" }
    --     end,
    --   },
    -- },
  },
}
