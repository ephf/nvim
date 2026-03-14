call plug#begin()

Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'rebelot/kanagawa.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

Plug 'williamboman/mason.nvim'

Plug 'angluca/quark.vim'

Plug 'lewis6991/gitsigns.nvim'

Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'

call plug#end()

se nu rnu ts=4 sw=4 ai si nohls mouse=
colo kanagawa-dragon
hi Error gui=bold,underline
hi Normal guibg=NONE

nn <s-u> <c-r>
tno <esc> <c-\><c-n>
tno <c-w> <c-\><c-n><c-w>

nn <nowait> j gj
nn <nowait> k gk

nn <tab> <c-w>w
tno <tab> <c-w>w

autocmd FileType typst setl spell
autocmd FileType cpp setl filetype=c

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

set noshowmode

nn gb :DapToggleBreakpoint<cr>
nn gn :DapContinue<cr>

lua << EOF

require'lspconfig'.clangd.setup {}
require'lspconfig'.tinymist.setup {
	settings = {
		formatterMode = "typstyle",
		exportPdf = "onType",
		semanticTokens = "disable"
	}
}
require'lspconfig'.vtsls.setup {}

require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "typst", "typescript" },
	highlight = { enable = true },
}

require'mason'.setup {}

require('lualine').setup {
	options = { theme = 'kanagawa' }
}

local dap, dapui = require("dap"), require("dapui")

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

EOF
