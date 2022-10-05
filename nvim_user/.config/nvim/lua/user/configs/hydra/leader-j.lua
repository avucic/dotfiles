local M = {}
function M.activate_hydra()
  local Hydra = require("hydra")
  local aerial = require("aerial")
  local sts = require("syntax-tree-surfer")
  local hint = [[
^ _r_: references        _s_: toggle symbols
^ _n_: next              _N_: previous
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
        if aerial.is_open() then
          aerial.close()
        else
          aerial.open()
        end
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
    local config = lang_def.config(sts.targeted_jump)
    hint = hint .. config["hint"]
    local lang_heads = config["heads"]

    for k, v in pairs(lang_heads) do
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
      on_enter = function()
        aerial.open()
      end,
      on_exit = function()
        aerial.close()
      end,
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
end

return M
