local builtin = require('telescope.builtin')
local actions = require("telescope.actions")

require('telescope').setup({
  defaults = {
    file_ignore_patterns = {
      'node_modules', 'dist', 'build', 'static',
      'packer_compiled.lua', 'nvim-tree.lua',
      'target', 'CMakeFiles'
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
})

require('neoclip').setup()

vim.keymap.set('n', '<C-x>', ':bd<CR>', { silent = true })

vim.keymap.set('n', '<C-f>', builtin.find_files, {}) -- Fuzzy find a file
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})  -- Live grep file contents
vim.keymap.set('n', '<C-b>', builtin.buffers, {})    -- See buffers

vim.keymap.set('n', '<leader>dn', builtin.diagnostics, {})   -- Project scoped lsp diagnostics
vim.keymap.set('n', '<leader>mp', builtin.man_pages, {})     -- See Man pages
vim.keymap.set('n', '<leader>ht', builtin.help_tags, {})     -- Vim Help tags
vim.keymap.set('n', '<leader>sg', builtin.spell_suggest, {}) -- Spell Suggest under the cursor
vim.keymap.set('n', '<leader>hl', builtin.highlights, {})    -- See highlights

vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})   -- Git commits
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})  -- Git branches

-- Telescope plugins keymaps

vim.keymap.set('n', '<leader>c', ':Telescope neoclip<CR>', { silent = true }) -- See clipboards
