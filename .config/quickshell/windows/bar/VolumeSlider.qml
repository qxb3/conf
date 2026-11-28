import QtQuick
import QtQuick.Layouts

import "../../common"
import "../../common/widgets"

RowLayout {
  id: root

  property string icon: ""
  property real value: 0
  property bool muted: false

  property bool dragging: false
  property real dragValue: 0
  readonly property real shown: dragging ? dragValue : value

  signal moved(real newValue)

  function setFrom(x) {
    const v = Math.max(0, Math.min(1, x / track.width))
    dragValue = v
    moved(v)
  }

  spacing: 12

  signal iconClicked()

  Item {
    Layout.preferredWidth: 30
    Layout.preferredHeight: 30

    Icon {
      anchors.centerIn: parent
      iconName: root.icon
      size: 30
      color: root.muted ? Colors.dim : Colors.fg
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onClicked: root.iconClicked()
    }
  }

  Item {
    id: track

    Layout.fillWidth: true
    Layout.preferredHeight: 20
    clip: true

    Rectangle {
      anchors.verticalCenter: parent.verticalCenter
      width: parent.width
      height: 20
      color: Colors.border
    }

    Rectangle {
      anchors.verticalCenter: parent.verticalCenter
      width: parent.width * root.shown
      height: 20
      color: root.muted ? Colors.dim : Colors.primary
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor

      onPressed: mouse => {
        root.dragging = true
        root.setFrom(mouse.x)
      }
      onPositionChanged: mouse => {
        if (root.dragging) root.setFrom(mouse.x)
      }
      onReleased: root.dragging = false
      onCanceled: root.dragging = false
    }
  }
}
