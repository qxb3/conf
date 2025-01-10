require('nvim-treesitter.configs').setup({
  auto_install = true,
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
    'typescript', 'tsx', 'javascript', 'svelte', 'html',
    'python', 'lua', 'vim', 'vimdoc', 'markdown', 'hyprlang',
    'json', 'toml', 'xml', 'cmake', 'meson', 'ninja',
    'yuck', 'jq', 'css', 'scss',
  }
})
