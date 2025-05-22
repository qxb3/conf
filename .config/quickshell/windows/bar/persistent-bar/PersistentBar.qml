import QtQuick

import "root:/common"

Rectangle {
  implicitWidth: 50
  implicitHeight: parent.height
  color: Settings.colors.bg
  topRightRadius: Settings.rounding.bar
  bottomRightRadius: Settings.rounding.bar

  Rectangle {
    anchors.fill: parent
    anchors.margins: 4
    anchors.topMargin: 10
    anchors.bottomMargin: 10
    anchors.leftMargin: 6
    anchors.rightMargin: 6
    color: "transparent"

    Top {}
    Center {}
    Bottom {}
  }
}
