vim.cmd([[
  let $FZF_DEFAULT_COMMAND='find . \( -name node_modules -o -name .git \) -prune -o -print'
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9, 'relative': v:true, 'border': 'rounded' } }
  let g:fzf_preview_window = ['up:50%']
]])
