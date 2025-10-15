import Quickshell.Io
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

import "../../common"
import "../../common/widgets"

RowLayout {
  anchors.left: parent.left
  anchors.top: parent.top
  anchors.bottom: parent.bottom
  spacing: 12

  // Workspaces.
  RowLayout {
    id: workspaces

    Repeater {
      model: 5

      Item {
        id: workspace
        property bool isActive: (Hyprland.focusedWorkspace?.id ?? -1) == index + 1

        implicitWidth: 16
        implicitHeight: 24
        Layout.topMargin: 4
        Layout.bottomMargin: 4

        Rectangle {
          anchors.fill: parent
          color: isActive ? Colors.primary : "transparent"

          CText {
            anchors.centerIn: parent
            color: workspace.isActive ? Colors.bg : Colors.fg
            text: index + 1
          }

          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            onPressed: () => Hyprland.dispatch(`workspace ${index + 1}`)
          }
        }
      }
    }
  }

  // Active Window.
  CText {
    id: activeWindowText

    Connections {
      target: Hyprland

      function onRawEvent(event) {
        activeWindowProc.running = true
      }
    }

    Process {
      id: activeWindowProc

      command: ["hyprctl", "-j", "activewindow"]
      running: true

      stdout: SplitParser {
        onRead: data => {
          const match = data.match(/"initialClass":\s*"([^"]+)"/)
          if (match)
            activeWindowText.text = `* ${match[1]}`
        }
      }
    }
  }
}
