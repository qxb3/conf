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
option.laststatus = 1

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

-- Resize split
vim.keymap.set('n', '<S-H>', ':vertical resize +3<CR>', { silent = true })
vim.keymap.set('n', '<S-L>', ':vertical resize -3<CR>', { silent = true })
vim.keymap.set('n', '<S-K>', ':resize -2<CR>', { silent = true })
vim.keymap.set('n', '<S-J>', ':resize +2<CR>', { silent = true })

vim.keymap.set('n', '<leader>so', ':source %<CR>')              -- Source nvim config
vim.keymap.set('n', '<leader>nh', ':nohl<CR>')                  -- Removes highlights
vim.keymap.set('v', '<leader>y', '"+y')                         -- Copy from pc's native clipboard
vim.keymap.set("n", "<C-x>", "<cmd>bd<CR>", { silent = true })  -- Closes the current buffer

-- Disables the recording of macros. (I don't know how to use it)
vim.keymap.set('n', 'q', '<Nop>', { silent = true })
vim.keymap.set('n', 'Q', '<Nop>', { silent = true })
vim.keymap.set('n', '@', '<Nop>', { silent = true })
