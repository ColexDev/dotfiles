local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

    use "windwp/nvim-autopairs"
    use "protex/better-digraphs.nvim"

    -- LSP
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    -- use "Chiel92/vim-autoformat"
    use { "nvim-treesitter/nvim-treesitter", run = "TSUpdate" }

    -- Cmp
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-path" -- Path completions
    use "hrsh7th/cmp-buffer" -- Buffer completions
    use "hrsh7th/cmp-cmdline" -- Cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp" -- LSP completions

    -- Snippets
    use "L3MON4D3/LuaSnip" -- Snippet engine
    use "rafamadriz/friendly-snippets" -- Imports a lot of snippets

    use "norcalli/nvim-colorizer.lua" -- Shows color for hex values

    -- use "ntpeters/vim-better-whitespace"

    -- Telescope
    use "nvim-telescope/telescope.nvim"
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    use "lewis6991/gitsigns.nvim"

    use "lukas-reineke/indent-blankline.nvim"

    use "folke/todo-comments.nvim"

    use "numToStr/Comment.nvim"

    use "farmergreg/vim-lastplace"

    -- use "bling/vim-bufferline"
    -- use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
    use {'akinsho/bufferline.nvim', tag = "v2.*"}

    -- use {
    --     'nvim-lualine/lualine.nvim',
    --     requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    -- }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            -- 'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    -- use "simrat39/rust-tools.nvim"
    use "vimwiki/vimwiki"
    -- use "tpope/vim-fugitive"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
