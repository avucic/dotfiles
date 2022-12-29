local M = {}

function M.config(fn)
  local hint = [[
^ _S_: style                _J_: js
^ _e_: next element         _E_: previous element ^
]]

  local heads = {
    {
      "J",
      function()
        fn({ "script_element" })
      end,
    },
    {
      "S",
      function()
        fn({ "style_element" }, true)
      end,
    },
    {
      "e",
      function()
        fn({ "element" }, true)
      end,
    },
    {
      "E",
      function()
        fn({ "element" }, false)
      end,
    },
  }

  return {
    hint = hint,
    heads = heads,
  }
end

return M
