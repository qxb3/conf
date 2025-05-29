import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes

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
  implicitHeight: container.height

  Rectangle {
    id: container
    anchors.left: parent.left
    anchors.right: parent.right
    implicitHeight: content.height
    color: Colors.bg

    ColumnLayout {
      id: content
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.leftMargin: popup ? 20 : 0
      anchors.rightMargin: popup ? 20 : 0
      implicitWidth: parent.width

      Item {
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: top.height
        Layout.topMargin: popup ? 20 : 0

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

      Rectangle {
        Layout.bottomMargin: popup ? 20 : 0
      }
    }

    Shape {
      anchors.fill: container
      visible: popup

      ShapePath {
        strokeWidth: 0
        strokeColor: Colors.border
        fillColor: Colors.border

        PathRectangle { x: 0; y: 0; width: container.width; height: 6 }
        PathRectangle { x: 0; y: container.height - 6; width: container.width; height: 6 }
        PathRectangle { x: 0; y: 6; width: 6; height: container.height - 12 }
        PathRectangle { x: container.width - 6; y: 6; width: 6; height: container.height - 12 }
      }
    }
  }
}
