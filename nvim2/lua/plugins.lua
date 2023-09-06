vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'
    use {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig"}
    -- theme
    use "olimorris/onedarkpro.nvim"
    require("onedarkpro").load()
    use 'windwp/nvim-autopairs'
    use {'MunifTanjim/nui.nvim'}
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-treesitter/nvim-treesitter'

    --
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim"}
    })
    -- nvim tree
    use({
        "nvim-tree/nvim-tree.lua",
        requires = {"nvim-tree/nvim-web-devicons" -- optional, for file icons
        },
        tag = "nightly" -- optional, updated every week. (see issue #1193)
    })

    -- lua lualine
    use {'nvim-lualine/lualine.nvim'}
    -- cmp
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'onsails/lspkind-nvim'
    -- lsp 

    use("glepnir/lspsaga.nvim")
    use 'neovim/nvim-lspconfig'
    use {'kkharji/lspsaga.nvim'} -- nightly
    use {
        'kkharji/lspsaga.nvim',
        branch = 'nvim6.0'
    }

end)
