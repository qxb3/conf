import QtQuick

import "../../common"

Rectangle {
  id: root

  property string icon: ""
  property color iconColor: Colors.fg
  property bool active: false
  property bool flat: false
  property bool animated: false
  property real iconRotation: 0
  property int buttonSize: 32
  property int iconSize: 22
  property bool filled: false
  property bool highlighted: false

  signal clicked()

  implicitWidth: root.buttonSize
  implicitHeight: root.buttonSize
  color: root.filled ? Colors.primary : (root.highlighted ? Colors.surface2 : "transparent")
  border.width: (mouse.containsMouse || root.highlighted) ? 1 : 0
  border.color: root.highlighted ? Colors.muted : Qt.rgba(1, 1, 1, 0.15)

  Behavior on color {
    ColorAnimation { duration: 220; easing.type: Easing.OutCubic }
  }

  Behavior on border.color {
    ColorAnimation { duration: 220; easing.type: Easing.OutCubic }
  }

  Icon {
    id: glyph

    anchors.centerIn: parent
    iconName: root.icon
    size: root.iconSize
    color: root.filled ? Colors.bg : ((root.active || mouse.containsMouse) ? Colors.primary : root.iconColor)

    rotation: root.iconRotation

    Behavior on rotation {
      NumberAnimation { duration: 320; easing.type: Easing.OutCubic }
    }

    Behavior on scale {
      NumberAnimation { duration: 260; easing.type: Easing.OutCubic }
    }

    Behavior on color {
      ColorAnimation { duration: 220; easing.type: Easing.OutCubic }
    }

    Behavior on opacity {
      NumberAnimation { duration: 220 }
    }
  }

  MouseArea {
    id: mouse
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true

    onPressed: root.clicked()
  }
}
