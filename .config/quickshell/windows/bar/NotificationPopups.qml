import Quickshell
import Quickshell.Wayland

import QtQuick
import QtQuick.Layouts

import "../../common"
import "../../common/widgets"

PanelWindow {
  id: root

  anchors.top: true
  anchors.right: true
  margins.top: 8
  margins.right: 8

  implicitWidth: 420
  // Fixed height, so the layer surface never resizes while popups slide.
  implicitHeight: 600
  color: "transparent"
  exclusiveZone: 0
  // Always mapped: the list must already be laid out when the first popup arrives, or its add slide is skipped.
  visible: true

  // Only the popup stack takes clicks; the rest of the fixed-height window passes them through.
  mask: Region {
    item: hitbox
  }

  Item {
    id: hitbox

    anchors.top: parent.top
    anchors.right: parent.right
    width: root.implicitWidth
    height: list.contentHeight
  }

  ListView {
    id: list

    anchors.fill: parent
    spacing: 8
    interactive: false
    clip: true
    model: ScriptModel {
      values: NotificationState.popups
    }

    // Same two-part sequence as the sidebar list.
    add: Transition {
      SequentialAnimation {
        PropertyAction {
          property: "x"
          value: list.width
        }

        PauseAnimation {
          duration: 380
        }

        NumberAnimation {
          property: "x"
          from: list.width
          to: 0
          duration: 380
          easing.type: Easing.InOutCubic
        }
      }
    }

    // Removed popup slides out to the right.
    remove: Transition {
      NumberAnimation {
        property: "x"
        to: list.width
        duration: 380
        easing.type: Easing.InOutCubic
      }
    }

    // Remaining popups wait for the slide-out, then move up into the gap.
    removeDisplaced: Transition {
      SequentialAnimation {
        PauseAnimation {
          duration: 380
        }

        NumberAnimation {
          property: "y"
          duration: 380
          easing.type: Easing.InOutCubic
        }
      }
    }

    displaced: Transition {
      NumberAnimation {
        property: "y"
        duration: 380
        easing.type: Easing.InOutCubic
      }
    }

    delegate: Item {
      id: wrap

      required property var modelData

      width: list.width
      implicitHeight: card.implicitHeight

      // Popup lifetime: hides itself after 5s. The sidebar keeps the notification.
      Timer {
        interval: 5000
        running: true
        onTriggered: NotificationState.hidePopup(wrap.modelData)
      }

      NotificationCard {
        id: card

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        notification: wrap.modelData
        scaled: 1.2
        onCloseRequested: {
          NotificationState.hidePopup(wrap.modelData)
        }
      }
    }
  }
}
