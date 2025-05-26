import Quickshell.Widgets
import QtQuick

import "root:/common"

Item {
  id: root
  required property string icon
  property Component process
  property var func

  implicitWidth: 70
  implicitHeight: 70

  Rectangle {
    anchors.fill: parent
    color: Colors.border
  }

  Rectangle {
    id: content
    implicitWidth: parent.width
    implicitHeight: parent.height

    Behavior on y {
      NumberAnimation {
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

    Rectangle {
      anchors.fill: parent
      implicitWidth: 50
      implicitHeight: 50
      color: Colors.bgSoft
      border.color: Colors.border
      border.width: 6

      IconImage {
        anchors.centerIn: parent
        implicitWidth: 40
        implicitHeight: 40
        source: icon
      }
    }
  }

  MouseArea {
    id: btn

    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true

    onEntered: content.y = -15
    onExited: content.y = 0
    onPressed: () => {
      content.y = 0
      content.scale = 0.93
      scaleTimer.running = true

      if (process)
        process.createObject(parent)

      if (func)
        func()
    }

    Timer {
      id: scaleTimer
      interval: 250
      running: false
      onTriggered: content.scale = 1
    }
  }
}
