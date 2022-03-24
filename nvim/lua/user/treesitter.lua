local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.embedded_template = {
	install_info = {
		url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
		files = { "src/parser.c" },
		requires_generate_from_grammar = true,
	},
	used_by = { "eruby", "erb" },
}

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"cmake",
		"dockerfile",
		"go",
		"hcl",
		"html",
		"javascript",
		"json",
		"ledger",
		"lua",
		"python",
		"yaml",
		--"eruby",
		"markdown",
	}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	ignore_install = {}, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = true,
		disable = {}, -- list of language that will be disabled
	},
    matchup = {
      enable = false, -- mandatory, false will disable the whole extension
      -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
    },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			scope_incremental = "<CR>",
			node_incremental = "<TAB>",
			node_decremental = "<S-TAB>",
		},
	},
	indent = { enable = true },
	autopairs = { { enable = true } },
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["ib"] = "@block.inner",
				["ab"] = "@block.outer",
				["ir"] = "@parameter.inner",
				["ar"] = "@parameter.outer",
			},
		},
	},
	rainbow = {
		enable = true,
		extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
		max_file_lines = 2000, -- Do not enable for files with more than specified lines
	},
	-- context_commentstring = {
	-- 	enable = true,
	-- 	config = {
	-- 		eruby = "<#= %s",
	-- 	},
	-- },
})
