local c = {
  bg = "#000000", 
  fg = "#FFFFFF",
  none = "NONE"
}

local highlights = {
  Normal = { fg = c.fg, bg = c.bg },
  Comment = { fg = c.fg, bg = c.bg, italic = true },
  Identifier = { fg = c.fg, bg = c.bg },
  Statement = { fg = c.fg, bg = c.bg, bold = true },
  PreProc = { fg = c.fg, bg = c.bg },
  Type = { fg = c.fg, bg = c.bg },
  Special = { fg = c.fg, bg = c.bg },
  Underlined = { fg = c.fg, bg = c.bg, underline = true },
  Error = { fg = "#FF0000", bg = c.bg, bold = true },
  Todo = { fg = "#FFFF00", bg = c.bg, bold = true },
  LspDiagnosticsDefaultError = { fg = "#FF0000", bg = c.bg },
  LspDiagnosticsDefaultWarning = { fg = "#FFFF00", bg = c.bg },
  LspDiagnosticsDefaultInformation = { fg = c.fg, bg = c.bg },
  LspDiagnosticsDefaultHint = { fg = c.fg, bg = c.bg },
  StatusLine = { fg = c.bg, bg = c.fg },
  StatusLineNC = { fg = c.bg, bg = c.fg },
  TabLine = { fg = c.bg, bg = c.fg },
  TabLineFill = { fg = c.bg, bg = c.fg },
  TabLineSel = { fg = c.fg, bg = c.bg, bold = true },
}

for group, settings in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, settings)
end
