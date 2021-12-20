local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

local vim = _G.vim or vim -- suppress warning, allow complete without lua-dev
local api = vim.api

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

api.nvim_exec(
	[[
	augroup Packer
	autocmd!
	autocmd BufWritePost init.lua PackerCompile
	augroup end
	]],
	false
)

local use = require('packer').use
require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'shaunsingh/nord.nvim'
	use 'chriskempson/base16-vim'
	use 'daviesjamie/vim-base16-lightline'
	use 'tpope/vim-commentary'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'
	use 'hrsh7th/vim-vsnip-integ'
	use 'rafamadriz/friendly-snippets'
	use 'windwp/nvim-autopairs'
	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'
	use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	use 'nvim-treesitter/playground'
	use 'tpope/vim-fugitive'
	use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
	use {
		'nvim-telescope/telescope.nvim',
		requires = { 'nvim-lua/plenary.nvim' }
	}
	-- use 'lukas-reineke/indent-blankline.nvim'
	use 'folke/which-key.nvim'
	use 'itchyny/lightline.vim'
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	}
	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "Pocco81/DAPInstall.nvim"}}
	use 'theHamsta/nvim-dap-virtual-text'
	-- use 'ray-x/lsp_signature.nvim'
	use 'folke/lsp-colors.nvim'
	use 'numtostr/FTERM.nvim'
	use 'simrat39/rust-tools.nvim'
	use 'nvim-lua/plenary.nvim'
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

end)
vim.cmd [[colorscheme base16]]
vim.o.shiftwidth=4
vim.o.tabstop=4
vim.o.hlsearch = false
vim.o.autochdir = false
vim.o.relativenumber = true
vim.o.cursorline = false
vim.o.number = true
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevel = 99
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.autowriteall = true
vim.o.updatetime = 250
vim.o.signcolumn = 'no'
vim.o.clipboard = 'unnamedplus'
vim.o.spell = false
vim.o.wrap = true
vim.o.termguicolors = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.nuw = 1
vim.o.autoindent = true
vim.o.grepprg="rg --vimgrep --smart-case --follow"
vim.g.base16colorspace=256
vim.g.lightline = {
	colorscheme = 'base16',
	active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
	component_function = { gitbranch = 'fugitive#head' },
}
vim.g.noshowmode = true
vim.g.netrw_keepdir = 0
-- vim.g.fzf_preview_window = {'up:40%:hidden', 'ctrl-/'}
vim.g.dap_virtual_text = true
vim.o.completeopt = 'menuone,noselect'
if vim.g.vscode == nil then
	require("nvim-autopairs").setup()
	require("nvim-dap-virtual-text").setup()
	require("keys").setup()
	require("golang").setup()
	require("trouble").setup()
end

local nvim_cmp = require('cmp')
local lsp_installer = require("nvim-lsp-installer")
nvim_cmp.setup({
	sources = nvim_cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }
	}),
	snippet = {
		expand = function(args) vim.fn["vsnip#anonymous"](args.body) end
	}
})

lsp_installer.on_server_ready(function(server)
	local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local opts = {
		on_attach = function(_, bufnr)
			api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
		end,
		capabilities = capabilities,
		autostart = true,
	}
	if server.name == "sumneko_lua" then
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand "$VIMRUNTIME/lua"] = true,
						[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
					},
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
			},
		}
	end
	server:setup(opts)
end)

vim.diagnostic.config({
	virtual_text = false
})

require('nvim-treesitter.configs').setup({})
require("dapui").setup({})
local dap_install = require("dap-install")
local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

for _, debugger in ipairs(dbg_list) do
	dap_install.config(debugger)
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

local telescope = require('telescope')
local action_layout = require('telescope.actions.layout')
 -- Telescope
 telescope.setup{
	 defaults = {
		 layout_strategy = "vertical",
		 preview = {
			 hide_on_startup = true,
		 },
		 mappings = {
			 i = {
				 ['<m-p>'] = action_layout.toggle_preview,
			 }
		 }
	 },
 }
telescope.load_extension('fzf')
