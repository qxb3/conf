require('neo-tree').setup({
  enable_git_status = true,
  enable_diagnostics = true,
  modified = {
    symbol = "[+]",
    highlight = "NeoTreeModified",
  },
  window = {
    position = 'float',
    mappings = {
      ['<CR>'] = 'open_vsplit',
      ['d'] = 'add_directory',
      ['x'] = 'delete',
    }
  },
  event_handlers = {
    {
      event = "file_opened",
      handler = function(_)
        local buffers = vim.tbl_filter(function(bufnr)
          return vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_get_name(bufnr) == "" and vim.api.nvim_buf_get_option(bufnr, "buflisted") and vim.api.nvim_buf_get_option(bufnr, "bufhidden") == ""
        end, vim.api.nvim_list_bufs())

        if next(buffers) ~= nil then
          vim.api.nvim_command("silent! bdelete " .. table.concat(buffers, " "))
        end

        require("neo-tree.command").execute({ action = "close" })
      end
    },
  }
})

vim.keymap.set('n', '<C-s>', ':Neotree toggle<CR>', { silent = true })
