import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Mpris

import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

Item {
  id: topBar
  Layout.alignment: Qt.AlignTop
  Layout.fillWidth: true
  Layout.preferredHeight: 80

  Rectangle {
    anchors.fill: parent
    color: Colors.bg
  }

  Item {
    id: left
    implicitWidth: 120
    implicitHeight: parent.height

    Rectangle {
      id: currentWorkspaceBg
      anchors.left: work1.left
      anchors.right: work1.right
      anchors.top: work1.top
      anchors.bottom: work1.bottom
      anchors.margins: -4
      color: Colors.border
      state: "work" + Hyprland.focusedWorkspace.id

      states: [
        State {
          name: "work1"
          AnchorChanges { target: currentWorkspaceBg; anchors.left: work1.left; anchors.right: work1.right; anchors.top: work1.top; anchors.bottom: work1.bottom }
        },

        State {
          name: "work2"
          AnchorChanges { target: currentWorkspaceBg; anchors.left: work2.left; anchors.right: work2.right; anchors.top: work2.top; anchors.bottom: work2.bottom }
        },

        State {
          name: "work3"
          AnchorChanges { target: currentWorkspaceBg; anchors.left: work3.left; anchors.right: work3.right; anchors.top: work3.top; anchors.bottom: work3.bottom }
        },

        State {
          name: "work4"
          AnchorChanges { target: currentWorkspaceBg; anchors.left: work4.left; anchors.right: work4.right; anchors.top: work4.top; anchors.bottom: work4.bottom }
        },

        State {
          name: "work5"
          AnchorChanges { target: currentWorkspaceBg; anchors.left: work5.left; anchors.right: work5.right; anchors.top: work5.top; anchors.bottom: work5.bottom }
        }
      ]

      transitions: Transition {
        AnchorAnimation {
          duration: 500
          easing.type: Easing.OutQuart
        }
      }
    }

    StyledText {
      id: work1
      anchors.left: parent.left
      anchors.verticalCenter: parent.verticalCenter
      text: "I"

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onPressed: () => Hyprland.dispatch("workspace 1")
      }
    }

    StyledText {
      id: work2
      anchors.left: work1.left
      anchors.verticalCenter: parent.verticalCenter
      anchors.leftMargin: 18
      text: "II"

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onPressed: () => Hyprland.dispatch("workspace 2")
      }
    }

    StyledText {
      id: work3
      anchors.left: work2.left
      anchors.verticalCenter: parent.verticalCenter
      anchors.leftMargin: 25
      text: "III"

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onPressed: () => Hyprland.dispatch("workspace 3")
      }
    }

    StyledText {
      id: work4
      anchors.left: work3.left
      anchors.verticalCenter: parent.verticalCenter
      anchors.leftMargin: 32
      text: "IV"

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onPressed: () => Hyprland.dispatch("workspace 4")
      }
    }

    StyledText {
      id: work5
      anchors.left: work4.left
      anchors.verticalCenter: parent.verticalCenter
      anchors.leftMargin: 32
      text: "V"

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onPressed: () => Hyprland.dispatch("workspace 5")
      }
    }
  }

  RowLayout {
    id: center
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    StyledText {
      id: activeWindow
      text: "kitty"

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
      }

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
              activeWindow.text = match[1]
          }
        }
      }
    }
  }

  RowLayout {
    id: right
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.rightMargin: 20

    StyledText {
      id: time
      text: "00:00"

      Process {
        id: timeProc
        command: ["date", "+%I:%M"]
        running: true
        stdout: SplitParser {
          onRead: data => time.text = data
        }
      }

      Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: timeProc.running = true
      }
    }
  }
}
