local M = {}


M.lsp_keys = function ()
end

M.setup = function ()
	local vim = _G.vim or vim
	local api = vim.api
	api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
	vim.g.mapleader = ' '
	vim.g.maplocalleader = ';'

	local wk = require("which-key")
	wk.register({
		f = {
			name = "File",
			b = { ":Telescope buffers<cr>", "Buffer" },
			r = { ":Telescope oldfiles<cr>", "Open Recent File" },
			s = { ":Telescope live_grep<cr>", "Rg"},
			f = { ":Telescope find_files<cr>", "Files"},
			n = { ":Telescope file_browser depth=3<cr>", "Browser"},
		},
		t = {
			name = "Cmds",
			t = { '<cmd>lua require("FTerm").toggle()<cr>', "Terminal"},
			c = { ":Telescope command_history<cr>", "Cmds history"},
		},
		b = {
			name = "Buffer",
			b = { ":buffers<cr>:buffer "},
		},
		c = { ":Telescope commands<cr>", "Commands"},
		l = {
			name = "Lsp",
			r = { '<cmd>lua vim.lsp.buf.rename()<cr>', "Rename"},
			a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', "Code action"},
			l = { '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>'},
			h = { '<cmd>lua vim.lsp.buf.hover()<cr>', "Hover"},
			d = { '<cmd>:Telescope lsp_document_symbols<cr>', "Workspace symbols"},
			f = { '<cmd>lua vim.lsp.buf.formatting()<cr>', "Format"},
			s = {
				name = "Server",
				s = { '<cmd>LspStart<cr>', "Start"},
				x = { '<cmd>LspStop<cr>', "Stop"},
				r = { '<cmd>LspRestart<cr>', "Restart"},
				i = { '<cmd>LspInfo<cr>', "Info"},
			},
			q = { '<cmd>TroubleToggle document_diagnostics<cr>', "Trouble" },
			w = { '<cmd>TroubleToggle document_diagnostics<cr>', "Trouble workspace" },
		},
		d = {
			name = "Dap",
			u = { '<cmd>lua require"dapui".toggle()<cr>', "UI"},
			c = { '<cmd>lua require"dap".run_to_cursor()<cr>', "Run to cursor"},
			h = { '<cmd>lua require"dapui".eval()<cr>', "UI Eval"},
			r = { '<cmd>lua require"dap".repl.toggle()<cr>', "Repl"},
			l = { '<cmd>lua require"dap".run_last()<cr>', "Run last configuration"},
			d = { '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<cr>', "Bp condition"},
			x = { '<cmd>lua require"dap".close()<cr>', "Close debug session"},
			p = { '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<cr>', "Log point"},
		},
		g = {
			name = "Git",
			g = { ":Neogit<cr>", "Git"},
			c = { ":Telescope git_commits<cr>", "Commits"},
		},
		n = {
			name = "Neovim",
			r = {":source ~/.config/nvim/init.lua<cr>", "Reloades config"}
		},
		w = { ":wa<cr>", "Write" },
		q = { ":qa<cr>", "Close" }
	}, { prefix = "<leader>" })
	api.nvim_set_keymap('n', 'gD', '<cmd>TroubleToggle vim.lsp.buf.declaration()<cr>', { noremap = true, silent = true })
	api.nvim_set_keymap('n', 'gd', '<cmd>TroubleToggle lsp_definitions<cr>', { noremap = true, silent = true })
	api.nvim_set_keymap('n', 'gi', '<cmd>TroubleToggle vim.lsp.buf.implementation()<cr>', { noremap = true, silent = true })
	api.nvim_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<cr>', { noremap = true, silent = true })
	api.nvim_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', { noremap = true, silent = true })
	api.nvim_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', { noremap = true, silent = true })
	api.nvim_set_keymap('i', '<Tab>', "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'", {expr = true})
	api.nvim_set_keymap('i', '<S-Tab>', "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'", {expr = true})
	api.nvim_set_keymap('n', '<F5>', '<cmd>lua require"dap".continue()<cr>', { noremap = true, silent = true })
	api.nvim_set_keymap('n', '<S-F5>', '<cmd>lua require"dap".close()<cr>', { noremap = true, silent = true })
	api.nvim_set_keymap('n', '<F17>', '<cmd>lua require"dap".close()<cr>', { noremap = true, silent = true })
	api.nvim_set_keymap('n', '<F10>', '<cmd>lua require"dap".step_over()<cr>', { noremap = true, silent = true })
	api.nvim_set_keymap('n', '<S-F11>', '<cmd>lua require"dap".step_out()<cr>', { noremap = true, silent = true })
	api.nvim_set_keymap('n', '<F11>', '<cmd>lua require"dap".step_into()<cr>', { noremap = true, silent = true })
	api.nvim_set_keymap('n', '<F9>', '<cmd>lua require"dap".toggle_breakpoint()<cr>', { noremap = true, silent = true })
end

return M
