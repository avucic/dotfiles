return function(_, opts)
  local actions = require("glance").actions

  require("glance").setup({
    zindex = 1000,

    -- By default glance will open preview "embedded" within your active window
    -- when `detached` is enabled, glance will render above all existing windows
    -- and won't be restiricted by the width of your active window
    detached = false,
    mappings = {
      list = {
        ["j"] = actions.next, -- Bring the cursor to the next item in the list
        ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
        ["<Down>"] = actions.next,
        ["<Up>"] = actions.previous,
        ["<Tab>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
        ["<S-Tab>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
        ["<C-u>"] = actions.preview_scroll_win(5),
        ["<C-d>"] = actions.preview_scroll_win(-5),
        ["v"] = actions.jump_vsplit,
        ["s"] = actions.jump_split,
        ["t"] = actions.jump_tab,
        ["<CR>"] = actions.jump,
        ["o"] = actions.jump,
        ["<space>"] = actions.enter_win("preview"), -- Focus preview window
        ["q"] = actions.close,
        ["Q"] = actions.close,
        ["<Esc>"] = actions.close,
        ["<c-j>"] = actions.close,
        ["<c-k>"] = actions.close,
        ["<c-l>"] = actions.close,
        ["<c-h>"] = actions.close,
        -- ['<Esc>'] = false -- disable a mapping
      },
      preview = {
        ["Q"] = actions.close,
        ["q"] = actions.close,
        ["<c-j>"] = actions.close,
        ["<c-k>"] = actions.close,
        ["<c-l>"] = actions.close,
        ["<c-h>"] = actions.close,
        ["<Tab>"] = actions.next_location,
        ["<S-Tab>"] = actions.previous_location,
        ["<space>"] = actions.enter_win("list"), -- Focus list window
      },
    },
  })
end
