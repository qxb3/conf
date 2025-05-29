import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/services"
import "root:/common/widgets"

Item {
  required property int id
  required property string appName
  required property string summary
  required property string body
  property bool popup: false

  implicitWidth: parent.width
  implicitHeight: content.height

  Rectangle {
    anchors.fill: parent
    visible: popup
  }

  ColumnLayout {
    id: content
    implicitWidth: parent.width

    Item {
      Layout.preferredWidth: parent.width
      Layout.preferredHeight: top.height

      RowLayout {
        id: top
        implicitWidth: parent.width

        StyledText {
          text: "* " + appName
        }

        StyledText {
          text: "x"
          Layout.alignment: Qt.AlignRight

          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            onPressed: {
              if (popup)
                Notifications.removePopup(id)
              else
                Notifications.removeNotif(id)
            }
          }
        }
      }
    }

    Loader {
      active: summary.length > 0
      sourceComponent: StyledText {
        text: "    " + summary
        font.pixelSize: 25
      }
    }

    Loader {
      active: body.length > 0
      sourceComponent: StyledText {
        text: "    " + body
        font.pixelSize: 25
      }
    }
  }
}
