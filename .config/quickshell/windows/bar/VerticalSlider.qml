import QtQuick

import "../../common"
import "../../common/widgets"

Item {
  id: root

  property string icon: ""
  property real value: 0
  property bool muted: false

  property bool dragging: false
  property real dragValue: 0
  readonly property real shown: Math.min(1, Math.max(0, dragging ? dragValue : value))

  signal moved(real newValue)
  signal iconClicked()

  function setFrom(y) {
    const v = Math.max(0, Math.min(1, 1 - y / track.height))
    dragValue = v
    moved(v)
  }

  Item {
    id: track

    anchors.top: parent.top
    anchors.topMargin: 16
    anchors.horizontalCenter: parent.horizontalCenter
    width: 12
    anchors.bottom: icon.top
    anchors.bottomMargin: 8

    Rectangle {
      anchors.fill: parent
      color: Colors.border
    }

    Rectangle {
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: parent.bottom
      height: parent.height * root.shown
      color: root.muted ? Colors.dim : Colors.primary
    }

    MouseArea {
      anchors.fill: parent
      anchors.leftMargin: -8
      anchors.rightMargin: -8
      cursorShape: Qt.PointingHandCursor

      onPressed: mouse => {
        root.dragging = true
        root.setFrom(mouse.y)
      }
      onPositionChanged: mouse => {
        if (root.dragging) root.setFrom(mouse.y)
      }
      onReleased: root.dragging = false
      onCanceled: root.dragging = false
    }
  }

  Icon {
    id: icon

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 8
    iconName: root.icon
    size: 30
    color: root.muted ? Colors.dim : Colors.fg
  }

  MouseArea {
    anchors.fill: icon
    cursorShape: Qt.PointingHandCursor
    onClicked: root.iconClicked()
  }
}
