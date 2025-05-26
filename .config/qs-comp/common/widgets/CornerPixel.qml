import QtQuick

import "root:/common"

Rectangle {
  property bool showLeft: true
  property bool showRight: true

  color: "transparent"

  Rectangle {
    anchors.left: parent.left
    implicitWidth: 6
    implicitHeight: 6
    color: Colors.border
    visible: showLeft
  }

  Rectangle {
    anchors.right: parent.right
    implicitWidth: 6
    implicitHeight: 6
    color: Colors.border
    visible: showRight
  }
}
