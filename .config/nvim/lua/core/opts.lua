local option = vim.opt

-- Changes default leader
vim.g.mapleader = ' '

------------------------------------------------------------
-- General                                                --
------------------------------------------------------------
option.mouse = 'a'
option.backupcopy = 'yes'
option.swapfile = false
option.sidescrolloff = 12
option.scrolloff = 12
option.completeopt = 'menuone,noinsert,noselect'
option.shell = '/bin/zsh'

------------------------------------------------------------
-- UI                                                     --
------------------------------------------------------------
option.termguicolors = true
option.relativenumber = true
option.number = true
option.cursorline = true
option.guicursor = ''
option.wrap = false
option.cmdheight = 1
option.list = true
option.listchars = { eol = '↲', --[[ tab = '» ', ]] nbsp = '␣' }

------------------------------------------------------------
-- Tabs, Indenting                                        --
------------------------------------------------------------
option.smartindent = true
option.expandtab = true
option.shiftwidth = 2
option.tabstop = 2

------------------------------------------------------------
-- Memory, CPU                                            --
------------------------------------------------------------
option.hidden = true
option.history = 100
option.lazyredraw = true
option.synmaxcol = 240
option.updatetime = 4000

------------------------------------------------------------
-- Colorscheme                                            --
------------------------------------------------------------

local function setup()
  vim.cmd("highlight clear")
  vim.o.background = "dark" -- Set the background (dark or light)
  vim.g.colors_name = "terminal_colors" -- Set the colorscheme name

  vim.cmd("set termguicolors")
  vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

  -- Define highlight groups using terminal colors
  local highlights = {
    Normal       = { ctermfg = "NONE", ctermbg = "NONE" },
    Comment      = { ctermfg = 8, ctermbg = "NONE" },
    Constant     = { ctermfg = 12, ctermbg = "NONE" },
    Identifier   = { ctermfg = 11, ctermbg = "NONE" },
    Statement    = { ctermfg = 9, ctermbg = "NONE" },
    PreProc      = { ctermfg = 13, ctermbg = "NONE" },
    Type         = { ctermfg = 14, ctermbg = "NONE" },
    Special      = { ctermfg = 10, ctermbg = "NONE" },
    Underlined   = { ctermfg = "NONE", ctermbg = "NONE", cterm = "underline" },
    Error        = { ctermfg = 15, ctermbg = 1 },
    Todo         = { ctermfg = 0, ctermbg = 11 },
  }

  -- Apply the highlight groups
  for group, opts in pairs(highlights) do
    local cmd = string.format(
      "highlight %s ctermfg=%s ctermbg=%s %s",
      group,
      opts.ctermfg or "NONE",
      opts.ctermbg or "NONE",
      opts.cterm and ("cterm=" .. opts.cterm) or ""
    )
    vim.cmd(cmd)
  end
end

setup()

-- vim.o.background = 'dark'
-- vim.cmd('colorscheme kanagawa')

------------------------------------------------------------
-- Vim Remaps                                             --
------------------------------------------------------------

-- Map Esc to qq
vim.keymap.set('i', 'qq', '<Esc>', { silent = true })
vim.keymap.set('v', 'qq', '<Esc>', { silent = true })
vim.keymap.set('i', 'qq', '<Esc>', { silent = true })

-- Split focus
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { silent = true })

vim.keymap.set('n', '<leader>so', ':source %<CR>')
vim.keymap.set('n', '<leader>nh', ':nohl<CR>')
vim.keymap.set('v', '<leader>y', '"+y')

vim.keymap.set('n', 'q', '<Nop>', { silent = true })
vim.keymap.set('n', 'Q', '<Nop>', { silent = true })
vim.keymap.set('n', '@', '<Nop>', { silent = true })
