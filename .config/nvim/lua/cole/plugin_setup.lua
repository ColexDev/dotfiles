-- Comment.nvim
require('Comment').setup()

-- Telescope
require("telescope").setup()
require("telescope").load_extension("fzf")

-- Treesitter
local configs = require("nvim-treesitter.configs")

configs.setup {
    ensure_installed = "all",
    sync_install = false,
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
    },
    autopairs = {
        enable = true;
    },
    context_commentstring = {
        enable = true;
        enable_autocmd = true;
    },
    indent = { enable = true },
}

-- nvim-tree
require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    -- auto_close = true, -- been removed???
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
                { key = "v", action = "vsplit"}
            },
        },
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

-- Autopairs
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
    return
end

npairs.setup {
    check_ts = true,
    ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
    },
}

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

-- Git signs
require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
}

-- Todo Comments
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

-- nvim-colorizer
require'colorizer'.setup()

local luasnip = require('luasnip')

luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
}

-- Bufferline
-- vim.opt.termguicolors = true
require("bufferline").setup {
    options = {
        max_name_length = 30,
        show_buffer_icons = false,
        show_close_icon = false,
        buffer_close_icon = "",
    },
    highlights = {
        modified = {
          fg = { attribute = "fg", highlight = "TabLine" },
          bg = { attribute = "bg", highlight = "TabLine" },
        },
        modified_selected = {
          fg = { attribute = "fg", highlight = "Normal" },
          bg = { attribute = "bg", highlight = "Normal" },
        },
        modified_visible = {
          fg = { attribute = "fg", highlight = "TabLine" },
          bg = { attribute = "bg", highlight = "TabLine" },
        }
    }
}
