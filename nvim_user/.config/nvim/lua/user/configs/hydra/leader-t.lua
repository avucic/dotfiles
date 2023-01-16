local M = {}

function M.setup(Hydra, _, _)
  Hydra({
    name = "Terminal",
    hint = [[
   _t_: default                 _N_: new terminal
   _f_: float                   _F_: new float
   _v_: vertical                _V_: new vertical  ^
   _T_: tab                     _l_: list
   _r_: rename                  _q_: close
]],
    config = {
      color = "teal",
      invoke_on_body = true,
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    mode = { "n" },
    body = "<Leader>t",
    heads = {
      {
        "t",
        -- [[<Cmd>exe v:count1 . "ToggleTerm"<CR>]],
        function()
          require("user.configs.toggleterm").open_terminal("horizontal", 1)
        end,
        { desc = "default", nowait = true, silent = true },
      },
      {
        "r",
        [[<Cmd>ToggleTermSetName<CR>]],
        { desc = "rename", nowait = true, silent = true },
      },
      {
        "f",
        function()
          require("user.configs.toggleterm").open_terminal("float", 1)
        end,
        { desc = "Float", nowait = true },
      },
      {
        "F",
        -- [[<cmd>lua vim.cmd(vim.fn.input('id:') .. "ToggleTerm direction=float")<cr>]],

        function()
          require("user.configs.toggleterm").open_terminal("float")
        end,
        { desc = "float", nowait = true },
      },
      {
        "N",
        -- [[<cmd>lua vim.cmd(vim.fn.input('id:') .. "ToggleTerm")<cr>]],
        function()
          require("user.configs.toggleterm").open_terminal("horizontal", nil)
        end,
        { desc = "New", nowait = true },
      },
      {
        "v",
        function()
          require("user.configs.toggleterm").open_terminal("vertical", 1)
        end,
        { desc = "vertical", nowait = true },
      },
      {
        "V",
        -- [[<cmd>lua vim.cmd(vim.fn.input('id:') .. "ToggleTerm direction=vertical")<cr>]],
        function()
          require("user.configs.toggleterm").open_terminal("vertical")
        end,
        { desc = "new vertical", nowait = true },
      },
      {
        "l",
        "<cmd>lua require('user.plugins.toggleterm_telescope').open()<cr>",
        { desc = "list terminals", nowait = true },
      },
      {
        "T",
        function()
          require("user.configs.toggleterm").open_terminal("tab", 1)
        end,
        { desc = "tab", nowait = true },
      },
      { "q", "<cmd>bd!<cr>", { nowait = true } },
      { "<Esc>", nil, { nowait = true, desc = false } },
    },
  })
end

return M
