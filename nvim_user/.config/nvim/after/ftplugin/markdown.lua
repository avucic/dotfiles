vim.cmd([[
sign define codeblock linehl=@MarkdownCodeBlockBG
sign define hrline linehl=@MarkdownHorizontalLine

" function! MarkdownBlocks()
"     let l:continue = 0
"     execute "sign unplace * file=".expand("%")
"
"     " iterate through each line in the buffer
"     for l:lnum in range(1, len(getline(1, "$")))
"         " detect horizontal Line
"         if getline(l:lnum) =~ "^---$"
"             " place sign
"             execute "sign place ".l:lnum." line=".l:lnum." name=hrline file=".expand("%")
"         endif
"
"         " detect the start fo a code block
"         if getline(l:lnum) =~ "^```.*$" || l:continue
"             " continue placing signs, until the block stops
"             let l:continue = 1
"             " place sign
"             execute "sign place ".l:lnum." line=".l:lnum." name=codeblock file=".expand("%")
"             " stop placing signs
"             if getline(l:lnum) =~ "^```$"
"                 let l:continue = 0
"             endif
"         endif
"
"     endfor
" endfunction

function! MarkdownConceal()
    hi MyStrikethrough gui=strikethrough
    call matchadd('MyStrikethrough', '\~\~\zs.\+\ze\~\~')
    call matchadd('Conceal',  '\~\~\ze.\+\~\~', 10, -1, {'conceal':''})
    call matchadd('Conceal',  '\~\~.\+\zs\~\~\ze', 10, -1, {'conceal':''})
    call matchadd('Conceal',  '\[\ \]', 10, -1, {'conceal':''})
    call matchadd('Conceal',  '\[[xX]\]', 10, -1, {'conceal':''})
    call matchadd('Conceal',  '\[-\]', 10, -1, {'conceal':'☒'})
    call matchadd('Conceal',  '\[\.\]', 10, -1, {'conceal':'⊡'})
    call matchadd('Conceal',  '\[[oO]\]', 10, -1, {'conceal':'⬕'})
    call matchadd('Conceal',  '\~\~\ze.\+\~\~', 10, -1, {'conceal':''})
    call matchadd('Conceal',  '\~\~.\+\zs\~\~\ze', 10, -1, {'conceal':''})
    call matchadd('Conceal',  '^---$', 10, -1, {'conceal':''})

    call matchadd('@MarkdownTag',  '\v#([a-zA-Z_-]\/?)+')
    call matchadd('MyStrikethrough', '\~\~\zs.\+\ze\~\~')

    syn match  mkdListItem    "^\s*[-*+]\s\+"   contains=mkdListTab,mkdListBullet2
    syn match  mkdListItem    "^\s*\d\+\.\s\+"  contains=mkdListTab
    syn match  mkdListTab     "^\s*\*"          contained contains=mkdListBullet1
    syn match  mkdListBullet1 "\*"              contained conceal cchar=•
    syn match  mkdListBullet2 "[-*+]"           contained conceal cchar=•
endfunction

set linebreak
set shiftwidth=4 "TODO fix prettier . this is workaround for list indentation
set syntax=off "TODO fix prettier . this is workaround for list indentation
set foldlevel=99

" block
" au BufWinEnter *.md call MarkdownBlocks()
" au BufWritePost *.md call MarkdownBlocks()
" au InsertLeave *.md call MarkdownBlocks()
" au BufWinLeave *.md call clearmatches()

au BufWinEnter *.md call MarkdownConceal()

]])

local map = require("user.core.utils").define_sts_jump_keymap
map("a", { "inline_link" }, "link")
map("l", { "list_item" }, "list item")
map("c", { "comment" }, "comment")
map("p", { "paragraph" }, "paragraph")

local wk = require("which-key")
wk.register({
	["<leader>m"] = {
		name = "+Markdown",
		t = {
			name = "+Table",
			r = { "<Plug>(table-mode-realign)", "realign" },
			d = {
				name = "+Delete",
				r = { "<Plug>(table-mode-delete-row)", "delete row" },
				c = { "<Plug>(table-mode-delete-column)", "delete column" },
				C = { "<Plug>(table-mode-delete-cell)", "delete cell" },
			},
			["t"] = { "<Plug>(table-mode-tableize)", "tableize" },
			["s"] = { "<Plug>(table-mode-sort)", "sort" },
			i = {
				name = "+Insert",
				c = { "<Plug>(table-mode-insert-column-after)", "insert column after" },
				C = { "<Plug>(table-mode-insert-column-before)", "insert column before" },
			},
			f = {
				name = "+Formula",
				a = { "<Plug>(table-mode-add-formula)", "add formula" },
				e = { "<Plug>(table-mode-eval-formula)", "eval formula" },
			},
			K = { "<Plug>(table-mode-motion-up)<cmd>WhichKey <LT>leader>mt<CR>", "up" },
			J = { "<Plug>(table-mode-motion-down)<cmd>WhichKey <LT>leader>mt<CR>", "down" },
			L = { "<Plug>(table-mode-motion-right)<cmd>WhichKey <LT>leader>mt<CR>", "right" },
			H = { "<Plug>(table-mode-motion-left)<cmd>WhichKey <LT>leader>mt<CR>", "left" },
			["?"] = { "<Plug>(table-mode-echo-cell-map)<cmd>WhichKey <LT>leader>mt<CR>", "Echo cell map" },
		},
		c = {
			name = "+Code",
			e = { "<cmd>FeMaco<cr>", desc = "edit" },
			x = { "<cmd>lua require 'mdeval'.eval_code_block()<cr>", "eval" },
		},
		d = {
			name = "+Diagram",
			h = { "<C-v>h:VBox<CR><cmd>WhichKey <LT>leader>md<CR>", "Left" },
			j = { "<C-v>j:VBox<CR><cmd>WhichKey <LT>leader>md<CR>", "Down" },
			k = { "<C-v>k:VBox<CR><cmd>WhichKey <LT>leader>md<CR>", "Up" },
			l = { "<C-v>l:VBox<CR><cmd>WhichKey <LT>leader>md<CR>", "Right" },
		},
		h = {
			name = "+Header",
			[">"] = { "<ESC>^a#<esc>", "Denote" },
			["<"] = { "<ESC>^x", "Promote" },
		},
		l = {
			name = "+List",
			["l"] = { "I- <esc>", "Make list" },
		},
		i = { ":PasteMDLink<cr>", "Insert link" },
		p = { "<Cmd>MarkdownPreview<CR>", "Markdown preview" },
		s = {
			"<cmd>lua require('user.core.utils').toggle_term_cmd('cd $ZK_NOTEBOOK_DIR && markserv', {direction = 'horizontal'})<CR>",
			"Serve",
		},
	},
}, { buffer = 0, mode = "n" })

wk.register({
	["<leader>m"] = {
		name = "+Markdown",
		d = {
			name = "+Diagram",
			f = { ":VBox<CR>", "Select" },
		},

		b = { "di**<esc>pa**<esc>", "Bold" },
		i = { "di_<esc>pa_<esc>", "Italic" },
		c = { "di`<esc>pa`<esc>", "Code" },
		s = { "di~~<esc>pa~~<esc>", "Strikethrough" },
		t = { "<cmd>AsciiTree<cr>", "Ascii tree" },
		u = { "<cmd>AsciiTreeUndo<cr>", "Ascii tree" },
		l = { "I- <esc>", "Make list" },
	},
}, { buffer = 0, mode = "v" })

vim.api.nvim_buf_set_keymap(0, "n", "<cr>", [[:lua vim.lsp.buf.definition()<CR>]], { desc = "Go to Declaration" })
