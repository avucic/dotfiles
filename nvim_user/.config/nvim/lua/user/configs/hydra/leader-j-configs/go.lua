local M = {}

function M.config(fn)
  local hint = [[
^ _a_: next params          _A_: previous params
^ _m_: next method          _M_: previous method
^ _i_: next import          _I_: previous import
^ _c_: next comment         _C_: previous comment
^ _t_: next type            _T_: previous type
^ _cn_: next const          _Cn_: previous const
]]

  local heads = {
    {
      "a",
      function()
        fn({ "parameter_list" }, true)
      end,
    },
    {
      "A",
      function()
        fn({ "parameter_list" }, false)
      end,
    },
    {
      "m",
      function()
        fn({ "func" }, true)
      end,
    },
    {
      "M",
      function()
        fn({ "func" }, false)
      end,
    },
    {
      "i",
      function()
        fn({ "import" }, true)
      end,
    },
    {
      "i",
      function()
        fn({ "import" }, true)
      end,
    },
    {
      "I",
      function()
        fn({ "import" }, false)
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
        fn({ "type" }, true)
      end,
    },
    {
      "T",
      function()
        fn({ "type" }, false)
      end,
    },
    {
      "cn",
      function()
        fn({ "const" }, true)
      end,
    },
    {
      "Cn",
      function()
        fn({ "const" }, false)
      end,
    },
  }

  return {
    hint = hint,
    heads = heads,
  }
end

return M
