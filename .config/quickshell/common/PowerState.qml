pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell

Singleton {
  property bool open: false
  property real anchorX: 0
  property real anchorY: 0

  function show(x, y) {
    anchorX = x
    anchorY = y
    open = true
  }
}
