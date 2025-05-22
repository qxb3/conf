import Quickshell
import Quickshell.Io
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

ColumnLayout {
  anchors.left: parent.left
  anchors.bottom: parent.bottom
  implicitWidth: parent.width
  spacing: 8

  Item {
    implicitWidth: parent.width
    implicitHeight: desktopControlsContainer.height

    Rectangle {
      anchors.fill: parent
      color: Settings.colors.bgSoft
      radius: Settings.rounding.general
    }

    Column {
      id: desktopControlsContainer
      anchors.horizontalCenter: parent.horizontalCenter
      topPadding: 8
      bottomPadding: 8
      spacing: 8

      StyledText {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "󰋎"
        font.pixelSize: 24

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onPressed: (_) => {
          }
        }
      }

      StyledText {
        anchors.horizontalCenter: parent.horizontalCenter
        text: ""
        font.pixelSize: 22

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onPressed: (_) => {
          }
        }
      }

      StyledText {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "󰂀"
        font.pixelSize: 26

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onPressed: (_) => {
          }
        }
      }

      StyledText {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "󰄄"
        font.pixelSize: 22

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onPressed: (_) => {
          }
        }
      }
    }
  }

  Item {
    implicitWidth: parent.width
    implicitHeight: timeContainer.height

    Rectangle {
      anchors.fill: parent
      color: Settings.colors.bgSoft
      radius: Settings.rounding.general
    }

    Column {
      anchors.horizontalCenter: parent.horizontalCenter
      id: timeContainer
      topPadding: 8
      bottomPadding: 8
      spacing: 8

      StyledText {
        id: time
        anchors.horizontalCenter: parent.horizontalCenter
        text: "00\n00"

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onPressed: (_) => {
          }
        }

        Process {
          id: timeProc
          command: ["date", "+%H:%M"]
          running: true
          stdout: SplitParser {
            onRead: data => time.text = data.split(":").join("\n")
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
}
