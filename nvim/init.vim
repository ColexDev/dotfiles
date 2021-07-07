" Get Coc Settings
source $HOME/.config/nvim/general/settings.vim

" Plugins
call plug#begin(stdpath('data').'/plugged')

Plug 'RRethy/nvim-base16'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'francoiscabrol/ranger.vim'
" Plug 'rbgrouleff/bclose.vim'

call plug#end()

" Tab/Indent Settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

" History
set history=1000
set nobackup
set nowritebackup
set noswapfile
set hidden

" Search
set incsearch
set ignorecase
set smartcase

" Colors
syntax enable
colorscheme base16-summerfruit-dark
let g:airline_theme = "minimalist"
highlight LineNr ctermfg=white
lua require('base16-colorscheme').setup({
    \ base00 = '#000000', base01 = '#202020', base02 = '#303030', base03 = '#505050',
    \ base04 = '#b0b0b0', base05 = '#d0d0d0', base06 = '#e0e0e0', base07 = '#ffffff',
    \ base08 = '#ffffff', base09 = '#fd8900', base0A = '#aba900', base0B = '#11b224',
    \ base0C = '#1faaaa', base0D = '#3777e6', base0E = '#ad00a1', base0F = '#cc6633'
    \})
lua require'colorizer'.setup()
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    },
}
EOF

let g:lightline = {
      \ 'colorscheme': 'simpleblack',
      \ }
" UI
set wrap
set encoding=utf-8
set pumheight=10
set ruler
set number
set relativenumber
set noshowmode
set cursorline
set wrapmargin=2
set scrolloff=15
set updatetime=300
set showmatch
set mat=2
set magic

" Other
set mouse=a
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set clipboard+=unnamedplus
set wildmode=longest,list,full
set splitbelow splitright

" Remaps
let mapleader = " "

" Copy and Paste to System Clipboard
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" Fast Saving and Quitting
nnoremap <leader>w :w!<cr>
nnoremap <leader>q :wq!<cr>
nnoremap <leader>Q :q!<cr>

" This unsets the last search pattern register by hitting escape
nnoremap <ESC> :noh<ESC><ESC>

" Move lines using Ctrl+j/k
nnoremap <C-j> mz:m+<cr>`z
nnoremap <C-k> mz:m-2<cr>`z
vnoremap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z

" autocmd InsertEnter * norm zz
autocmd BufWritePre * %s/\s\+$//e
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

inoremap {<cr> {<cr>}<c-o><s-o>
inoremap [<cr> [<cr>]<c-o><s-o>
inoremap (<cr> (<cr>)<c-o><s-o>
