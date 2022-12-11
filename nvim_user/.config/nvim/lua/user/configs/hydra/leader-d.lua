local M = {}

function M.setup(Hydra, _, _)
  local hint = [[
  _o_: open                  _d_: start debug
  _c_: continue              _q_: close
  _b_: toggl ebreakpoint     _:_: repl
  _n_: step over             _i_: step into
  _p_: step out              _u_: toggle ui
]]

  Hydra({
    name = "Debug",
    hint = hint,
    config = {
      on_key = false,
      invoke_on_body = true,
      color = "pink",
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    mode = "n",
    body = "<Leader>d",
    heads = {
      {
        "o",
        "<cmd>lua require('vstask').load_dap_tasks()<cr><cmd>lua require('dap').continue()<cr>",
        { desc = "Open" },
      },
      {
        "d",
        "<cmd>lua require('vstask').load_dap_tasks()<cr><cmd>lua require('dap').continue()<cr>",
        { desc = "Start Debug", nowait = true },
      },
      {
        "c",
        "<cmd>lua require('vstask').load_dap_tasks()<cr><cmd>lua require('dap').continue()<cr><cmd>lua require('dap').continue()<cr>",
        { desc = "Start Debug" },
      },
      {
        "q",
        "<cmd>lua require('dap').close()<cr><cmd>lua require('dap').disconnect()<cr><cmd>lua require('dapui').close()<cr><cmd>lua require('dap').repl.close()<cr>",
        { desc = "Close" },
      },

      { "b", "<cmd>lua require('dap').toggle_breakpoint()<cr>", { desc = "Toggle breakpoint" } },
      { ":", "<cmd>lua require('dap').repl.toggle()<cr>", { desc = "Repl" } },
      { "n", "<cmd>lua require('dap').step_over()<cr>", { desc = "Step over" } },
      { "i", "<cmd>lua require('dap').step_into()<cr>", { desc = "Step knto" } },
      { "p", "<cmd>lua require('dap').step_out()<cr>", { desc = "Step out" } },
      { "u", "<cmd>lua require('dapui').toggle()<cr>", { desc = "Toggle UI" } },
      -- h = { "<cmd>lua require('dap.ui.variables').hover()<cr>", "Variable Hover" },
      -- v = { "<cmd>lua require('dap.ui.variables').hover()<cr>", "Variable Hover Visual" },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
