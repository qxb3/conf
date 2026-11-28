return {
  'metalelf0/base16-black-metal-scheme',

  config = function()
    vim.cmd('colorscheme base16-black-metal-gorgoroth')
    vim.api.nvim_set_hl(0, 'WinSeparator', { bg = 'None', fg = '#000000' })
    vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#9b8d7f', fg = '#000000' })
  end
}
