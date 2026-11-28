-- rules.lua  (was rules.conf)

-- ╻ ╻╻┏┓╻╺┳┓┏━┓╻ ╻   ┏━┓╻ ╻╻  ┏━╸┏━┓
-- ┃╻┃┃┃┗┫ ┃┃┃ ┃┃╻┃   ┣┳┛┃ ┃┃  ┣╸ ┗━┓
-- ┗┻┛╹╹ ╹╺┻┛┗━┛┗┻┛   ╹┗╸┗━┛┗━╸┗━╸┗━┛

hl.window_rule({ match = { class = "^(nwg-look)$" },                float = true })
hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" },  float = true })
hl.window_rule({ match = { class = "^(nm-applet)$" },               float = true })
hl.window_rule({ match = { class = "^(nm-connection-editor)$" },    float = true })
hl.window_rule({ match = { class = "^(com.obsproject.Studio)$" },   float = true })
hl.window_rule({ match = { class = ".*Mirage Realms.*" },           render_unfocused = true })
hl.window_rule({ name = "suppress-maximize-events", match = { class = ".*" }, suppress_event = "maximize", })

-- ╻ ╻┏━┓┏━┓╻┏ ┏━┓┏━┓┏━┓┏━╸┏━╸   ┏━┓╻ ╻╻  ┏━╸┏━┓
-- ┃╻┃┃ ┃┣┳┛┣┻┓┗━┓┣━┛┣━┫┃  ┣╸    ┣┳┛┃ ┃┃  ┣╸ ┗━┓
-- ┗┻┛┗━┛╹┗╸╹ ╹┗━┛╹  ╹ ╹┗━╸┗━╸   ╹┗╸┗━┛┗━╸┗━╸┗━┛

hl.workspace_rule({ workspace = "special", gaps_in = 24, gaps_out = 64 })
hl.workspace_rule({ workspace = "9", monitor = "TabletDisplay" })

-- ╻  ┏━┓╻ ╻┏━╸┏━┓   ┏━┓╻ ╻╻  ┏━╸┏━┓
-- ┃  ┣━┫┗┳┛┣╸ ┣┳┛   ┣┳┛┃ ┃┃  ┣╸ ┗━┓
-- ┗━╸╹ ╹ ╹ ┗━╸╹┗╸   ╹┗╸┗━┛┗━╸┗━╸┗━┛

hl.layer_rule({ match = { namespace = "notifications" }, no_anim = true })
hl.layer_rule({ match = { namespace = "bar" },           no_anim = true })
hl.layer_rule({ match = { namespace = "sidebar" },       no_anim = true })
hl.layer_rule({ match = { namespace = "menu" },          no_anim = true })
