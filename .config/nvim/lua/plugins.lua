require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  ------------------------------------------------------------
  -- General Plugins                                        --
  ------------------------------------------------------------
  --LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Lsp Config
      { 'williamboman/mason.nvim' },           -- Lsp Package Manager
      { 'williamboman/mason-lspconfig.nvim' }, -- Mason lsp config

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Cmp Completion Plugin
      { 'hrsh7th/cmp-nvim-lsp' }, -- Cmp LSP

      -- Snippets
      { 'saadparwaiz1/cmp_luasnip' },
      { 'L3MON4D3/LuaSnip' },

      -- Others
      { 'onsails/lspkind.nvim' },                -- VSCode-Like Pictograms
      { 'hrsh7th/cmp-nvim-lsp-signature-help' }, -- Functions signature
      { 'hrsh7th/cmp-path' },                    -- Path
      { 'j-hui/fidget.nvim' },                   -- LSP Notification
      { 'folke/neodev.nvim' },                   -- LSP Support for neovim lua api
    }
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Plenary
  use 'nvim-lua/plenary.nvim'

  -- File tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons'
    }
  }

  -- Fuzzy finder using telescope
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'AckslD/nvim-neoclip.lua'
    }
  }

  -- Fuzzy finder using fzf
  use {
    'junegunn/fzf',
    dir = '~/.fzf',
    run = './install --all'
  }
  use 'junegunn/fzf.vim'

  -- Renames variables / functions
  use {
    'filipdutescu/renamer.nvim',
    branch = 'master',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Neotree
  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    requires = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim'
    }
  }

  ------------------------------------------------------------
  -- UI Plugins                                             --
  ------------------------------------------------------------
  use 'nvim-lualine/lualine.nvim'           -- LuaLine
  use 'chrisbra/changesPlugin'              -- Easy visibility on changes i made on a file
  use 'ryanoasis/vim-devicons'              -- Dev icons without color
  use 'lukas-reineke/indent-blankline.nvim' -- Indent Guide lines
  use 'echasnovski/mini.indentscope'        -- Highlight indent scope
  use 'kyazdani42/nvim-web-devicons'        -- Dev icons with color
  use 'xiyaowong/transparent.nvim'          -- Remove Background
  use 'shaunsingh/nord.nvim'                -- Nord Colorscheme
  use 'ellisonleao/gruvbox.nvim'            -- Gruvbox Colorscheme
  use 'nyoom-engineering/oxocarbon.nvim'    -- Oxocarbon Colorscheme
  use 'neanias/everforest-nvim'             -- Everforest Colorscheme
  use 'rebelot/kanagawa.nvim'               -- Kanagawa Colorscheme

  ------------------------------------------------------------
  -- Useful Plugins                                         --
  ------------------------------------------------------------
  use 'mattn/emmet-vim'                     -- Emmet
  use 'windwp/nvim-autopairs'               -- AutoPairs
  use 'numToStr/Comment.nvim'               -- For fast commenting
  use 'djoshea/vim-autoread'                -- Updates the buffer if the file updates externally
  use 'tpope/vim-surround'                  -- Surround changer

  ------------------------------------------------------------
  -- Other Plugins                                          --
  ------------------------------------------------------------
  use 'leafOfTree/vim-svelte-plugin'        -- Svelte specific plugin
  use 'andweeb/presence.nvim'               -- Discord Rich Presence
  use 'akinsho/toggleterm.nvim'             -- Floaterm
  use 'ThePrimeagen/vim-be-good'            -- A game to practice vim-motion
end)

-- Setups
require('renamer').setup()
require('presence').setup()

-- Minimap.nvim
-- vim.g.minimap_auto_start = 1
-- vim.g.minimap_git_colors = 1
