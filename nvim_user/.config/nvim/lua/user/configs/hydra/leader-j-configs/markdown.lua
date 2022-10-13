local M = {}

function M.config(fn)
  local hint = [[
^ _a_: next link            _A_: previous link
^ _c_: next comment         _C_: previous comment
^ _l_: next list item       _L_: previous list item
]]

  local heads = {
    {
      "a",
      function()
        fn({ "shortcut_link" }, true)
      end,
    },
    {
      "A",
      function()
        fn({ "shortcut_link" }, false)
      end,
    },
    {
      "l",
      function()
        fn({ "list_item" }, true)
      end,
    },
    {
      "L",
      function()
        fn({ "list_item" }, false)
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
