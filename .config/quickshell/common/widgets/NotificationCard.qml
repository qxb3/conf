import QtQuick
import QtQuick.Layouts

import "../../common"
import "../../common/widgets"

// Shared notification row: image on the left, app name and summary, and a two-line body.
// The close button sits in the top-right corner. `scaled` multiplies every size in the card.
Rectangle {
  id: root

  required property var notification

  property real scaled: 1.0
  property int imageSize: 72
  property int textLeftMargin: 4

  signal closeRequested()

  implicitHeight: row.implicitHeight
  color: Colors.bg
  border.width: 1
  border.color: Colors.border

  RowLayout {
    id: row

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    spacing: 0

    Rectangle {
      Layout.preferredWidth: root.imageSize * root.scaled
      Layout.preferredHeight: root.imageSize * root.scaled
      Layout.maximumWidth: root.imageSize * root.scaled
      Layout.maximumHeight: root.imageSize * root.scaled
      Layout.margins: 8 * root.scaled
      Layout.alignment: Qt.AlignVCenter
      clip: true
      color: "transparent"
      border.width: 1
      border.color: Colors.border

      Image {
        anchors.fill: parent
        source: root.notification.image ? root.notification.image : Qt.resolvedUrl("../../assets/art/default.svg")
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        sourceSize: Qt.size(144 * root.scaled, 144 * root.scaled)
      }
    }

    ColumnLayout {
      Layout.fillWidth: true
      Layout.preferredWidth: 0
      Layout.minimumWidth: 0
      Layout.margins: 8 * root.scaled
      Layout.rightMargin: 32 * root.scaled
      Layout.leftMargin: root.textLeftMargin * root.scaled
      spacing: 2 * root.scaled

      CText {
        Layout.fillWidth: true
        font.pixelSize: 12 * root.scaled
        color: Colors.dim
        elide: Text.ElideRight
        text: root.notification.appName
      }

      CText {
        Layout.fillWidth: true
        font.pixelSize: 14 * root.scaled
        font.bold: true
        elide: Text.ElideRight
        text: root.notification.summary
      }

      Item {
        Layout.fillWidth: true
        implicitHeight: bodyText.implicitHeight

        CText {
          id: bodyText

          width: parent.width
          font.pixelSize: 12 * root.scaled
          color: Colors.dim
          wrapMode: Text.WrapAnywhere
          maximumLineCount: 2
          elide: Text.ElideRight
          text: root.notification.body
        }
      }
    }
  }

  IconButton {
    anchors.top: parent.top
    anchors.topMargin: 4 * root.scaled
    anchors.right: parent.right
    anchors.rightMargin: 4 * root.scaled
    flat: true
    animated: true
    buttonSize: 24 * root.scaled
    iconSize: 14 * root.scaled
    icon: "close"
    onClicked: root.closeRequested()
  }
}
