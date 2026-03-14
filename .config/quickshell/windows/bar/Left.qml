import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

import "../../common"
import "../../common/widgets"

RowLayout {
  required property ShellScreen screen

  anchors.left: parent.left
  anchors.top: parent.top
  anchors.bottom: parent.bottom
  spacing: 12

  // Workspaces.
  RowLayout {
    id: workspaces
    implicitWidth: parent.width
    implicitHeight: parent.height

    Repeater {
      model: Hyprland.workspaces.values
        .filter(w => w.monitor.name === screen.name && w.id !== -99)
        .slice(0, 5)

      Item {
        id: workspace

        required property HyprlandWorkspace modelData
        required property int index

        property bool isActive: modelData.focused

        implicitWidth: 16
        implicitHeight: workspaces.height

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
