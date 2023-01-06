local M = {}

function M.config(fn)
  local hint = [[
^ _m_: next method          _M_: previous method
^ _i_: next use             _I_: previous use
^ _c_: next comment         _C_: previous comment
^ _t_: next type            _T_: previous type
^ _l_: next let             _L_: previous let
]]

  local heads = {
    -- {
    --   "a",
    --   function()
    --     fn({ "parameter_list" }, true)
    --   end,
    -- },
    -- {
    --   "A",
    --   function()
    --     fn({ "parameter_list" }, false)
    --   end,
    -- },
    {
      "m",
      function()
        fn({ "fn" }, true)
      end,
    },
    {
      "M",
      function()
        fn({ "fn" }, false)
      end,
    },
    {
      "i",
      function()
        fn({ "use" }, true)
      end,
    },
    {
      "I",
      function()
        fn({ "use" }, false)
      end,
    },
    {
      "c",
      function()
        fn({ "comment" }, true)
      end,
    },
    {
      "C",
      function()
        fn({ "comment" }, false)
      end,
    },
    {
      "t",
      function()
        fn({ "type", "struct", "impl", "trait" }, true)
      end,
    },
    {
      "T",
      function()
        fn({ "type", "struct", "impl", "trait" }, false)
      end,
    },
    {
      "l",
      function()
        fn({ "let" }, true)
      end,
    },
    {
      "L",
      function()
        fn({ "let" }, false)
      end,
    },
  }

  return {
    hint = hint,
    heads = heads,
  }
end

return M
