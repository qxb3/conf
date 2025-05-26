import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

Item {
  Layout.topMargin: 38
  implicitWidth: parent.width
  implicitHeight: timeContainer.height

  Rectangle {
    anchors.fill: parent
    color: Colors.bg
    border.color: Colors.border
    border.width: 6
  }

  ColumnLayout {
    id: timeContainer
    anchors.left: parent.left
    anchors.right: parent.right

    CornerPixel {
      Layout.fillWidth: true
      Layout.preferredHeight: 6
      Layout.topMargin: 6
      Layout.leftMargin: 6
      Layout.rightMargin: 6
    }

    StyledText {
      id: time
      Layout.alignment: Qt.AlignCenter
      Layout.topMargin: 24
      Layout.bottomMargin: 24
      text: "00:00"

      Process {
        id: timeProc
        command: ["date", "+%I : %M"]
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

    CornerPixel {
      Layout.fillWidth: true
      Layout.preferredHeight: 6
      Layout.bottomMargin: 6
      Layout.leftMargin: 6
      Layout.rightMargin: 6
    }
  }
}
