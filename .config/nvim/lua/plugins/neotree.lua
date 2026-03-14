return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  lazy = false,

  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons'
  },

  opts = {
    enable_git_status = true,
    enable_diagnostics = true,
    modified = {
      symbol = '[+]',
      highlight = 'NeoTreeModified',
    },
    window = {
      position = 'bottom',
      mappings = {
        ['<CR>'] = 'open_vsplit',
        ['d'] = 'add_directory',
        ['x'] = 'delete',
      }
    },
    event_handlers = {
      {
        event = 'file_opened',
        handler = function(_)
          local buffers = vim.tbl_filter(function(bufnr)
            return vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_get_name(bufnr) == '' and vim.api.nvim_buf_get_option(bufnr, 'buflisted') and vim.api.nvim_buf_get_option(bufnr, 'bufhidden') == ''
          end, vim.api.nvim_list_bufs())

          if next(buffers) ~= nil then
            vim.api.nvim_command('silent! bdelete ' .. table.concat(buffers, ' '))
          end

          require('neo-tree.command').execute({ action = 'close' })
        end
      },
    }
  },

  keys = {
    { '<C-s>', ':Neotree toggle<CR>', silent = true }
  }
}
