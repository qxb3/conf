require('toggleterm').setup({
  open_mapping = [[<C-t>]],
  direction = 'float',
  shade_terminals = false,
  float_opts = {
    border = 'single',
    width = function()
      local total_width = vim.o.columns
      return math.floor(total_width - (total_width / 6))
    end,
    height = function()
      local total_height = vim.o.lines
      return math.floor(total_height - (total_height / 5))
    end
  }
})
