-- animations.lua  (was animations.conf)

-- ┏━┓┏┓╻╻┏┳┓┏━┓╺┳╸╻┏━┓┏┓╻
-- ┣━┫┃┗┫┃┃┃┃┣━┫ ┃ ┃┃ ┃┃┗┫
-- ╹ ╹╹ ╹╹╹ ╹╹ ╹ ╹ ╹┗━┛╹ ╹

hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("fast",    { type = "bezier", points = { { 0.2, 0.8 }, { 0.3, 1 } } })
hl.curve("smooth",  { type = "bezier", points = { { 0.5, 0.1 }, { 0.5, 1 } } })
hl.curve("precise", { type = "bezier", points = { { 0.7, 0.2 }, { 0.3, 1 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 3, bezier = "fast",    style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 3, bezier = "fast",    style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 3, bezier = "fast",    style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, bezier = "precise", style = "slide" })

hl.animation({ leaf = "fadeIn",  enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 3, bezier = "smooth" })

hl.animation({ leaf = "layers", enabled = true, speed = 2, bezier = "smooth", style = "fade" })

hl.animation({ leaf = "workspaces",       enabled = true, speed = 5, bezier = "fast", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "fast", style = "slide" })
