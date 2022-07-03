"
"  ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"  ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"  ██║   ██║██║██╔████╔██║██████╔╝██║
"  ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"██╗╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"╚═╝ ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"
" CoC Settings
" source $HOME/.config/nvim/settings.vim

"======================== Plugins =========================

" This is .local/share/nvim/plugged and stores all plugin data
call plug#begin(stdpath('data').'/plugged')

" Autocompletion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Native LSP
Plug 'neovim/nvim-lspconfig'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/deoplete-lsp'
" Plug 'ervandew/supertab'
Plug 'Chiel92/vim-autoformat'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'williamboman/nvim-lsp-installer'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Shows colors of hex values in vim
Plug 'norcalli/nvim-colorizer.lua'

" Puts cursor where it was when the file was last closed
Plug 'farmergreg/vim-lastplace'

" Highlights whitespace in red
Plug 'ntpeters/vim-better-whitespace'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}

" Ranger in nvim
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" Shows git changes in sidebar
Plug 'lewis6991/gitsigns.nvim'

" Lines to show indentation
Plug 'lukas-reineke/indent-blankline.nvim'

" Todo comments
Plug 'folke/todo-comments.nvim'

" Finally can move lines again
Plug 'matze/vim-move'

" Status Line
Plug 'famiu/feline.nvim'

" Wiki :)
Plug 'vimwiki/vimwiki'

" More Rust (Do I need this)
Plug 'rust-lang/rust.vim'

" Easy comments
Plug 'numToStr/Comment.nvim'

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
" Alternative to having vertical line
" match ErrorMsg '\%>80v.\+'
set cc=80
" set signcolumn=number

" Keeps the cursor centered
set scrolloff=999

" Other
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set clipboard+=unnamedplus

" Set <leader>
let mapleader = " "

set nocompatible
filetype plugin on
syntax on

" RUST CONFIG
" setup rust_analyzer LSP (IDE features)
" lua << EOF
" require('lspconfig').rust_analyzer.setup{}
" EOF

" Use LSP omni-completion in Rust files
autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Enable deoplete autocompletion in Rust files
let g:deoplete#enable_at_startup = 1

" customise deoplete                                                                                                                                                     " maximum candidate window length
"call deoplete#custom#source('_', 'max_menu_width', 80)

" Press Tab to scroll _down_ a list of auto-completions
let g:SuperTabDefaultCompletionType = "<c-n>"

" rustfmt on write using autoformat
"autocmd BufWrite * :Autoformat

"TODO: clippy on write
"autocmd BufWrite * :Autoformat

nnoremap <leader>c :!cargo clippy

"NATIVE LSP
lua << EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
-- Enable completion triggered by <c-x><c-o>
vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wl', function()
print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
    }
require('lspconfig')['pyright'].setup{
on_attach = on_attach,
flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
on_attach = on_attach,
flags = lsp_flags,
-- Server-specific settings...
settings = {
    ["rust-analyzer"] = {}
    }
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'ccls', 'rust_analyzer', 'pyright' }
for _, lsp in ipairs(servers) do
lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
    }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
        luasnip.lsp_expand(args.body)
        end,
        },
    mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
        },
    ['<Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        fallback()
        end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
            end
            end, { 'i', 's' }),
            }),
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'nvim_lsp_signature_help' },
        },
    }
EOF

"==========================================================
"
"==================== File Management =====================
lua << EOF
require('Comment').setup()
EOF
"
" Telescope
"
lua << EOF
search_current_directory = function()
require("telescope.builtin").find_files({
prompt_title = "cwd Files",
cwd = vim.fn.expand("%:p").gsub(vim.fn.expand("%:p"), vim.fn.expand("%:t"),""),
    hidden = true,
    })
end
EOF

lua << EOF
require("telescope").setup
require("telescope").load_extension("fzf")
EOF

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope git_files<cr>
nnoremap <leader>fc :lua search_current_directory()<cr>
nnoremap <leader>ft :TodoTelescope<CR>
nnoremap <leader>lg <cmd>Telescope live_grep<cr>

" Ranger
"
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

lua << EOF
-- Sets up treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    ignore_install = { "phpdoc" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
        },
    }

-- Sets up status line with no icons
require('feline').setup ({
})
require('feline.providers.lsp').diagnostics_exist(type)

-- Git change signs in numberline
require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        -- changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
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

" Copy and Paste to System Clipboard
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" Fast Saving and Quitting
nnoremap <leader>s :w!<cr>
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

" " Commenting blocks of code.
" augroup commenting_blocks_of_code
" autocmd!
" autocmd FileType c,cpp,java       let b:comment_leader = '// '
" autocmd FileType sh,ruby,python   let b:comment_leader = '# '
" autocmd FileType conf,fstab       let b:comment_leader = '# '
" autocmd FileType tex              let b:comment_leader = '% '
" autocmd FileType mail             let b:comment_leader = '> '
" autocmd FileType vim              let b:comment_leader = '" '
" autocmd Filetype rust             let b:comment_leader = '// '
" augroup END
"
" " Comments a block of code
" noremap <silent> <Leader>cc :<C-B>silent <C-E>s/^\(\s*\)/\1<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
"
" " Uncomments a block of code
" noremap <silent> <Leader>cu :<C-B>silent <C-E>s/^\(\s*\)\V<C-R>=escape(b:comment_leader,'\/')<CR>/\1/e<CR>:nohlsearch<CR>

" Auto pairs
inoremap {<cr> {<cr>}<c-o><s-o>
inoremap [<cr> [<cr>]<c-o><s-o>
inoremap (<cr> (<cr>)<c-o><s-o>

" Sets the indent guide character
let g:indent_blankline_char = '|'

" Change window title to Neovim - filename
let &titlestring = "Neovim - %t"
set title

" Markdown in calcurse notes
autocmd BufRead,BufNewFile /tmp/calcurse*, ~/.calcurse/notes/* set filetype=markdown

" Easier root editing
cmap w!! w !doas tee > /dev/null %
" Unbinds Q (ex mode)
nnoremap <silent> Q <nop>
"==========================================================
"
"
let g:vimwiki_list = [{'path': '~/.vimwiki/'}]
nmap <silent> cp "_cw<C-R>"<Esc>
