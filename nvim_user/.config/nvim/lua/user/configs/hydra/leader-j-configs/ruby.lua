local M = {}

function M.config(fn)
  local hint = [[
^ _a_: next params       _A_: previous params
^ _m_: next method       _M_: previous method
^ _c_: next comment      _C_: previous comment
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
        fn({ "def" }, true)
      end,
    },
    {
      "M",
      function()
        fn({ "def" }, false)
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
