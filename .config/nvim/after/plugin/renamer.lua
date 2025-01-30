vim.keymap.set('i', '<F2>', '<cmd>lua require("renamer").rename()<CR>', { silent = true })
vim.keymap.set('n', '<leader>rn', '<cmd>lua require("renamer").rename()<CR>', { silent = true })
vim.keymap.set('v', '<leader>rn', '<cmd>lua require("renamer").rename()<CR>', { silent = true })
