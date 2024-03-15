require('nvim-tree').setup({
  hijack_cursor = true,
  actions = {
    open_file = {
      quit_on_open = true
    }
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    debounce_delay = 50,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  }
})

vim.keymap.set('n', '<C-s>', ':NvimTreeFindFileToggle<CR>', { silent = true })
