require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  refactor = {
    highlight_definitions = {
      enable = true
    },
    highlight_current_scope = {
      enable = true
    }
  },
  ensure_installed = {
    'c', 'cpp', 'rust', 'asm', 'java', 'go', 'bash',
    'typescript', 'javascript', 'svelte', 'html',
    'python', 'lua', 'vim', 'vimdoc', 'markdown',
    'json', 'toml', 'xml', 'cmake', 'meson', 'ninja',
    'yuck', 'jq', 'css', 'scss',
  }
})
