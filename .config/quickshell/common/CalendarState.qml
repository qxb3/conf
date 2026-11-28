pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell

Singleton {
  property bool open: false
  // Name of the monitor whose clock opened the calendar.
  property string screen: ""

  function isOn(name) {
    return open && screen === name
  }

  function toggle(name) {
    if (isOn(name)) open = false
    else {
      screen = name
      open = true
    }
  }
}
