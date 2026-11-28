pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

Singleton {
  id: root

  readonly property string stateDir: Quickshell.env("HOME") + "/.local/state/quickshell"
  readonly property string cacheDir: Quickshell.env("HOME") + "/.cache/quickshell/notifications"

  // Every notification not yet cleared. Saved to disk so the sidebar list survives a reload.
  property var entries: []

  // Sidebar list: entries whose popup has already gone.
  readonly property var sidebarItems: entries.filter(e => popups.indexOf(e) === -1)

  // Popup list: newest first. An entry leaves here when its timer ends or its X is pressed.
  property var popups: []

  // Image copies run one at a time, so each cached file is written before the next starts.
  property var copyQueue: []
  property var copying: null

  // Notifications that arrive during Do Not Disturb are held here and shown when DnD turns off.
  property var dndQueue: []

  function addEntry(e) {
    // Spotify track changes reuse one entry: the new one replaces the old by id.
    const existing = e.appName === "Spotify" ? entries.find(x => x.appName === "Spotify") : null
    if (existing) e.id = existing.id
    entries = entries.filter(x => x.id !== e.id).concat([e])
    popups = [e].concat(popups.filter(p => p.id !== e.id))
    queueCopy(e)
    save()
  }

  function flushDnd() {
    const held = dndQueue
    dndQueue = []
    held.forEach(e => addEntry(e))
  }

  Connections {
    target: DndState

    function onActiveChanged() {
      if (!DndState.active) root.flushDnd()
    }
  }

  function hidePopup(e) {
    popups = popups.filter(p => p !== e)
  }

  // Removes the entry from the sidebar list and the saved file. Popups only hide, they never call this.
  // Match by id, not object identity: values read back from the JsonAdapter are copies.
  function removeEntry(e) {
    entries = entries.filter(x => x.id !== e.id)
    popups = popups.filter(p => p.id !== e.id)
    if (e.image && e.image.indexOf("file://" + cacheDir) === 0) {
      remover.command = ["rm", "-f", e.image.slice(7)]
      remover.running = true
    }
    scheduleSave()
  }

  // Coalesces bursts of changes (clearing a stack) into one disk write instead of one per card.
  Timer {
    id: saveTimer

    interval: 400
    onTriggered: root.save()
  }

  function scheduleSave() {
    saveTimer.restart()
  }

  function save() {
    saved.items = entries.map(e => ({
      id: e.id,
      appName: e.appName,
      summary: e.summary,
      body: e.body,
      image: e.image,
      time: e.time
    }))
    store.writeAdapter()
  }

  function queueCopy(e) {
    if (!e.image) return
    copyQueue = copyQueue.concat([e])
    runNextCopy()
  }

  function runNextCopy() {
    if (copier.running || copyQueue.length === 0) return
    copying = copyQueue[0]
    copyQueue = copyQueue.slice(1)
    const src = copying.image.replace(/^file:\/\//, "")
    const ext = (src.match(/\.(\w+)$/) || ["", "png"])[1]
    copier.command = ["cp", "-f", src, cacheDir + "/" + copying.id + "." + ext]
    copier.running = true
  }

  // Create the state and cache folders once at startup.
  Process {
    running: true
    command: ["mkdir", "-p", root.stateDir, root.cacheDir]
  }

  Process {
    id: copier

    onExited: exitCode => {
      if (exitCode === 0 && root.copying) {
        const e = root.copying
        const src = e.image.replace(/^file:\/\//, "")
        const ext = (src.match(/\.(\w+)$/) || ["", "png"])[1]
        e.image = "file://" + root.cacheDir + "/" + e.id + "." + ext
        root.entries = root.entries.slice()
        root.save()
      }
      root.copying = null
      root.runNextCopy()
    }
  }

  Process {
    id: remover
  }

  FileView {
    id: store

    path: Quickshell.env("HOME") + "/.local/state/quickshell/notifications.json"
    atomicWrites: true

    onLoaded: root.entries = saved.items.concat(root.entries)

    JsonAdapter {
      id: saved

      property var items: []
    }
  }

  NotificationServer {
    id: server

    keepOnReload: false
    bodySupported: true
    bodyMarkupSupported: false
    imageSupported: true

    onNotification: notification => {
      const e = {
        id: String(Date.now()) + Math.random().toString(36).slice(2),
        appName: notification.appName,
        summary: notification.summary,
        body: notification.body,
        image: notification.image,
        time: Date.now()
      }
      // While DnD is on, the notification is held back instead of reaching popups or the sidebar.
      if (DndState.active) root.dndQueue = root.dndQueue.concat([e])
      else root.addEntry(e)
    }
  }
}
