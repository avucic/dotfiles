local M = {}
local splits = require("smart-splits")

function M.setup(Hydra, cmd, pcmd)
  local buffer_hydra = Hydra({
    name = "Buffers",
    config = {
      on_key = function()
        -- Preserve animation
        vim.wait(200, function()
          vim.cmd("redraw")
        end, 30, false)
      end,
    },
    heads = {
      {
        "h",
        function()
          vim.cmd("BufferLineCyclePrev")
        end,
        { on_key = false },
      },
      {
        "l",
        function()
          vim.cmd("BufferLineCycleNext")
        end,
        { desc = "choose", on_key = false },
      },

      {
        "H",
        function()
          vim.cmd("BufferLineMovePrev")
        end,
      },
      {
        "L",
        function()
          vim.cmd("BufferLineMoveNext")
        end,
        { desc = "move" },
      },

      {
        "P",
        function()
          vim.cmd("BufferLIneTogglePin")
        end,
        { desc = "pin" },
      },
      {
        "q",
        function()
          vim.cmd("Bdelete!")
        end,
        { desc = "close" },
      },
      {
        "d",
        "<cmd>w | %bd | e#<CR>",
        { desc = "close others" },
      },

      {
        "p",
        function()
          vim.cmd("BufferLinePick")
        end,
        { desc = "close others" },
      },
      {
        "oe",
        function()
          vim.cmd("BufferLineSortByExtension")
        end,
        { desc = "by directory" },
      },
      {
        "od",
        function()
          vim.cmd("BufferLineSortByDirectory")
        end,
        { desc = "by directory" },
      },
      {
        "or",
        function()
          vim.cmd("BufferLineSortByRelativeDirectory")
        end,
        { desc = "by directory" },
      },
      { "<Esc>", nil, { exit = true } },
    },
  })

  local tab_hydra = Hydra({
    name = "Tabs",
    config = {
      on_key = false,
    },
    heads = {
      {
        "t",
        function()
          require("telescope-tabs").list_tabs()
        end,
        {
          exit = true,
        },
      },
      {
        "n",
        function()
          vim.cmd("tabnew")
        end,
        { on_key = false },
      },
      {
        "q",
        function()
          vim.cmd("tabclose")
        end,
        { desc = "choose", on_key = false },
      },
      { "<Esc>", nil, { exit = true } },
    },
  })

  local function choose_buffer()
    if #vim.fn.getbufinfo({ buflisted = true }) > 1 then
      buffer_hydra:activate()
    end
  end

  local function choose_tab()
    tab_hydra:activate()
  end

  vim.keymap.set("n", "gb", choose_buffer)

  Hydra({
    name = "Windows",
    hint = [[
 ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split     ^^    Select
 ^^^^^^^^^^^^-------------  ^^-----------^^   ^^-------------- ^^---------------
 ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontal _p_: pick
 _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically  _o_: remain only
 ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   ^^               _q_, _c_: close
 focus^^^^^^  window^^^^^^  ^_=_: equalize^
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^_z_: maximize
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^_|_: maximize ver^
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^_-_: maximize hor^
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^
 _b_: choose buffer         ^ ^ ^  _t_: choose tabs
]],
    config = {
      invoke_on_body = true,
      color = "pink",
      hint = {
        border = "rounded",
        offset = -1,
      },
    },
    mode = "n",
    body = "<C-w>",
    heads = {
      -- { "h", cmd("NavigatorLeft") },
      -- { "j", cmd("NavigatorDown") },
      -- { "k", cmd("NavigatorUp") },
      -- { "l", cmd("NavigatorRight") },
      { "h", "<C-w>h" },
      { "j", "<C-w>j" },
      { "k", pcmd("wincmd k", "E11", "close") },
      { "l", "<C-w>l" },

      { "H", cmd("WinShift left") },
      { "J", cmd("WinShift down") },
      { "K", cmd("WinShift up") },
      { "L", cmd("WinShift right") },

      {
        "<C-h>",
        function()
          splits.resize_left(2)
        end,
      },
      {
        "<C-j>",
        function()
          splits.resize_down(2)
        end,
      },
      {
        "<C-k>",
        function()
          splits.resize_up(2)
        end,
      },
      {
        "<C-l>",
        function()
          splits.resize_right(2)
        end,
      },
      -- { "=", "<cmd>FocusEqualise<CR><cmd>FocusDisable<CR>", { desc = "equalize" } },
      { "=", "<cmd>WindowsEqualize<CR><cmd>WindowsDisableAutowidth<cr>", { desc = "equalize" } },

      { "s", pcmd("split", "E36") },
      { "<C-s>", pcmd("split", "E36"), { desc = false } },
      { "v", pcmd("vsplit", "E36") },
      { "<C-v>", pcmd("vsplit", "E36"), { desc = false } },

      { "w", "<C-w>w", { exit = true, desc = false } },
      { "<C-w>", "<C-w>w", { exit = true, desc = false } },

      -- { "z", "<cmd>FocusEnable<CR>:FocusSplitCycle<CR>", { desc = "maximize" } },
      { "z", "<cmd>WindowsMaximize<CR><cmd>WindowsEnableAutowidth<cr>", { desc = "maximize" } },
      { "|", "<cmd>WindowsMaximizeHorizontally<CR><cmd>WindowsEnableAutowidth<cr>", { desc = "maximize vertically" } },
      {
        "-",
        "<cmd>WindowsMaximizeVertically<CR><cmd>WindowsEnableAutowidth<cr>",
        { desc = "maximize horizontally" },
      },
      { "<C-z>", cmd("MaximizerToggle!"), { exit = true, desc = false } },

      { "o", "<C-w>o", { exit = true, desc = "remain only" } },
      { "<C-o>", "<C-w>o", { exit = true, desc = false } },
      -- { "p", "<cmd>lua require('user.core.utils').focus_window()<cr>", { exit = true, desc = false } },
      { "p", "<cmd>lua require('nvim-window').pick()<cr>", { exit = true, desc = false } },

      { "b", choose_buffer, { exit = true, desc = "choose buffer" } },
      { "t", choose_tab, { exit = true, desc = "choose tabs" } },

      { "c", pcmd("close", "E444") },
      { "q", "<cmd>:q<cr>", { desc = "close window" } },
      { "<C-c>", pcmd("close", "E444"), { desc = false } },
      { "<C-q>", pcmd("close", "E444"), { desc = false } },

      { "<Esc>", nil, { exit = true, desc = false, nowait = true } },
    },
  })
end
return M
