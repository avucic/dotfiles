local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<cr>", function() vim.lsp.buf.definition() end, { desc = "Go to reference", buffer = bufnr })
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Preview note", buffer = bufnr })
vim.keymap.set("n", "<Leader>mi", "<Cmd>IconPickerInsert<cr>", { desc = "Insert icons", buffer = bufnr })
vim.keymap.set("n", "<Leader>ma", "<Cmd>PasteMDLink<cr>", { desc = "Insert link", buffer = bufnr })
-- vim.keymap.set("n", "<Leader>mp", "<cmd>MarkdownPreview<cr>", { desc = "Preview in browser", buffer = bufnr })
vim.keymap.set("n", "<Leader>mp", "<cmd>Vivify<cr>", { desc = "Preview in browser", buffer = bufnr })

vim.keymap.set("n", "<Leader>mu", "", { desc = "Toggle", buffer = bufnr })
vim.keymap.set("n", "<Leader>muc", "<cmd>RenderMarkdown toggle<cr>", { desc = "Render Markdown", buffer = bufnr })

vim.keymap.set("v", "<Leader>mx", "", { desc = "Formatting", buffer = bufnr })
vim.keymap.set("v", "<Leader>mxb", "di**<esc>pa**<esc>", { desc = "Bold text", buffer = bufnr })
vim.keymap.set("v", "<Leader>mxi", "di_<esc>pa_<esc>", { desc = "Italic text", buffer = bufnr })
vim.keymap.set("v", "<Leader>mxs", "di~~<esc>pa~~<esc>", { desc = "Strikethrough text", buffer = bufnr })
vim.keymap.set("v", "<Leader>mxc", "di`<esc>pa`<esc>", { desc = "Code", buffer = bufnr })
