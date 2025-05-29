import QtQuick
import QtQuick.Shapes

import "root:/common"
import "root:/common/services"
import "root:/common/widgets"

Item {
  anchors.top: parent.bottom
  anchors.horizontalCenter: parent.horizontalCenter
  anchors.topMargin: 20
  implicitWidth: 500
  implicitHeight: 300

  Rectangle {
    id: notifCenter
    implicitWidth: parent.width
    implicitHeight: parent.height
    color: Colors.bg
    y: GlobalState.isNotifCenterOpen ? 0 : -500
    z: 0
    clip: true

    Behavior on y {
      NumberAnimation {
        duration: 500
        easing.type: Easing.OutQuart
      }
    }

    Item {
      anchors.fill: parent
      anchors.margins: 20

      Loader {
        active: Notifications.list.count == 0
        anchors.centerIn: parent

        sourceComponent: StyledText {
          text: "No Notifications"
          y: notifCenter.height

          Behavior on y {
            NumberAnimation {
              duration: 500
              easing.type: Easing.OutQuart
            }
          }

          Component.onCompleted: y = 0
        }
      }

      ListView {
        id: notifications
        anchors.fill: parent
        preferredHighlightBegin: 0
        preferredHighlightEnd: 0
        highlightFollowsCurrentItem: false
        spacing: 10

        model: Notifications.list

        add: Transition {
          NumberAnimation { properties: "y"; from: -100; duration: 500; easing.type: Easing.OutQuart }
        }

        remove: Transition {
          NumberAnimation { properties: "y"; to: -notifications.height; duration: 500; easing.type: Easing.OutQuart }
        }

        displaced: Transition {
          NumberAnimation { properties: "y"; duration: 500; easing.type: Easing.OutQuart }
        }

        delegate: Notif {}
      }
    }
  }

  Shape {
    anchors.fill: notifCenter
    z: 0

    ShapePath {
      strokeWidth: 0
      strokeColor: Colors.border
      fillColor: Colors.border

      // Borders.
      PathRectangle { x: 0; y: 0; width: notifCenter.width; height: 6 }
      PathRectangle { x: 0; y: 6; width: 6; height: notifCenter.height }
      PathRectangle { x: 6; y: notifCenter.height; width: notifCenter.width - 6; height: 6 }
      PathRectangle { x: notifCenter.width - 6; y: 6; width: 6; height: notifCenter.height - 6 }

      // Corner Pixels.
      PathRectangle { x: 6; y: 6; width: 6; height: 6 }
      PathRectangle { x: notifCenter.width - 12; y: 6; width: 6; height: 6 }
      PathRectangle { x: 6; y: notifCenter.height - 6; width: 6; height: 6 }
      PathRectangle { x: notifCenter.width - 12; y: notifCenter.height - 6; width: 6; height: 6 }
    }
  }
}
