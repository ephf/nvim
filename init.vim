call plug#begin()

Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'master' }

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'rebelot/kanagawa.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

Plug 'williamboman/mason.nvim'

Plug 'lewis6991/gitsigns.nvim'

call plug#end()

se nu rnu ts=4 sw=4 ai si nohls mouse= noshowmode
colo kanagawa
hi Normal guibg=NONE

nn <s-u> <c-r>
tno <esc> <c-\><c-n>
tno <c-w> <c-\><c-n><c-w>

nn <nowait> j gj
nn <nowait> k gk

nn <tab> <c-w>w
tno <tab> <c-w>w

autocmd FileType typst setl spell
autocmd BufRead,BufNewFile *.h setl filetype=c

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

vim.lsp.config("clangd", {})
vim.lsp.config("tinymist", {
	settings = {
		formatterMode = "typstyle",
		exportPdf = "onType",
		semanticTokens = "disable"
	}
})
vim.lsp.config("vtsls", {})
vim.lsp.config("html", {})
vim.lsp.config("rust-analyzer", {})
vim.lsp.config("pyright", {})

vim.lsp.enable("clangd")
vim.lsp.enable("tinymist")
vim.lsp.enable("vtsls")
vim.lsp.enable("html")
vim.lsp.enable("rust-analyzer")
vim.lsp.enable("pyright")

require'nvim-web-devicons'.setup {}

require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "cpp", "typst", "javascript", "css", "typescript", "html", "rust", "python" },
	highlight = { enable = true },
}

require'mason'.setup {}

require('lualine').setup {
	options = { theme = 'kanagawa' }
}

EOF
