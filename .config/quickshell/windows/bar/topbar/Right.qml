import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

RowLayout {
  id: right
  anchors.right: parent.right
  anchors.top: parent.top
  anchors.bottom: parent.bottom
  anchors.rightMargin: 20

  Item {
    id: time
    Layout.preferredWidth: 100
    Layout.preferredHeight: 40

    Rectangle {
      anchors.fill: parent
      color: Colors.border
    }

    Rectangle {
      id: timeContent
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
        id: timeText
        text: "00:00"
        anchors.centerIn: parent

        Process {
          id: timeProc
          command: ["date", "+%I:%M"]
          running: true
          stdout: SplitParser {
            onRead: data => timeText.text = data
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

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true

      onEntered: () => {
        timeContent.color = Colors.bgSoft
        timeContent.y = -8
      }

      onExited: () => {
        timeContent.color = Colors.bg
        timeContent.y = 0
      }

      onPressed: () => {
        GlobalState.isCalendarOpen = !GlobalState.isCalendarOpen

        timeContent.y = 0
        timeContent.scale = 0.95
        scaleTimer.running = true
      }

      Timer {
        id: scaleTimer
        interval: 250
        running: false
        onTriggered: timeContent.scale = 1
      }
    }
  }
}
