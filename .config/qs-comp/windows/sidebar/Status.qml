import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

Item {
  implicitWidth: parent.width
  implicitHeight: statusContainer.height

  Rectangle {
    anchors.fill: parent
    color: Colors.bg
    border.color: Colors.border
    border.width: 6
  }

  ColumnLayout {
    id: statusContainer
    anchors.left: parent.left
    anchors.right: parent.right

    CornerPixel {
      Layout.fillWidth: true
      Layout.preferredHeight: 6
      Layout.topMargin: 6
      Layout.leftMargin: 6
      Layout.rightMargin: 6
    }

    IconImage {
      Layout.alignment: Qt.AlignCenter
      Layout.topMargin: 24
      Layout.bottomMargin: 24
      implicitWidth: 80
      implicitHeight: 80
      smooth: false
      source: "file:///home/qxb3/.config/qs-comp/assets/status.png"
    }

    CornerPixel {
      Layout.fillWidth: true
      Layout.preferredHeight: 6
      Layout.bottomMargin: 6
      Layout.leftMargin: 6
      Layout.rightMargin: 6
    }
  }
}
