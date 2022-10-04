local M = {}

function M.setup(Hydra, _, _)
  local aerial = require("aerial")
  local sts = require("syntax-tree-surfer")

  local hint = [[
^ _n_: next              _N_: previous
^ _p_: next property     _P_: previous property
^ _m_: next method       _M_: previous method
^ _i_: next import       _I_: previous import
^ _c_: next comment      _C_: previous comment
^ _r_: references        _s_: toggle symbols
^ _j_: jump to any
]]

  local heads = {
    {
      "n",
      function()
        aerial.next()
      end,
    },
    {
      "N",
      function()
        aerial.next(-1)
      end,
    },
    {
      "s",
      function()
        if aerial.is_open() then
          aerial.close()
        else
          aerial.open()
        end
      end,
    },
    {
      "r",
      "<cmd>lua require('telescope.builtin').lsp_references()<CR>",
      { desc = "LSP references", exit = true },
    },
    {
      "p",
      function()
        sts.filtered_jump({ "public_field_definition" }, true)
      end,
    },
    {
      "P",
      function()
        sts.filtered_jump({ "public_field_definition" }, false)
      end,
    },
    {
      "m",
      function()
        -- sts.filtered_jump({ "function_definition" }, false)
        sts.filtered_jump({ "function" }, true)
      end,
    },
    {
      "M",
      function()
        -- sts.filtered_jump({ "function_definition" }, false)
        sts.filtered_jump({ "function" }, false)
      end,
    },
    {
      "i",
      function()
        sts.filtered_jump({ "import_statement" }, true)
      end,
    },
    {
      "I",
      function()
        sts.filtered_jump({ "import_statement" }, false)
      end,
    },
    {
      "c",
      function()
        sts.filtered_jump({ "comment" }, true)
      end,
    },
    {
      "C",
      function()
        sts.filtered_jump({ "comment" }, false)
      end,
    },
    {
      "j",
      function()
        sts.filtered_jump({
          "function",
          "function_definition",
          "if_statement",
          "else_clause",
          "else_statement",
          "elseif_statement",
          "for_statement",
          "while_statement",
          "switch_statement",
        }, true)
      end,
    },
    {
      "J",
      function()
        sts.filtered_jump({
          "function",
          "function_definition",
          "if_statement",
          "else_clause",
          "else_statement",
          "elseif_statement",
          "for_statement",
          "while_statement",
          "switch_statement",
        }, false)
      end,
    },
    -- {
    --   "q",
    --   nil,
    --   { exit = true, nowait = true },
    -- },
    {
      "<esc>",
      nil,
      { exit = true, nowait = true, desc = false },
    },
  }

  Hydra({
    hint = hint,
    name = "Jump",
    config = {
      invoke_on_body = true,
      -- color = "pink",
      hint = {
        position = "bottom",
        border = "rounded",
      },
      on_enter = function()
        aerial.open()
      end,
      on_exit = function()
        aerial.close()
      end,
    },
    mode = { "n" },
    body = "<leader>j",
    heads = heads,
  })
end

return M
