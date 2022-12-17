local M = {}

function M.config(fn)
  local hint = [[
^ _a_: next params          _A_: previous params
^ _m_: next method          _M_: previous method
^ _l_: next local           _L_: previous local
^ _c_: next comment         _C_: previous comment ^
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
        fn({ "function" }, true)
      end,
    },
    {
      "M",
      function()
        fn({ "function" }, false)
      end,
    },
    {
      "l",
      function()
        fn({ "local" }, true)
      end,
    },
    {
      "L",
      function()
        fn({ "local" }, false)
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
  }

  return {
    hint = hint,
    heads = heads,
  }
end

return M
