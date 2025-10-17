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
      visible: root.isOpen

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

            model: DelegateModel {
              model: Fuzzy.fuzz(
                searchInput.text,
                DesktopEntries.applications.values,
                ["name", "id", "genericName", "comment"]
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

          onAccepted: {
            root.isOpen = false
            searchInput.text = ""

            apps.selectedApp.execute()
          }
        }

        IpcHandler {
          target: "launcher"

          function toggle(): void {
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
            if (!root.isOpen) return

            apps.selectedIndex++
          }
        }

        GlobalShortcut {
          name: "launcher_tab_up"
          onPressed: {
            if (!root.isOpen || apps.selectedIndex <= 0) return

            apps.selectedIndex--
          }
        }
      }
    }
  }
}
