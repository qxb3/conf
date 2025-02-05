local c = {
  bg = "#0c101c",
  fg = "#ffffff",
  primary = "#41e454",
  border = "#ffffff",
  comment = "#728690",
  selection = "#1e252f",
  cursorline = "#1a1f2a",
  black = "#0c101c",
  red = "#ff5c57",
  green = "#41e454",
  yellow = "#f3f99d",
  blue = "#57c7ff",
  magenta = "#ff6ac1",
  cyan = "#9aedfe",
  white = "#f1f1f0",
  grey = "#728690",
}

-- Apply highlights
local function set_highlight(group, fg, bg, style)
  local cmd = string.format("hi %s guifg=%s guibg=%s gui=%s", group, fg or "NONE", bg or "NONE", style or "NONE")
  vim.cmd(cmd)
end

vim.cmd("highlight clear")
vim.cmd("set termguicolors")
vim.cmd("hi Normal guibg=NONE ctermbg=NONE") -- Transparent background

set_highlight("Normal", c.fg, nil)
set_highlight("Comment", c.comment, nil, "italic")
set_highlight("CursorLine", nil, c.cursorline)
set_highlight("Visual", nil, c.selection)
set_highlight("LineNr", c.grey, nil)
set_highlight("CursorLineNr", c.primary, nil, "bold")
set_highlight("Pmenu", c.fg, c.selection)
set_highlight("PmenuSel", c.bg, c.primary)
set_highlight("StatusLine", c.fg, c.cursorline)
set_highlight("StatusLineNC", c.grey, c.cursorline)
set_highlight("VertSplit", c.border, nil)
set_highlight("MatchParen", c.primary, nil, "bold")

-- Syntax highlighting
set_highlight("Keyword", c.primary, nil, "bold")
set_highlight("Function", c.blue)
set_highlight("String", c.green)
set_highlight("Type", c.yellow)
set_highlight("Constant", c.magenta)
set_highlight("Variable", c.fg)

-- LSP
set_highlight("LspReferenceText", nil, c.selection)
set_highlight("LspReferenceRead", nil, c.selection)
set_highlight("LspReferenceWrite", nil, c.selection)

-- Diagnostics
set_highlight("DiagnosticError", c.red)
set_highlight("DiagnosticWarn", c.yellow)
set_highlight("DiagnosticInfo", c.blue)
set_highlight("DiagnosticHint", c.cyan)

-- Lualine
require("lualine").setup({
  options = {
    theme = {
      normal = {
        a = { bg = c.primary, fg = c.bg, gui = "bold" },
        b = { bg = c.bg1, fg = c.fg },
        c = { bg = c.bg, fg = c.fg1 },
      },
      insert = { a = { bg = c.green, fg = c.bg, gui = "bold" } },
      visual = { a = { bg = c.yellow, fg = c.bg, gui = "bold" } },
      replace = { a = { bg = c.red, fg = c.bg, gui = "bold" } },
      command = { a = { bg = c.aqua, fg = c.bg, gui = "bold" } },
      inactive = {
        a = { bg = c.bg1, fg = c.fg2 },
        b = { bg = c.bg1, fg = c.fg2 },
        c = { bg = c.bg, fg = c.fg1 },
      },
    },
  },
})
