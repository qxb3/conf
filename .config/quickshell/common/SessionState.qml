pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io

Singleton {
  property bool sidebarActive: false

  // Sidebar keybinds.
  IpcHandler {
    target: "sidebar"

    function toggle(): bool {
      sidebarActive = !sidebarActive
      return sidebarActive
    }

    function open(): bool {
      sidebarActive = true
      return true
    }

    function close(): bool {
      sidebarActive = false
      return false
    }
  }
}
