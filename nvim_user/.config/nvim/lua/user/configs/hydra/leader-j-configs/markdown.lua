local M = {}

function M.config(fn)
  local hint = [[
^ _a_: next link            _A_: previous link
^ _c_: next comment         _C_: previous comment
^ _l_: next list item       _L_: previous list item ^
^ _p_: next paragraph       _P_: previous paragraph
]]

  local heads = {
    {
      "a",
      function()
        fn({ "inline_link" }, true)
      end,
    },
    {
      "A",
      function()
        fn({ "inline_link" }, false)
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
    {
      "p",
      function()
        fn({ "paragraph" }, true)
      end,
    },
    {
      "P",
      function()
        fn({ "paragraph" }, false)
      end,
    },
  }

  return {
    hint = hint,
    heads = heads,
  }
end

return M
