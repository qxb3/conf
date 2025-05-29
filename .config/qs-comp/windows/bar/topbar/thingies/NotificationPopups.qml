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
  implicitHeight: notifPopups.height

  ListView {
    id: notifPopups
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

    model: Notifications.popups

    add: Transition {
      NumberAnimation { properties: "y"; from: -100; duration: 500; easing.type: Easing.OutQuart }
    }

    remove: Transition {
      NumberAnimation { properties: "y"; to: -notifPopups.height; duration: 500; easing.type: Easing.OutQuart }
    }

    displaced: Transition {
      NumberAnimation { properties: "y"; duration: 500; easing.type: Easing.OutQuart }
    }

    delegate: Notif { popup: true }
  }
}
