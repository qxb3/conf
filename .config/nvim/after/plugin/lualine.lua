vim.opt.laststatus = 1

require('lualine').setup({
  options = {
    theme = 'auto',
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'packer', 'NVimTree' }
  }
})
