local M = {}

function M.setup(Hydra, cmd, _)
  local packer_hint = [[
  _c_: compile     _i_: install
  _d_: clean       _s_: sync
  _S_: status      _u_: update
]]

  Hydra({
    name = "Packer",
    hint = packer_hint,
    config = {
      invoke_on_body = true,
      -- color = "pink",
      hint = {
        border = "rounded",
        type = "window",
      },
    },
    mode = "n",
    body = "<Leader>P",
    heads = {
      { "c", cmd("PackerCompile"), { exit = true } },
      { "i", cmd("PackerInstall"), { exit = true } },
      { "d", cmd("PackerClean"), { exit = true } },
      { "S", cmd("PackerStatus"), { exit = true } },
      { "s", cmd("PackerSync"), { exit = true } },
      { "u", cmd("PackerUpdate"), { exit = true } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
