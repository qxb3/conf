-- keybindings.lua  (was keybindings.conf)

-- ╻┏ ┏━╸╻ ╻┏┓ ╻┏┓╻╺┳┓╻┏┓╻┏━╸┏━┓
-- ┣┻┓┣╸ ┗┳┛┣┻┓┃┃┗┫ ┃┃┃┃┗┫┃╺┓┗━┓
-- ╹ ╹┗━╸ ╹ ┗━┛╹╹ ╹╺┻┛╹╹ ╹┗━┛┗━┛

local mainMod = "SUPER" -- windows key
local smw = require("split_workspaces")

-- Window/Session actions
hl.bind(mainMod .. " + Q", hl.dsp.window.close())  -- was: exec, hyprctl dispatch killactive ""
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/togglefloating.sh"))
hl.bind("ALT + F4", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind("ALT + P", hl.dsp.window.pin({ action = "toggle" }))
hl.bind("ALT + Return", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("swaylock"))

-- Ags keybinds
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("quickshell ipc call launcher toggle"))
hl.bind(mainMod .. " + Tab", hl.dsp.global("quickshell:launcher_tab_down"))
hl.bind(mainMod .. " + down", hl.dsp.global("quickshell:launcher_tab_down"))
hl.bind(mainMod .. " + up", hl.dsp.global("quickshell:launcher_tab_up"))

-- Application shortcuts
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nemo"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("vesktop"))

-- Audio control
-- hl.bind("F10", hl.dsp.exec_cmd("~/.config/hypr/scripts/volumecontrol.sh -o m"), { locked = true }) -- toggle audio mute
-- hl.bind("F11", hl.dsp.exec_cmd("~/.config/hypr/scripts/volumecontrol.sh -o d"), { locked = true, repeating = true }) -- decrease volume
-- hl.bind("F12", hl.dsp.exec_cmd("~/.config/hypr/scripts/volumecontrol.sh -o i"), { locked = true, repeating = true }) -- increase volume
-- hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/hypr/scripts/volumecontrol.sh -o m"), { locked = true }) -- toggle audio mute
-- hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("~/.config/hypr/scripts/volumecontrol.sh -i m"), { locked = true }) -- toggle microphone mute
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volumecontrol.sh -o d"), { locked = true, repeating = true }) -- decrease volume
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volumecontrol.sh -o i"), { locked = true, repeating = true }) -- increase volume

-- Brightness control
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightnesscontrol.sh i"), { locked = true, repeating = true }) -- increase brightness
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightnesscontrol.sh d"), { locked = true, repeating = true }) -- decrease brightness

-- Screenshot/Screencapture
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh s")) -- drag to snip an area / click on a window to print it
hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh sf")) -- frozen screen, drag to snip an area / click on a window to print it
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh m")) -- print focused monitor
hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh p")) -- print all monitor outputs

hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("~/.config/hypr/scripts/translate.sh")) -- translate something
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("~/.config/hypr/scripts/extract-text.sh")) -- extract text

-- Custom scripts keybinds
-- hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("pkill -x rofi || ~/.config/hypr/scripts/wallpaperselect.sh")) -- rofi wall select menu
-- hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("pkill -x rofi || ~/.config/hypr/scripts/cliphist.sh c")) -- open Pasteboard in screen center
-- hl.bind("XF86PowerOff", hl.dsp.exec_cmd("~/.config/eww/shared/scripts/togglelogout.sh"))

-- Move focus with ALT + WASD
hl.bind("ALT + A", hl.dsp.focus({ direction = "left" }))
hl.bind("ALT + D", hl.dsp.focus({ direction = "right" }))
hl.bind("ALT + W", hl.dsp.focus({ direction = "up" }))
hl.bind("ALT + S", hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + Tab", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- (was: exec, hyprctl dispatch split-workspace N -> split-monitor-workspaces Lua package)
for i = 1, 5 do
    local n = tostring(i)
    hl.bind(mainMod .. " + " .. n, smw.workspace(n))
end

-- Switch workspaces relative to the active workspace with mainMod + CTRL + [←→]
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ workspace = "r-1" }))

-- move to the first empty workspace instantly with mainMod + CTRL + [↓]
hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" }))

-- Resize windows
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 5 do
    local n = tostring(i)
    hl.bind(mainMod .. " + SHIFT + " .. n, smw.move_to_workspace(n))
end

-- Move active window around current workspace with mainMod + SHIFT + CTRL [←→↑↓]
-- (the old file wrote `$mainMod SHIFT $CONTROL`; the undefined $CONTROL still resolved to CTRL, so this is SUPER+SHIFT+CTRL)
hl.bind(mainMod .. " + SHIFT + CTRL + A", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + CTRL + D", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + CTRL + W", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + CTRL + S", hl.dsp.window.move({ direction = "down" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/Resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Special workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special())
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special", follow = false })) -- was movetoworkspacesilent

-- Move window silently to workspace Super + Alt + [0-9]
for i = 1, 5 do
    local n = tostring(i)
    hl.bind(mainMod .. " + ALT + " .. n, smw.move_to_workspace_silent(n))
end

-- Trigger when the switch is turning off
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprlock"), { locked = true })
hl.bind("XF86PowerOff", hl.dsp.exec_cmd("systemctl suspend && hyprlock"))
