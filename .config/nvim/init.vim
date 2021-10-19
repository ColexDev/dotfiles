" Get Coc Settings
source $HOME/.config/nvim/general/settings.vim

"======================== Plugins =========================

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

"==========================================================

"====================== General Sets ======================
"
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

" UI
set wrap
set encoding=utf-8
set number
set relativenumber
set cursorline
set scrolloff=999
set showmatch

" Other
set mouse=a
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set clipboard+=unnamedplus
set wildmode=longest,list,full
set splitbelow splitright

" Set <leader>
let mapleader = " "

"==========================================================

"==================== File Management =====================
"
" Telescope
lua << EOF
search_current_directory = function()
    require("telescope.builtin").find_files({
    prompt_title = "PWD Files",
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

"==========================================================

"========================= Colors =========================

" Sets colorscheme
source $HOME/.config/nvim/colexdev.vim

let g:rainbow_active = 1

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

"==========================================================

"==================== All Other Remaps ====================
"
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

" THIS IS REALLY SLOW FOR SOME REASON RN, IF THAT CAN BE FIXED I WILL USE AGAIN
" Move lines using Ctrl+j/k
" nnoremap <C-j> :m .+1<CR>==
" nnoremap <C-k> :m .-2<CR>==
" vnoremap <C-j> :m '>+1<CR>gv=gv
" vnoremap <C-k> :m '<-2<CR>gv=gv

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

" Change all instances of a word (press '.' to change the next)
nnoremap cn *``cgn
nnoremap cN *``cgN

" Creates an underline based on the length of the above line
nnoremap <leader>ul mmyypVr-<Esc>`m

" Place timestamps, be it date (YYYY-MM-DD) or time (HH:MM:SS).
if (exists("*strftime"))
	noremap <silent> <leader>date "=strftime("%F")<CR>p9h
	noremap <silent> <leader>time "=strftime("%T")<CR>p7h
endif

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

" HOP remaps
lua require'hop'.setup {keys='asdfghjkl;'}
map s <cmd>HopChar1<CR>
omap s v<cmd>HopChar1<CR>

"==========================================================
