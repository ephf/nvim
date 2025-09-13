call plug#begin()

Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'rebelot/kanagawa.nvim'

Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
Plug 'williamboman/mason.nvim'
Plug 'jay-babu/mason-nvim-dap.nvim'

call plug#end()

se nu rnu ts=4 sw=4 ai si nohls mouse=
colo kanagawa
hi Error gui=bold,underline

nn <s-u> <c-r>
tno <esc> <c-\><c-n>
tno <c-w> <c-\><c-n><c-w>

nn qw <c-w>w
nn <s-q><s-w> <c-w><s-w>
tno qw <c-\><c-n><c-w>w
tno <s-q><s-w> <c-\><c-n><c-w><s-w>

nn <nowait> j gj
nn <nowait> k gk

autocmd FileType typst setl spell

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

ino <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
nn <silent><nowait> gd <Plug>(coc-definition)
nn <silent><nowait> gy <Plug>(coc-type-definition)

nn fd <cmd>Telescope find_files<cr>
nn fs <cmd>Telescope live_grep<cr>

lua << EOF

require'lspconfig'.clangd.setup { 
	settings = {
		clangd = {
			InlayHints = { Enabled = false },
		}
	}
}

require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "typst" },
	highlight = { enable = true },
}

require'mason'.setup {}

local dap = require('dap')

dap.adapters.codelldb = {
	type = 'server',
	port = '${port}',
	executable = {
		command = 'codelldb',
		args = { '--port', '${port}' },
	},
}

dap.configurations.c = {
	{
			name = "Launch",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input('Path to executable: ',
					vim.fn.getcwd() .. '/', 'file')
			end,
			cwd = '${workspaceFolder}',
			runInTerminal = false,
	},
}

require'dapui'.setup {}

EOF
