pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property bool isLeftbarOpen: false
  property bool isNotifCenterOpen: false
  property bool isCalendarOpen: false

  IpcHandler {
    target: "state"

    function toggleLeftbar(): void {
      root.isLeftbarOpen = !root.isLeftbarOpen
    }
  }
}
