-- theme.lua  (was theme.conf)

-- ╺┳╸╻ ╻┏━╸┏┳┓┏━╸
--  ┃ ┣━┫┣╸ ┃┃┃┣╸
--  ╹ ╹ ╹┗━╸╹ ╹┗━╸

hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "20")

-- exec (runs on every reload) -> top-level hl.exec_cmd
hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 20")
hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 20")

hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-black'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'phocus'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 10,
        border_size = 0,
        layout = "dwindle",
        resize_on_border = true,
    },

    dwindle = {
        preserve_split = true,
        split_width_multiplier = 1.5,
        default_split_ratio = 1,
    },

    decoration = {
        rounding = 0,

        blur = {
            enabled = false,
            size = 8,
            passes = 2,
        },
    },
})

-- ┏━┓┏━┓┏━╸┏━╸╻┏━┓╻
-- ┗━┓┣━┛┣╸ ┃  ┃┣━┫┃
-- ┗━┛╹  ┗━╸┗━╸╹╹ ╹┗━╸

hl.config({
    decoration = {
        dim_special = 0.5,

        blur = {
            special = true,
        },
    },
})

-- ┏━╸┏━┓┏┓╻╺┳╸
-- ┣╸ ┃ ┃┃┗┫ ┃
-- ╹  ┗━┛╹ ╹ ╹

hl.exec_cmd("gsettings set org.gnome.desktop.interface font-name 'CaskaydiaCove Nerd Font 9'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface document-font-name 'CaskaydiaCove Nerd Font 9'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaCove Nerd Font 9'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface font-hinting 'full'")
