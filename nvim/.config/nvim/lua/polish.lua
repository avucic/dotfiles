vim.opt.relativenumber = false
vim.opt.conceallevel = 2
vim.opt.spell = true
-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
--
vim.filetype.add {
  filename = {
    ["todo.txt"] = "todotxt",
    ["done.txt"] = "todotxt",
  },
}
