-- hyprland.lua
-- Migrated 1:1 from hyprland.conf (hyprlang) for Hyprland >= 0.55.
-- Because this file exists, Hyprland loads it INSTEAD of hyprland.conf.

-- ┏┳┓┏━┓┏┓╻╻╺┳╸┏━┓┏━┓
-- ┃┃┃┃ ┃┃┗┫┃ ┃ ┃ ┃┣┳┛
-- ╹ ╹┗━┛╹ ╹╹ ╹ ┗━┛╹┗╸

hl.monitor({ output = "DP-1",     mode = "2560x1440@144.0", position = "0x1080", scale = 1.0 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60.0",  position = "305x0",  scale = 1.0, transform = 2 }) -- was: monitor=HDMI-A-1,transform,2

-- ╻  ┏━┓╻ ╻┏┓╻┏━╸╻ ╻
-- ┃  ┣━┫┃ ┃┃┗┫┃  ┣━┫
-- ┗━╸╹ ╹┗━┛╹ ╹┗━╸╹ ╹

-- exec-once -> hyprland.start event (runs once per session, not on reload)
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")

    hl.exec_cmd("~/.config/hypr/scripts/resetxdgportal.sh")
    hl.exec_cmd("~/.config/ags/themes/init.sh")
    hl.exec_cmd("~/.config/hypr/scripts/wallpaperdaemon.sh")
    -- hl.exec_cmd("~/.config/hypr/scripts/controls.sh")

    hl.exec_cmd("hyprpm reload -n")
    hl.exec_cmd("quickshell")
end)

-- ┏━╸┏┓╻╻ ╻
-- ┣╸ ┃┗┫┃┏┛
-- ┗━╸╹ ╹┗┛

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

hl.env("MOZ_ENABLE_WAYLAND", "1")
-- NOTE: the old line was `env = HYPRLAND_NO_SD_NOTIFY=0` (no comma), which hyprlang could not
-- parse as NAME,VALUE, so it never set anything. Kept disabled to preserve the real behaviour.
-- hl.env("HYPRLAND_NO_SD_NOTIFY", "0")

-- hl.env("AQ_DRM_DEVICES", "/dev/dri/card0")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GL_VRR_ALLOWED", "0")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")

-- ╻┏┓╻┏━┓╻ ╻╺┳╸
-- ┃┃┗┫┣━┛┃ ┃ ┃
-- ╹╹ ╹╹  ┗━┛ ╹

hl.config({
    input = {
        kb_layout = "us",
        repeat_rate = 50,
        repeat_delay = 300,

        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
        },

        sensitivity = 0.1,
        accel_profile = "flat",

        float_switch_override_focus = 2,
    },
})

-- ╻  ┏━┓╻ ╻┏━┓╻ ╻╺┳╸┏━┓
-- ┃  ┣━┫┗┳┛┃ ┃┃ ┃ ┃ ┗━┓
-- ┗━╸╹ ╹ ╹ ┗━┛┗━┛ ╹ ┗━┛

-- ┏┳┓╻┏━┓┏━╸
-- ┃┃┃┃┗━┓┃
-- ╹ ╹╹┗━┛┗━╸

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
})

-- ┏━┓┏━┓╻ ╻┏━┓┏━╸┏━╸
-- ┗━┓┃ ┃┃ ┃┣┳┛┃  ┣╸
-- ┗━┛┗━┛┗━┛╹┗╸┗━╸┗━╸

-- source = ... -> require(...)  (paths are relative to ~/.config/hypr)
require("animations")
require("keybindings")
require("rules")
require("theme")
