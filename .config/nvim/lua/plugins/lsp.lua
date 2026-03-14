return {
  'neovim/nvim-lspconfig',

  config = function()
    require('mason').setup({
      registries = {
        'github:crashdummyy/mason-registry',
        'github:mason-org/mason-registry',
      }
    })

    require('mason-lspconfig').setup()
    require('blink.cmp').setup({
      completion = {
        documentation = { auto_show = false },

        list = {
          selection = { preselect = true },
          cycle = { from_top = false }
        },

        menu = {
          draw = {
            columns = {
              { 'kind_icon', 'label', 'kind', gap = 1 },
            }
          }
        }
      },

      keymap = {
        preset = 'none',
        ['<Tab>'] = {
          function(cmp)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            if col == 0 then
              return false
            end

            local line = vim.api.nvim_get_current_line()
            if line:sub(col, col):match('%s') == nil then
              return cmp.insert_next()
            end
          end,
          'fallback',
        },
        ['<C-Space>'] = {
          function(cmp)
            cmp.show()
          end
        },
        ['<CR>'] = { 'accept', 'fallback' },
      },
    })

    vim.diagnostic.config({
      virtual_text = false,
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local opts = { buffer = args.buf }

        vim.keymap.set('n', '<leader>sd', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>sa', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
      end,
    })
  end,

  dependencies = {
    'mason-org/mason-lspconfig.nvim',
    'mason-org/mason.nvim',
    { 'saghen/blink.cmp', build = 'cargo build --release' },
  },
}
