import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

Item {
  id: topBar
  anchors.fill: parent

  Rectangle {
    anchors.fill: parent
    color: Colors.bg

    Left {}
    Center {}
    Right {}
  }
}
