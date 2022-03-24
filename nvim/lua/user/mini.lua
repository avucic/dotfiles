--[[ require("mini.surround").setup({
    -- Number of lines within which surrounding is searched
    n_lines = 50,

    -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
    highlight_duration = 500,

    -- Pattern to match function name in 'function call' surrounding
    -- By default it is a string of letters, '_' or '.'
    funname_pattern = "[%w_%.]+",

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
        add = "sa", -- Add surrounding
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn" -- Update `n_lines`
    }
})
 ]]
require("mini.comment").setup({})

require("mini.starter").setup({
	-- Whether to open starter buffer on VimEnter. Not opened if Neovim was
	-- started with intent to show something else.
	autoopen = true,

	-- Whether to evaluate action of single active item
	evaluate_single = false,

	-- Items to be displayed. Should be an array with the following elements:
	-- - Item: table with <action>, <name>, and <section> keys.
	-- - Function: should return one of these three categories.
	-- - Array: elements of these three types (i.e. item, array, function).
	-- If `nil` (default), default items will be used (see |mini.starter|).
	items = nil,

	-- Header to be displayed before items. Should be a string or function
	-- evaluating to single string (use `\n` for new lines).
	-- If `nil` (default), polite greeting will be used.
	header = nil,

	-- Footer to be displayed after items. Should be a string or function
	-- evaluating to string. If `nil`, default usage help will be shown.
	footer = nil,

	-- Array  of functions to be applied consecutively to initial content.
	-- Each function should take and return content for 'Starter' buffer (see
	-- |mini.starter| for more details).
	content_hooks = nil,

	-- Characters to update query. Each character will have special buffer
	-- mapping overriding your global ones. Be careful to not add `:` as it
	-- allows you to go into command mode.
	query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-.]],
})
