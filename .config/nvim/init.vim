" Get Coc Settings
source $HOME/.config/nvim/general/settings.vim

" Plugins
call plug#begin(stdpath('data').'/plugged')
Plug 'RRethy/nvim-base16'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'francoiscabrol/ranger.vim'
Plug 'preservim/nerdtree'
Plug 'farmergreg/vim-lastplace'
Plug 'tomasiser/vim-code-dark'
Plug 'ntpeters/vim-better-whitespace'
" Plug 'mhinz/vim-signify'
call plug#end()
let g:rainbow_active = 1

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

set termguicolors

" Colors
lua require'colorizer'.setup()
syntax enable
let g:airline_theme = "minimalist"
highlight LineNr ctermfg=white
colorscheme codedark
" colorscheme codedark
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
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
set scrolloff=999
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

" Enable folding
"set foldmethod=indent
"set foldlevel=99
"nnoremap <leader> za

" Set <leader>
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

" : is the opposite of ;
" noremap : ,
" noremap <CR> :

" Move lines using Ctrl+j/k
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv
" These do not auto indent like the ones above
" vnoremap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
" vnoremap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z

" autocmd InsertEnter * norm zz
autocmd BufWritePre * %s/\s\+$//e
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

inoremap {<cr> {<cr>}<c-o><s-o>
inoremap [<cr> [<cr>]<c-o><s-o>
inoremap (<cr> (<cr>)<c-o><s-o>

" Keep searching centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Fits other keybinds, allows faster movement
nnoremap J 10j
nnoremap K 10k
nnoremap H 0
nnoremap L $

" Undo break points
" inoremap , ,<c-g>u
" inoremap . .<c-g>u
" inoremap ! !<c-g>u
" inoremap ? ?<c-g>u

" Commenting blocks of code.
augroup commenting_blocks_of_code
  autocmd!
  autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
  autocmd FileType sh,ruby,python   let b:comment_leader = '# '
  autocmd FileType conf,fstab       let b:comment_leader = '# '
  autocmd FileType tex              let b:comment_leader = '% '
  autocmd FileType mail             let b:comment_leader = '> '
  autocmd FileType vim              let b:comment_leader = '" '
augroup END
noremap <silent> <Leader>cc :<C-B>silent <C-E>s/^\(\s*\)/\1<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <Leader>cu :<C-B>silent <C-E>s/^\(\s*\)\V<C-R>=escape(b:comment_leader,'\/')<CR>/\1/e<CR>:nohlsearch<CR>

" Change all instances of a word (press '.' to change them)
nnoremap cn *``cgn
nnoremap cN *``cgN

" NerdTree remaps
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>N :NERDTreeToggle<CR>


" Creates an underline based on the length of the above line
nnoremap <leader>ul mmyypVr-<Esc>`m

" Place timestamps, be it date (YYYY-MM-DD) or time (HH:MM:SS).
if (exists("*strftime"))
	noremap <silent> <leader>date "=strftime("%F")<CR>p9h
	noremap <silent> <leader>time "=strftime("%T")<CR>p7h
endif
