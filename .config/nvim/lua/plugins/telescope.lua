return {
  'nvim-telescope/telescope.nvim',
  version = '*',

  dependecies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },

  opts = function()
    -- local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')

    return {
      defaults = {
        file_ignore_patterns = {
          'node_modules', 'dist', 'static',
          'packer_compiled.lua', 'nvim-tree.lua',
          'target', 'CMakeFiles', '@girs'
        },
        mappings = {
          n = {
            ['<CR>'] = actions.select_vertical,
            ['<C-h>'] = actions.select_horizontal,
            ['<C-s>'] = false,
            ['<C-t>'] = false
          },
          i = {
            ['<CR>'] = actions.select_vertical,
            ['<C-h>'] = actions.select_horizontal,
            ['<C-s>'] = false,
            ['<C-t>'] = false
          }
        }
      },
      extensions = {
        'neoclip'
      }
    }
  end,

  keys = {
    { '<C-f>', function() require('telescope.builtin').find_files() end, desc = 'Find files' },
    { '<C-g>', function() require('telescope.builtin').live_grep() end, desc = 'Live grep' },
    { '<C-b>', function() require('telescope.builtin').buffers() end, desc = 'Buffers' },

    { '<leader>dn', function() require('telescope.builtin').diagnostics() end, desc = 'Diagnostics' },
    { '<leader>mp', function() require('telescope.builtin').man_pages() end, desc = 'Man pages' },
    { '<leader>ht', function() require('telescope.builtin').help_tags() end, desc = 'Help tags' },
    { '<leader>sg', function() require('telescope.builtin').spell_suggest() end, desc = 'Spell suggest' },
    { '<leader>hl', function() require('telescope.builtin').highlights() end, desc = 'Highlights' },

    { '<leader>gc', function() require('telescope.builtin').git_commits() end, desc = 'Git commits' },
    { '<leader>gb', function() require('telescope.builtin').git_branches() end, desc = 'Git branches' },

    { '<leader>c', '<cmd>Telescope neoclip<cr>', desc = 'Clipboard history' },
  },
}
