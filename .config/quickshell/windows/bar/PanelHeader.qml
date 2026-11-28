import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import "../../common"
import "../../common/widgets"

Rectangle {
  id: root

  property string host: ""

  implicitWidth: 468
  implicitHeight: row.implicitHeight + 32
  color: Colors.bg
  border.width: 1
  border.color: Colors.border

  FileView {
    path: "/etc/hostname"
    onLoaded: root.host = text().trim()
  }

  RowLayout {
    id: row

    anchors.fill: parent
    anchors.margins: 16
    spacing: 16

    // Profile picture.
    Rectangle {
      Layout.preferredWidth: 96
      Layout.preferredHeight: 96
      Layout.alignment: Qt.AlignTop
      color: "transparent"
      border.width: 1
      border.color: Colors.border

      Image {
        id: avatar

        anchors.fill: parent
        anchors.margins: 1
        source: "file://" + Quickshell.env("HOME") + "/.face"
        fillMode: Image.PreserveAspectCrop
        visible: status === Image.Ready
      }

      Icon {
        anchors.centerIn: parent
        visible: avatar.status !== Image.Ready
        iconName: "user"
        size: 34
        color: Colors.primary
      }
    }

    // Name and label, stacked.
    ColumnLayout {
      Layout.fillWidth: true
      Layout.fillHeight: true
      spacing: 4

      CText {
        Layout.fillWidth: true
        font.pixelSize: 32
        elide: Text.ElideRight
        text: Quickshell.env("USER") + "@" + root.host
      }

      CText {
        Layout.fillWidth: true
        font.pixelSize: 18
        font.bold: true
        font.letterSpacing: 3
        color: Colors.primary
        text: "HYPRLAND"
      }
    }

    // Power: opens the menu beside the button.
    IconButton {
      id: powerButton

      animated: true
      Layout.alignment: Qt.AlignVCenter
      buttonSize: 48
      iconSize: 34
      icon: "power"
      iconColor: Colors.red
      onClicked: {
        if (PowerState.open) {
          PowerState.open = false
          return
        }
        const p = powerButton.mapToItem(null, 0, 0)
        PowerState.show(p.x + powerButton.width, p.y + powerButton.height + 8)
      }
    }
  }
}
