local colors = {
  bgh = "#080a12",
  bg = "#0c101c",
  bg1 = "#0f1424",
  bg2 = "#171f36",

  fgh = "#eae1c8",
  fg = "#e9e0c5",
  fg1 = "#e3d7b5",
  fg2 = "#dccea3",

  pink = "#e44180",
  blue = "#0c101c",
  red = "#e4415c",
  green = "#e44166",
  yellow = "#e46480",
  orange = "#e47b91",
  purple = "#e44199",
  aqua = "#e45180",
  gray = "#e4728f",

  primary = "#e44180",
  secondary = "#0c101c",
  border = "#e9e0c5",
}

local highlight = vim.api.nvim_set_hl
local c = colors

-- General UI Colors
highlight(0, "Normal", { fg = c.fg, bg = "none" })
highlight(0, "NormalFloat", { fg = c.fg1, bg = c.bg1 })
highlight(0, "FloatBorder", { fg = c.border, bg = c.bg1 })
highlight(0, "Visual", { bg = c.bg2 })
highlight(0, "CursorLine", { bg = c.bg1 })
highlight(0, "CursorLineNr", { fg = c.primary, bold = true })
highlight(0, "LineNr", { fg = c.gray })
highlight(0, "Comment", { fg = c.gray, italic = true })
highlight(0, "VertSplit", { fg = c.border })
highlight(0, "Pmenu", { bg = c.bg1, fg = c.fg })
highlight(0, "PmenuSel", { bg = c.primary, fg = c.bgh })

-- Syntax Highlighting
highlight(0, "Keyword", { fg = c.purple, italic = true })
highlight(0, "Type", { fg = c.yellow })
highlight(0, "Function", { fg = c.green })
highlight(0, "String", { fg = c.orange })
highlight(0, "Variable", { fg = c.fg })
highlight(0, "Constant", { fg = c.red })
highlight(0, "Identifier", { fg = c.aqua })
highlight(0, "Number", { fg = c.yellow })
highlight(0, "Boolean", { fg = c.red })
highlight(0, "Operator", { fg = c.primary })
highlight(0, "PreProc", { fg = c.aqua })
highlight(0, "Special", { fg = c.pink })
highlight(0, "Todo", { fg = c.bgh, bg = c.yellow, bold = true })

-- LSP and Diagnostics
highlight(0, "DiagnosticError", { fg = c.red })
highlight(0, "DiagnosticWarn", { fg = c.orange })
highlight(0, "DiagnosticInfo", { fg = c.yellow })
highlight(0, "DiagnosticHint", { fg = c.aqua })
highlight(0, "LspReferenceText", { bg = c.bg2 })
highlight(0, "LspReferenceRead", { bg = c.bg2 })
highlight(0, "LspReferenceWrite", { bg = c.bg2 })

-- Git and Diffs
highlight(0, "DiffAdd", { bg = c.green, fg = c.bgh })
highlight(0, "DiffChange", { bg = c.yellow, fg = c.bgh })
highlight(0, "DiffDelete", { bg = c.red, fg = c.bgh })
highlight(0, "DiffText", { bg = c.blue, fg = c.fg })

-- Lualine
require("lualine").setup({
  options = {
    theme = {
      normal = {
        a = { bg = c.primary, fg = c.bgh, gui = "bold" },
        b = { bg = c.bg1, fg = c.fg },
        c = { bg = c.bg, fg = c.fg1 },
      },
      insert = { a = { bg = c.green, fg = c.bgh, gui = "bold" } },
      visual = { a = { bg = c.yellow, fg = c.bgh, gui = "bold" } },
      replace = { a = { bg = c.red, fg = c.bgh, gui = "bold" } },
      command = { a = { bg = c.aqua, fg = c.bgh, gui = "bold" } },
      inactive = {
        a = { bg = c.bg1, fg = c.fg2 },
        b = { bg = c.bg1, fg = c.fg2 },
        c = { bg = c.bg, fg = c.fg1 },
      },
    },
  },
})
