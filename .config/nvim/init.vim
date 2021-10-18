" Get Coc Settings
source $HOME/.config/nvim/general/settings.vim

" Plugins

" This is in .local/share/nvim/plugged and stores all plugin data
call plug#begin(stdpath('data').'/plugged')

" Shows colors of hex values in vim
Plug 'norcalli/nvim-colorizer.lua'

" Autocompletion (also has discord RPC plugin)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Status line
Plug 'itchyny/lightline.vim'

" LSP
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Puts cursor where it was when the file was last closed
Plug 'farmergreg/vim-lastplace'

" Highlights whitespace in red
Plug 'ntpeters/vim-better-whitespace'

" Allows much faster movement
Plug 'phaazon/hop.nvim'

" Fuzzy finder go brrrrr
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Ranger in nvim lessss go
Plug 'kevinhwang91/rnvimr'

" Plug 'mhinz/vim-signify'
call plug#end()

" Set <leader>
let mapleader = " "

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

" File management
" Telescope
let pwd = system('pwd')
lua << EOF
search_current_directory = function()
    require("telescope.builtin").find_files({
    prompt_title = "< PWD >",
    cwd = vim.fn.expand("%:p").gsub(vim.fn.expand("%:p"), vim.fn.expand("%:t"),""),
    hidden = true,
})
end
EOF
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fc :lua search_current_directory()<cr>


" Ranger
" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1

nnoremap <leader>fr :RnvimrToggle<cr>


" Colors

" Sets colorscheme
source $HOME/.config/nvim/colexdev.vim

set termguicolors
lua require'colorizer'.setup()
syntax enable
highlight LineNr ctermfg=white
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
    },
}
EOF


" Sets lightline colorscheme
let g:lightline = {
      \ 'colorscheme': 'simpleblack',
      \ }

" HOP Colors
hi HopNextKey guifg=#cc0000
hi HopNextKey1 guifg=#cc0000
hi HopNextKey2 guifg=#cc0000
hi HopUnmatched guifg=#505050

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
" Comments a block of code
noremap <silent> <Leader>cc :<C-B>silent <C-E>s/^\(\s*\)/\1<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
" Uncomments a block of code
noremap <silent> <Leader>cu :<C-B>silent <C-E>s/^\(\s*\)\V<C-R>=escape(b:comment_leader,'\/')<CR>/\1/e<CR>:nohlsearch<CR>

" Change all instances of a word (press '.' to change the next)
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

" HOP
lua require'hop'.setup {keys='asdfghjkl;'}
map s <cmd>HopChar1<CR>
omap s v<cmd>HopChar1<CR>

