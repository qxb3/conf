pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell

Singleton {
  property bool open: false
  property real anchorY: 0
  // Name of the monitor whose headphones button opened the popup.
  property string screen: ""

  function isOn(name) {
    return open && screen === name
  }

  function show(y, name) {
    PowerState.open = false
    TrayMenuState.open = false
    screen = name
    anchorY = y
    open = true
  }
}
