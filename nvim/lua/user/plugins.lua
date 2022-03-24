local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")
	use("nvim-lualine/lualine.nvim")
	use("akinsho/toggleterm.nvim")
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("goolord/alpha-nvim")
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("folke/which-key.nvim")
	use({
		"phaazon/hop.nvim",
		branch = "v1", -- optional but strongly recommended
	})
	use({ "unblevable/quick-scope" })
	use({
		"mg979/vim-visual-multi",
		branch = "master",
	})
	use("mfussenegger/nvim-dap")
	use({
		"yriveiro/dap-go.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("tpope/vim-surround")
	use("suketa/nvim-dap-ruby")
	use("windwp/nvim-spectre")
	use({
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	})
	use("andymass/vim-matchup")
	use("ii14/exrc.vim")
	use("nyngwang/NeoZoom.lua")

	-- navigate between splits and tmux panes
	use({ "numToStr/Navigator.nvim" })

	use({ "rcarriga/nvim-notify" })
	-- Colorschemes
	-- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	use("navarasu/onedark.nvim")

	-- cmp plugins
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" }, -- path completions
			{ "hrsh7th/cmp-cmdline" }, -- cmdline completions
			{ "hrsh7th/cmp-vsnip" },
			{ "saadparwaiz1/cmp_luasnip" }, -- snippet completions
			{ "f3fora/cmp-spell", { "hrsh7th/cmp-calc" } },
		},
	})

	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
	--[[ use({
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
		},
	}) ]]

	-- pictograms
	use({ "onsails/lspkind-nvim", requires = { { "famiu/bufdelete.nvim" } } })

	use({
		"kevinhwang91/nvim-bqf",
		requires = { { "junegunn/fzf", module = "nvim-bqf" } },
	})

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	-- use("lukas-reineke/lsp-format.nvim")
	-- use 'leoluz/nvim-dap-go'

	-- use "tami5/lspsaga.nvim" -- fork

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")
	use("nvim-telescope/telescope-ui-select.nvim")
	use("nvim-telescope/telescope-media-files.nvim")
	use("nvim-telescope/telescope-symbols.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		requires = {
			{ "b3nj5m1n/kommentary" },
		},
	})
	use("nvim-treesitter/nvim-treesitter-textobjects")

	-- Git
	use("lewis6991/gitsigns.nvim")
	use("APZelos/blamer.nvim")
	use("kdheepak/lazygit.nvim")
	use({
		"TimUntersberger/neogit",
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
