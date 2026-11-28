-- split_workspaces.lua
-- The old config used the hyprpm C++ plugin split-monitor-workspaces
-- (dispatchers split-workspace / split-movetoworkspace / split-movetoworkspacesilent).
-- On Hyprland >= 0.55 the Lua package replaces it. Install once with:
--
--   mkdir -p ~/.config/hypr/plugins
--   git clone https://github.com/zjeffer/split-monitor-workspaces ~/.config/hypr/plugins/split-monitor-workspaces
--   (on a release build, also: git checkout release/0.55.x   -- match your Hyprland minor version)
--
-- and disable the old C++ plugin so both don't fight:  hyprpm disable split-monitor-workspaces

package.path = package.path .. ";./?.lua;./?/init.lua"
local smw = require("plugins.split-monitor-workspaces")

smw.setup({
    -- The old plugin's default was count = 10 workspaces per monitor (the old config never set it).
    workspace_count = 10,
})

return smw
