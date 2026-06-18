local M = {}

function M.setup() vim.api.nvim_create_user_command("GenPass", M.generate, { desc = "Generate password", nargs = 1 }) end

function M.generate(opts) io.popen("psd " .. opts.args .. "|pbcopy") end

return M
