import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import "../../common/widgets"

RowLayout {
  anchors.right: parent.right
  anchors.top: parent.top
  anchors.bottom: parent.bottom

  CText {
    id: timeText
    text: "00:00"

    Process {
      id: timeProc
      command: ["date", "+%b %d, %Y %a - %I : %M %p"]
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
