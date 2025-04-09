-- Diagnostic Indicators
vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo", {text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint", {text = "󰌵", texthl = "DiagnosticSignHint"})

local zero = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true
})

zero.on_attach(function(_, bufnr)
  zero.default_keymaps({ buffer = bufnr })

  vim.keymap.set('n', '<leader>sd', '<cmd>lua vim.lsp.buf.hover()<cr>', { silent = true })

  zero.format_on_save({
    format_opts = {
      async = false,
      timeout_ms = 10000,
    },
    servers = {
      ['tsserver'] = {'javascript', 'typescript'},
      ['svelte-language-server'] = {'svelte'},
      ['rust_anaylzer'] = {'rust'},
    }
  })
end)

zero.setup()
