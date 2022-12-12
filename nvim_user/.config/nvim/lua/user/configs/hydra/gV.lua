local M = {}

function M.setup(Hydra, _, _)
  local treesitter_incsel = require("nvim-treesitter.incremental_selection")

  Hydra({
    name = "visual selection",
    config = {
      on_key = false,
      invoke_on_body = true,
      color = "pink",
      on_enter = function()
        treesitter_incsel.init_selection()
      end,
    },
    mode = { "n" },
    body = "gV",
    heads = {
      {
        "a",
        [[:lua require'nvim-treesitter.incremental_selection'.node_incremental()<cr>]],
        { private = true, mode = "v" },
      },
      {
        "d",
        [[:lua require'nvim-treesitter.incremental_selection'.node_decremental()<cr>]],
        { private = true, mode = "v" },
      },
      { "<Esc>", "<esc>", { exit = true, nowait = true, desc = false, mode = "v" } },
    },
  })
end

return M
