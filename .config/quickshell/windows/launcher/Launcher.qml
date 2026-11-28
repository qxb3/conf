import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "../../common"
import "../../common/widgets"

import "./fuzzy.js" as Fuzzy

Scope {
  id: root

  property bool isOpen: false
  property string openMonitor: ""

  FileView {
    id: usageFile
    path: Quickshell.env("HOME") + "/.local/state/quickshell/launcher-usage.json"
    watchChanges: true
    atomicWrites: true
    onFileChanged: reload()

    JsonAdapter {
      id: usageData
      property var counts: ({})
    }
  }

  Process {
    id: mkdirUsage
    command: ["mkdir", "-p", Quickshell.env("HOME") + "/.local/state/quickshell"]
    onExited: usageFile.writeAdapter()
  }

  readonly property var launchableApps: DesktopEntries.applications.values.filter(e => !e.noDisplay && !e.hidden && !e.terminal)

  function usageOf(entry) {
    return usageData.counts[entry.id] ?? 0
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property ShellScreen modelData
      screen: modelData

      anchors.top: true
      margins.top: 8

      exclusionMode: ExclusionMode.Normal
      focusable: true
      aboveWindows: true
      visible: root.isOpen && modelData.name === root.openMonitor

      implicitWidth: 400
      implicitHeight: 300
      color: Colors.bg

      ColumnLayout {
        anchors.fill: parent

        Rectangle {
          id: apps

          property int selectedIndex: 0
          property DesktopEntry selectedApp

          Layout.fillWidth: true
          Layout.fillHeight: true
          Layout.topMargin: 2
          Layout.leftMargin: 2
          Layout.rightMargin: 2
          color: "transparent"

          ListView {
            id: appList
            anchors.fill: parent
            clip: true

            model: DelegateModel {
              model: Fuzzy.fuzz(
                searchInput.text,
                root.launchableApps,
                ["name", "id", "genericName", "comment"],
                root.usageOf
              )

              delegate: Rectangle {
                required property DesktopEntry modelData
                required property int index

                implicitWidth: parent.width
                implicitHeight: appName.height
                color: {
                  if (apps.selectedIndex === index) {
                    apps.selectedApp = modelData
                    Colors.primary
                  } else {
                    "transparent"
                  }
                }

                CText {
                  id: appName
                  text: modelData.name
                  color: (apps.selectedIndex === index) ? Colors.bg : Colors.fg
                }
              }
            }
          }
        }

        Rectangle {
          Layout.fillWidth: true
          Layout.preferredHeight: 1
          color: Colors.fg
        }

        TextField {
          id: searchInput

          Layout.fillWidth: true

          background: Rectangle { color: Colors.bg }
          focus: root.isOpen
          color: Colors.fg
          font.pixelSize: 16

          Keys.onDownPressed: {
            if (apps.selectedIndex < appList.count - 1) apps.selectedIndex++
            appList.positionViewAtIndex(apps.selectedIndex, ListView.Contain)
          }

          Keys.onTabPressed: (event) => {
            if (apps.selectedIndex < appList.count - 1) apps.selectedIndex++
            appList.positionViewAtIndex(apps.selectedIndex, ListView.Contain)
            event.accepted = true
          }

          Keys.onUpPressed: {
            if (apps.selectedIndex > 0) apps.selectedIndex--
            appList.positionViewAtIndex(apps.selectedIndex, ListView.Contain)
          }

          onAccepted: {
            root.isOpen = false
            searchInput.text = ""

            const id = apps.selectedApp.id
            const counts = Object.assign({}, usageData.counts)
            counts[id] = (counts[id] ?? 0) + 1
            usageData.counts = counts
            mkdirUsage.running = true

            apps.selectedApp.execute()
          }
        }

        IpcHandler {
          target: "launcher"

          function toggle(): void {
            root.openMonitor = Hyprland.focusedMonitor?.name ?? root.openMonitor
            root.isOpen = !root.isOpen

            if (!root.isOpen) {
              apps.selectedIndex = 0
              searchInput.text = ""
            }
          }
        }

        GlobalShortcut {
          name: "launcher_tab_down"
          onPressed: {
            if (!root.isOpen || apps.selectedIndex >= appList.count - 1) return

            apps.selectedIndex++
            appList.positionViewAtIndex(apps.selectedIndex, ListView.Contain)
          }
        }

        GlobalShortcut {
          name: "launcher_tab_up"
          onPressed: {
            if (!root.isOpen || apps.selectedIndex <= 0) return

            apps.selectedIndex--
            appList.positionViewAtIndex(apps.selectedIndex, ListView.Contain)
          }
        }
      }
    }
  }
}
