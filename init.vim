:startinsert
:syntax on

:set number
:set tabstop=4
:set shiftwidth=4
:set mouse=a

set encoding=UTF-8

call plug#begin('~/.config/nvim/plugged')

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'https://github.com/joshdick/onedark.vim'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/neoclide/coc.nvim'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/akinsho/toggleterm.nvim'

call plug#end()

lua << EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "vim", "c", "javascript" },
	sync_install = false,
	highlight = {
    	enable = true,
	},
}

require'toggleterm'.setup()
EOF

nnoremap <C-f> :NERDTreeToggle<CR>
nnoremap <C-t> :ToggleTerm<CR><C-\><C-n>i
nnoremap <C-w> :wq<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q!<CR>
nnoremap ff <Esc>:NERDTreeFocus<CR>

inoremap <C-f> <Esc>:NERDTreeToggle<CR>
inoremap ff <Esc>:NERDTreeFocus<CR>
inoremap <C-t> <Esc>:ToggleTerm<CR><C-\><C-n>i
inoremap <C-z> <Esc>:undo<CR>i<CR>
inoremap <C-Space> <Esc>
inoremap <C-w> <Esc>:wq<CR>i
inoremap <C-s> <Esc>:w<CR>i
inoremap <C-q> <Esc>:q!<CR>i
inoremap vv <Esc>v

tnoremap <C-Space> <C-\><C-n>
tnoremap <C-q> <C-\><C-n>:ToggleTerm<CR>

let g:NERDTreeDirArrowExpandable=">"
let g:NERDTreeDirArrowCollapsible="v"

let g:airline_powerline_fonts = 1

:colorscheme onedark

" coc defaults

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
