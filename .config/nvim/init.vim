"
"  ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"  ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"  ██║   ██║██║██╔████╔██║██████╔╝██║
"  ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"██╗╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"╚═╝ ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"
" CoC Settings
source $HOME/.config/nvim/settings.vim

"======================== Plugins =========================

" This is .local/share/nvim/plugged and stores all plugin data
call plug#begin(stdpath('data').'/plugged')

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Treesitter, no comment needed
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Shows colors of hex values in vim
Plug 'norcalli/nvim-colorizer.lua'

" Puts cursor where it was when the file was last closed
Plug 'farmergreg/vim-lastplace'

" Highlights whitespace in red
Plug 'ntpeters/vim-better-whitespace'

" Fuzzy finder go brrrrr
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Ranger in nvim
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" Shows git changes in sidebar
Plug 'lewis6991/gitsigns.nvim'

" Lines to show indentation
Plug 'lukas-reineke/indent-blankline.nvim'

" Fancy Todo
Plug 'folke/todo-comments.nvim'

" Finally can move lines again :pray:
Plug 'matze/vim-move'

" Status Line
Plug 'famiu/feline.nvim'

" Allows much faster movement
" Plug 'phaazon/hop.nvim'

call plug#end()
"==========================================================
"
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
set history=10000
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
set showmatch
set updatetime=100
set signcolumn=number

" Keeps the cursor centered
set scrolloff=999

" Other
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set clipboard+=unnamedplus

" Set <leader>
let mapleader = " "

"==========================================================
"
"==================== File Management =====================
"
" Telescope
"
" Written by yours truly ;)
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

let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1
nnoremap <leader>fr :RangerCurrentDirectory<cr>

"==========================================================
"
"======================= Colors/LSP =======================

" Sets colorscheme
source $HOME/.config/nvim/colexdev.vim

set termguicolors
let g:rainbow_active = 1
lua require'colorizer'.setup()

syntax enable
highlight LineNr ctermfg=white

lua <<EOF
-- Sets up treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
    },
}

-- Sets up status line with no icons
require('feline').setup ({
    preset = 'noicon',
})
require('feline.providers.lsp').diagnostics_exist(type)

-- Git change signs in numberline
require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      },
    }

-- Highlights Custom Keywords
require("todo-comments").setup {
  signs = false, -- do not show icons in the signs column
  keywords = {
    FIX = {color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
    TODO = {color = "info" },
    HACK = {color = "warning" },
    WARN = {color = "warning", alt = { "WARNING", "XXX" } },
    PERF = {color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = {color = "hint", alt = { "INFO" } },
  },
  highlight = {
    before = "fg", -- "fg" or "bg" or empty
    keyword = "bg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
    after = "fg", -- "fg" or "bg" or empty
  },
  colors = {
    error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
    warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
    info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
    hint = { "LspDiagnosticsDefaultHint", "#10B981" },
    default = { "Identifier", "#7C3AED" },
  },
}
EOF

"==========================================================
"
"==================== All Other Remaps ====================
"
" Todo Telescope Finger
nnoremap <leader>tt :TodoTelescope<CR>

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

" Keep searching centered
nnoremap n nzzzv
nnoremap J mzJ`z
nnoremap N Nzzzv

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
  autocmd FileType c,cpp,java       let b:comment_leader = '// '
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

" Auto pairs
inoremap {<cr> {<cr>}<c-o><s-o>
inoremap [<cr> [<cr>]<c-o><s-o>
inoremap (<cr> (<cr>)<c-o><s-o>

" Sets the indent guide character
let g:indent_blankline_char = '|'

" Change window title to Neovim
let &titlestring = "Neovim"
set title

" Markdown in calcurse notes
autocmd BufRead,BufNewFile /tmp/calcurse*, ~/.calcurse/notes/* set filetype=markdown

" Easier root editing
cmap w!! w !doas tee > /dev/null %
" Unbinds Q (ex mode)
nnoremap <silent> Q <nop>
"==========================================================
