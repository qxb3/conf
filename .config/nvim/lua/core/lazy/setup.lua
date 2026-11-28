require('lazy').setup({
  spec = {
    { import = 'plugins' },
  },

  checker = { enabled = true, notify = false, },
  change_detection = { enabled = true, notify = false, },
})
