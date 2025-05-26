import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

Item {
  id: topBar
  Layout.alignment: Qt.AlignTop
  Layout.fillWidth: true
  Layout.preferredHeight: 80

  Rectangle {
    anchors.fill: parent
    color: Colors.bg
  }

  Left {}
  Center {}
  Right {}
}
