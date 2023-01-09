local M = {}
function M.activate_hydra(opt)
  local opt = opt or {}
  local target = opt.target or false
  local Hydra = require("hydra")
  local aerial = require("aerial")
  local sts = require("syntax-tree-surfer")
  local hint = [[
^ _r_: references           _s_: toggle symbols
^ _n_: next                 _N_: previous
]]

  local heads = {
    {
      "n",
      function()
        aerial.next()
      end,
    },
    {
      "N",
      function()
        aerial.next(-1)
      end,
    },
    {
      "s",
      function()
        vim.cmd([[AerialToggle! right]])
      end,
    },
    {
      "r",
      "<cmd>lua require('telescope.builtin').lsp_references()<CR>",
      { desc = "LSP references", exit = true },
    },
    {
      "<esc>",
      nil,
      { exit = true, nowait = true, desc = false },
    },
  }

  local lang_def = require("user.core.utils").load_module("user.configs.hydra.leader-j-configs." .. vim.bo.filetype)

  if lang_def then
    local fn = sts.filtered_jump
    if target then
      fn = sts.targeted_jump
    end
    local config = lang_def.config(fn)
    hint = hint .. config["hint"]
    local lang_heads = config["heads"]

    for _, v in pairs(lang_heads) do
      table.insert(heads, v)
    end
  end

  local hydra = Hydra({
    name = "Jump",
    hint = hint,
    config = {
      invoke_on_body = true,
      color = "pink",
      hint = {
        position = "bottom",
        border = "rounded",
      },
      -- on_enter = function()
      --   vim.cmd([[AerialOpen!]])
      -- end,
      -- on_exit = function()
      --   vim.cmd([[AerialClose]])
      -- end,
    },
    heads = heads,
  })

  hydra:activate()
end

function M.setup(_, _, _)
  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*.*",
    callback = function()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>j",
        ":lua require('user.configs.hydra.leader-j').activate_hydra()<CR>",
        { noremap = true, silent = true }
      )
    end,
  })

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*.*",
    callback = function()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>J",
        ":lua require('user.configs.hydra.leader-j').activate_hydra({target = true })<CR>",
        { noremap = true, silent = true }
      )
    end,
  })
end

return M
