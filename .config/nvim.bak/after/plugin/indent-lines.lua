require('ibl').setup({
  indent = { char = '' },
  scope = {
    show_start = false,
    show_end = false,
    exclude = {
      language = { 'NvimTree', 'toggleterm', 'Function', 'help' }
    }
  },
})

require('mini.indentscope').setup({
  symbol = ''
})
