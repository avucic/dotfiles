local M = {}

function M.config()
  require("rest-nvim").setup({
    -- Open request results in a horizontal split
    result_split_horizontal = false,
    -- Keep the http file buffer above|left when split horizontal|vertical
    result_split_in_place = false,
    -- Skip SSL verification, useful for unknown certificates
    skip_ssl_verification = true,
    -- Highlight request on run
    highlight = {
      enabled = true,
      timeout = 150,
    },
    result = {
      -- toggle showing URL, HTTP info, headers at top the of result window
      show_url = true,
      show_http_info = true,
      show_headers = true,
    },
    -- Jump to request line on run
    jump_to_request = false,
    env_file = ".env",
    custom_dynamic_variables = {},
    yank_dry_run = true,
  })

  vim.cmd([[
  augroup _keybinding
    au!
    autocmd FileType http nnoremap <buffer> <CR> <plug>RestNvim<CR>
    autocmd FileType http nnoremap <buffer> <S-CR> <plug>RestNvimLast<CR>
    autocmd FileType http nnoremap <buffer> P <plug>RestNvimPreview<CR>
  augroup end
]])
end

return M