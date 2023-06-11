require("lazy").setup({ -- 
-- theme
-- "sainnhe/gruvbox-material",
"navarasu/onedark.nvim", --
"nvim-tree/nvim-web-devicons", -- vim-surround
"tpope/vim-surround", -- vim-repeat
"tpope/vim-repeat", -- vim-easy-align
"junegunn/vim-easy-align", -- illuminate
"RRethy/vim-illuminate", {
    -- lsp
    "neovim/nvim-lspconfig",
    dependencies = {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim"},
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()
    end
}, {
    -- telescope.nvim
    "nvim-telescope/telescope.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
        require("telescope").setup({
            defaults = {
                prompt_prefix = " ",
                selection_caret = " "
            }
        })
    end
}, {
    -- completion
    "hrsh7th/nvim-cmp",
    dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "onsails/lspkind.nvim" -- Icon cmp
    }
}, {
    -- snippet
    "saadparwaiz1/cmp_luasnip",
    dependencies = {"L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets"},
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
    end
}, {
    -- nvim-tree.lua
    "nvim-tree/nvim-tree.lua",
    config = function()
        require("nvim-tree").setup()
    end
}, {
    -- bufferline.nvim
    "akinsho/bufferline.nvim",
    config = function()
        require("bufferline").setup({
            options = {
                offsets = {{
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    separator = true
                }}
            }
        })
    end
}, {
    -- lualine.nvim
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = {
                component_separators = {},
                section_separators = {},
                theme = "auto",
                ignore_focus = {"NvimTree"}
            },
            sections = {
                lualine_a = {"mode"},
                lualine_b = {"branch", "diff"},
                lualine_c = {"filename", "diagnostics"},
                lualine_x = {"filetype"},
                lualine_y = {"progress"},
                lualine_z = {"location"}
            },
            inactive_sections = {}
        })
    end
}, {
    -- nvim-autopairs
    "windwp/nvim-autopairs",
    config = function()
        require("nvim-autopairs").setup()
    end
}, {
    -- nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    dependencies = {"windwp/nvim-ts-autotag", "JoosepAlviste/nvim-ts-context-commentstring"},
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = {
                enable = true
            },
            autotag = {
                enable = true
            },
            context_commentstring = {
                enable = true
            }
        })
    end
}, {
    -- Comment.nvim
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup()
    end
}, {
    -- colorizer
    "norcalli/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup()
    end
}, {
    -- hop
    "phaazon/hop.nvim",
    config = function()
        require("hop").setup()
    end
}, {
    -- neoscroll
    "karb94/neoscroll.nvim",
    config = function()
        require("neoscroll").setup()
    end
}, {
    -- pretty-fold
    "anuvyklack/pretty-fold.nvim",
    config = function()
        require("pretty-fold").setup()
    end
}, {
    -- which-key
    "folke/which-key.nvim",
    config = function()
        require("which-key").setup({
            window = {
                border = "single"
            }
        })
    end
}, {
    -- gitsigns
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup()
    end
}, {
    -- indent-blankline
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        require("indent_blankline").setup()
    end
}, --
{
    -- toggleterm
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup()
    end
}, --
-- terminal
{"voldikss/vim-floaterm", --
"numtostr/FTerm.nvim" --
}, --
{ --
    "stevearc/aerial.nvim", --
    config = function()
        require("aerial").setup({
            attach_mode = "global",
            backends = {"lsp", "treesitter", "markdown", "man"},
            layout = {
                min_width = 28
            },
            show_guides = true,
            filter_kind = false,
            guides = {
                mid_item = "├ ",
                last_item = "└ ",
                nested_top = "│ ",
                whitespace = "  "
            },
            keymaps = {
                ["[y"] = "actions.prev",
                ["]y"] = "actions.next",
                ["[Y"] = "actions.prev_up",
                ["]Y"] = "actions.next_up",
                ["{"] = false,
                ["}"] = false,
                ["[["] = false,
                ["]]"] = false
            }
        })

    end
}, --
-- alpha vim
{"goolord/alpha-nvim"}, --
--
{ --
    "rcarriga/nvim-notify", --
    config = function()
        require("notify")("Hello Khanh")

    end
} --
--
})
