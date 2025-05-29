import Quickshell
import Quickshell.Wayland

import QtQuick
import QtQuick.Shapes

import "root:/common"
import "root:/common/services"
import "root:/common/widgets"

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property ShellScreen modelData
      screen: modelData

      WlrLayershell.layer: WlrLayer.Overlay
      anchors.top: true
      margins.top: 20
      implicitWidth: 500
      implicitHeight: 500
      color: "transparent"

      mask: Region { item: content }

      Rectangle {
        id: content
        implicitWidth: parent.width
        implicitHeight: popups.height
        color: "transparent"

        ListView {
          id: popups
          model: Notifications.popups
          implicitWidth: parent.width
          implicitHeight: {
            let height = (count - 1) * spacing
            for (let i = 0; i < count; i++)
              height += itemAtIndex(i)?.implicitHeight ?? 0

            return height
          }

          preferredHighlightBegin: 0
          preferredHighlightEnd: 0
          highlightFollowsCurrentItem: false
          spacing: 10

          add: Transition {
            NumberAnimation {
              properties: "y";
              from: -popups.height;
              duration: 500;
              easing.type: Easing.OutQuart
            }
          }

          remove: Transition {
            NumberAnimation {
              properties: "y";
              to: -popups.height;
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

          delegate: Notif { popup: true }
        }
      }
    }
  }
}
