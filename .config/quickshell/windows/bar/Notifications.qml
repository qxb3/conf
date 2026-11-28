import Quickshell
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../../common"
import "../../common/widgets"

Rectangle {
  id: root
  Layout.topMargin: 24
  Layout.minimumHeight: header.implicitHeight + 32
  color: "transparent"
  border.width: 1
  border.color: Colors.border

  readonly property var items: NotificationState.sidebarItems

  // Clear one card at a time, top to bottom. The card whose id is leavingId slides out, then is removed.
  property var clearQueue: []
  property string leavingId: ""

  function clearAll() {
    clearQueue = items.slice().reverse()
    advanceClear()
  }

  function advanceClear() {
    if (clearQueue.length === 0) {
      leavingId = ""
      return
    }
    leavingId = clearQueue[0].id
    clearQueue = clearQueue.slice(1)
  }

  // ScriptModel diffs by identity, so the ListView gets real add and move events.
  ScriptModel {
    id: notifModel

    values: root.items.slice().reverse()
  }

  // Header is anchored to the top and never moves with the content below it.
  RowLayout {
    id: header

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.margins: 16

    CText {
      Layout.fillWidth: true
      font.pixelSize: 20
      font.bold: true
      text: "Notifications"
    }

    IconButton {
      flat: true
      animated: true
      enabled: root.items.length > 0
      iconColor: root.items.length > 0 ? Colors.fg : Colors.muted
      icon: "clear"
      onClicked: root.clearAll()
    }
  }

  // Empty state fills the space under the header and centers its content.
  Item {
    id: empty

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: header.bottom
    anchors.bottom: parent.bottom
    anchors.leftMargin: 16
    anchors.rightMargin: 16
    anchors.topMargin: 12
    anchors.bottomMargin: 16
    visible: root.items.length === 0

    ColumnLayout {
      anchors.centerIn: parent
      width: parent.width
      spacing: 8

      Icon {
        Layout.alignment: Qt.AlignHCenter
        iconName: "bell-off"
        size: 60
        color: Colors.dim
      }

      CText {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 14
        color: Colors.dim
        text: DndState.active ? "DnD is Active" : "No Notifications :("
      }
    }
  }

  // Scrollable list. New items slide in from the right; existing items are pushed down.
  ListView {
    id: list

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: header.bottom
    anchors.bottom: parent.bottom
    anchors.leftMargin: 16
    anchors.rightMargin: 16
    anchors.topMargin: 12
    anchors.bottomMargin: 16
    clip: true
    spacing: 12
    model: notifModel
    boundsBehavior: Flickable.StopAtBounds

    ScrollBar.vertical: ScrollBar {
      policy: ScrollBar.AlwaysOff
    }

    // Two parts, in order: the existing cards are pushed down (displaced), then the new card slides in.
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

    // Single removals (the card's own X) slide out to the right.
    remove: Transition {
      NumberAnimation {
        property: "x"
        to: list.width
        duration: 320
        easing.type: Easing.InCubic
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

      readonly property bool leaving: root.leavingId === modelData.id

      onLeavingChanged: {
        if (leaving) slideOut.start()
      }

      width: list.width
      implicitHeight: card.implicitHeight

      // Slides this card out during a clear, then removes it and starts the next card.
      NumberAnimation {
        id: slideOut

        target: wrap
        property: "x"
        to: list.width
        duration: 180
        easing.type: Easing.InCubic
        onFinished: {
          const entry = wrap.modelData
          root.advanceClear()
          NotificationState.removeEntry(entry)
        }
      }

      NotificationCard {
        id: card

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        notification: wrap.modelData
        imageSize: 86
        textLeftMargin: 12
        onCloseRequested: NotificationState.removeEntry(wrap.modelData)
      }
    }
  }
}
