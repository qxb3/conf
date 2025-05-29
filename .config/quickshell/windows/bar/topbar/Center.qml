import Quickshell.Io
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

RowLayout {
  id: center
  anchors.centerIn: parent

  Item {
    id: activeWindow
    Layout.preferredWidth: 150
    Layout.preferredHeight: 40

    Rectangle {
      anchors.fill: parent
      color: Colors.border
    }

    Rectangle {
      id: activeWindowContent
      implicitWidth: parent.width
      implicitHeight: parent.height
      color: Colors.bg

      Behavior on y {
        NumberAnimation {
          duration: 500
          easing.type: Easing.OutQuart
        }
      }

      Behavior on color {
        ColorAnimation {
          duration: 500
          easing.type: Easing.OutQuart
        }
      }

      Behavior on scale {
        NumberAnimation {
          duration: 250
          easing.type: Easing.OutQuart
        }
      }

      StyledText {
        id: activeWindowText
        anchors.centerIn: parent

        text: "kitty"

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
              activeWindowText.text = match[1]
            }
          }
        }
      }
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true

      onEntered: () => {
        activeWindowContent.color = Colors.bgSoft
        activeWindowContent.y = -8
      }

      onExited: () => {
        activeWindowContent.color = Colors.bg
        activeWindowContent.y = 0
      }

      onPressed: () => {
        GlobalState.isNotifCenterOpen = !GlobalState.isNotifCenterOpen

        activeWindowContent.y = 0
        activeWindowContent.scale = 0.95
        scaleTimer.running = true
      }

      Timer {
        id: scaleTimer
        interval: 250
        running: false
        onTriggered: activeWindowContent.scale = 1
      }
    }
  }
}
