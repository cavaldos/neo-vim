vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  -- theme


  use "olimorris/onedarkpro.nvim"


  require("onedarkpro").load()




  use { 'MunifTanjim/nui.nvim' }


  --file manager
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
  })

  -- terminal
  use("voldikss/vim-floaterm")
  use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end }
  use { 'numtostr/FTerm.nvim' }


  --nvim tree
  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    tag = "nightly", -- optional, updated every week. (see issue #1193)
  })




  --show funcsions aerial
  use("stevearc/aerial.nvim")
  -- icon
  use { 'nvim-tree/nvim-web-devicons' }
  use("nvim-lua/plenary.nvim")
  -- telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use 'MattesGroeger/vim-bookmarks'
  use 'tom-anders/telescope-vim-bookmarks.nvim'

  ------lua line
  use {
    'nvim-lualine/lualine.nvim',
    --requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  --buffer line
  use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })
  --feline
  use 'feline-nvim/feline.nvim'
  --heirline.lua
  use("rebelot/heirline.nvim")
  --blank line
  use("lukas-reineke/indent-blankline.nvim")
  --color
  use { 'nvchad/nvim-colorizer.lua' }
  --numb
  use { 'nacro90/numb.nvim' }
  --neoscroll
  use { 'karb94/neoscroll.nvim' }
  --alpha nvim
  use { 'goolord/alpha-nvim' }
  --comment
  use { 'numToStr/Comment.nvim' }
  --swichkey
  use("folke/which-key.nvim")
  --nvim gps
  use {
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter"
  }

  --neoclip
  use { 'AckslD/nvim-neoclip.lua' }
  --todo comment
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
    end
  }
  use({
    "folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  })

  -----------------------------------auto completion code-------------------------------
  -- auto completion code
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'onsails/lspkind-nvim'

  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'jose-elias-alvarez/typescript.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'windwp/nvim-ts-autotag'
  use 'p00f/nvim-ts-rainbow'
  use 'axelvc/template-string.nvim'
  use 'j-hui/fidget.nvim'

  --   use({
  --     "glepnir/lspsaga.nvim",
  --     branch = "main",
  --     config = function()
  --         local saga = require("lspsaga")

  --         saga.init_lsp_saga({
  --             -- your configuration
  --         })
  --    end,
  -- })

  use("glepnir/lspsaga.nvim")
  use { 'kkharji/lspsaga.nvim' } -- nightly
  use { 'kkharji/lspsaga.nvim', branch = 'nvim6.0' }


  --use 'rmagatti/alternate-toggler'
  use 'windwp/nvim-autopairs'
  -- use 'mg979/vim-visual-multi'
  --  use 'gcmt/wildfire.vim'
  -- use 'tpope/vim-surround'
end)
