vim.cmd [[set spell]]

local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<c-q>", ":q<cr>", { desc = "Close", buffer = bufnr })
