pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell

Singleton {
  property bool expanded: false
  property int tab: 0

  // While true, the page slide animations are skipped so a tab change lands instantly.
  property bool snapTabs: false

  function snapTo(index) {
    snapTabs = true
    tab = index
    Qt.callLater(() => snapTabs = false)
  }

  onExpandedChanged: if (!expanded) snapTo(0)

  function open(index) {
    if (tab !== index) PowerState.open = false
    if (expanded) tab = index
    else snapTo(index)
    expanded = true
  }

  function toggleTab(index) {
    if (expanded && tab === index) expanded = false
    else open(index)
  }
}
