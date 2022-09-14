local M = {}

function M.setup()
  vim.cmd([[
    let g:lists_maps_default_enable = false
    let g:lists_maps_default_override = {
        \ 'i_<plug>(lists-new-element)': '<c-t>',
        \ 'i_<plug>(lists-toggle)': '',
        \ '<plug>(lists-toggle)': '<c-y>',
        \}
  ]])
end

return M
