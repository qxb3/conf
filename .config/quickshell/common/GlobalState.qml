pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property bool isGaming: false
  property bool isLeftbarOpen: false
  property bool isNotifCenterOpen: false
  property bool isCalendarOpen: false

  IpcHandler {
    target: "state"

    function toggleGaming(): void {
      root.isGaming = !root.isGaming
      root.isLeftbarOpen = !root.isLeftbarOpen
    }
  }
}
