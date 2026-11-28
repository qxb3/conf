pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell

Singleton {
  property bool open: false
  property real anchorX: 0
  property real anchorY: 0
  property var item: null
  // Name of the monitor whose tray opened the menu.
  property string screen: ""

  function show(trayItem, x, y, name) {
    PowerState.open = false
    item = trayItem
    screen = name ?? ""
    anchorX = x
    anchorY = y
    open = true
  }
}
