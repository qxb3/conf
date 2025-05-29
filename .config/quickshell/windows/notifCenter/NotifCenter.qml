import Quickshell

import QtQuick
import QtQuick.Shapes
import QtQuick.Controls

import "root:/common"
import "root:/common/services"
import "root:/common/widgets"

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property ShellScreen modelData
      screen: modelData

      anchors.top: true
      implicitWidth: 500
      implicitHeight: 300
      color: "transparent"

      mask: Region { item: content }

      Rectangle {
        anchors.fill: parent
        anchors.topMargin: 10
        color: "transparent"

        Rectangle {
          id: content
          implicitWidth: parent.width
          implicitHeight: parent.height
          color: Colors.bg
          y: GlobalState.isNotifCenterOpen ? 0 : -parent.height * 2
          clip: true

          Behavior on y {
            NumberAnimation {
              duration: 500
              easing.type: Easing.OutQuart
            }
          }

          Loader {
            active: Notifications.list.count == 0
            anchors.centerIn: parent

            sourceComponent: StyledText {
              text: "No Notifications"
              y: content.height

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
            id: notifs
            model: Notifications.list
            anchors.fill: parent
            anchors.margins: 15
            preferredHighlightBegin: 0
            preferredHighlightEnd: 0
            highlightFollowsCurrentItem: false
            spacing: 10
            clip: true

            add: Transition {
              NumberAnimation {
                properties: "y";
                from: -notifs.height;
                duration: 500;
                easing.type: Easing.OutQuart
              }
            }

            remove: Transition {
              NumberAnimation {
                properties: "y";
                to: -notifs.height;
                duration: 500;
                easing.type: Easing.OutQuart
              }
            }

            displaced: Transition {
              NumberAnimation {
                properties: "y";
                duration: 500;
                easing.type: Easing.OutQuart
              }
            }

            delegate: Notif {}
          }
        }

        Shape {
          anchors.fill: content

          ShapePath {
            strokeWidth: 0
            strokeColor: Colors.border
            fillColor: Colors.border

            // Borders.
            PathRectangle { x: 0; y: 0; width: content.width; height: 6 }
            PathRectangle { x: 0; y: 6; width: 6; height: content.height }
            PathRectangle { x: 6; y: content.height - 6; width: content.width - 12; height: 6 }
            PathRectangle { x: content.width - 6; y: 6; width: 6; height: content.height - 6 }

            // Corner Pixels.
            PathRectangle { x: 6; y: 6; width: 6; height: 6 }
            PathRectangle { x: content.width - 12; y: 6; width: 6; height: 6 }
            PathRectangle { x: 6; y: content.height - 12; width: 6; height: 6 }
            PathRectangle { x: content.width - 12; y: content.height - 12; width: 6; height: 6 }
          }
        }
      }
    }
  }
}
