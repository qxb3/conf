import QtQuick

import "root:/common"
import "root:/common/widgets"

Item {
  clip: true

  Rectangle {
    anchors.fill: parent
    implicitWidth: parent.width
    implicitHeight: parent.height
    anchors.margins: 8
    color: Settings.colors.bg
  }

  StyledText {
    text: "App launcher"
  }
}
