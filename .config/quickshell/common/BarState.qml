pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell

Singleton {
  property bool expanded: false
  property int tab: 0

  // Name of the monitor whose sidebar is open. Only that monitor's bar shows it.
  property string activeScreen: ""

  // While true, the page slide animations are skipped so a tab change lands instantly.
  property bool snapTabs: false

  function snapTo(index) {
    snapTabs = true
    tab = index
    Qt.callLater(() => snapTabs = false)
  }

  function isOn(name, index) {
    return expanded && activeScreen === name && tab === index
  }

  onExpandedChanged: if (!expanded) snapTo(0)

  function open(index, name) {
    if (tab !== index) PowerState.open = false
    if (expanded && activeScreen === name) {
      tab = index
    } else {
      activeScreen = name
      snapTo(index)
    }
    expanded = true
  }

  function toggle(name) {
    if (expanded && activeScreen === name) {
      expanded = false
    } else {
      activeScreen = name
      expanded = true
    }
  }
}
