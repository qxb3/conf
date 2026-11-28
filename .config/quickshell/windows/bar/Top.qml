import Quickshell
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

import "../../common"
import "../../common/widgets"

ColumnLayout {
  id: top

  anchors.top: parent.top
  anchors.horizontalCenter: parent.horizontalCenter
  anchors.topMargin: 8
  spacing: 6

  property bool trayOpen: false

  onTrayOpenChanged: trayOpen ? autoClose.restart() : autoClose.stop()

  Timer {
    id: autoClose

    interval: 15000
    onTriggered: top.trayOpen = false
  }

  // Avatar.
  Rectangle {
    Layout.alignment: Qt.AlignHCenter
    implicitWidth: 32
    implicitHeight: 32
    color: Colors.surface
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
      size: 22
      color: Colors.primary
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true
      onPressed: BarState.expanded = !BarState.expanded
    }
  }

  // Separator between the avatar and the buttons.
  Item {
    Layout.alignment: Qt.AlignHCenter
    implicitWidth: 32
    implicitHeight: 13

    Rectangle {
      anchors.centerIn: parent
      width: parent.width
      height: 1
      color: Colors.muted
    }
  }

  IconButton {
    animated: true
    Layout.alignment: Qt.AlignHCenter
    icon: "search"
    active: BarState.expanded && BarState.tab === 1
    filled: active
    onClicked: active ? BarState.open(0) : BarState.open(1)
  }

  IconButton {
    animated: true
    Layout.alignment: Qt.AlignHCenter
    icon: "image"
    active: BarState.expanded && BarState.tab === 2
    filled: active
    onClicked: active ? BarState.open(0) : BarState.open(2)
  }

  // Separator between the palette icon and the tray.
  Item {
    Layout.alignment: Qt.AlignHCenter
    implicitWidth: 32
    implicitHeight: 13

    Rectangle {
      anchors.centerIn: parent
      width: parent.width
      height: 1
      color: Colors.muted
    }
  }

  // System tray: slides open below the palette icon.
  Item {
    id: trayWrap

    Layout.alignment: Qt.AlignHCenter
    Layout.preferredWidth: 32
    implicitWidth: 32
    implicitHeight: top.trayOpen ? trayColumn.implicitHeight : 0
    clip: true
    visible: height > 0

    Behavior on implicitHeight {
      NumberAnimation { duration: 260; easing.type: Easing.OutCubic }
    }

    ColumnLayout {
      id: trayColumn

      width: parent.width
      spacing: 6

      Repeater {
        model: SystemTray.items.values

        Item {
          required property SystemTrayItem modelData

          Layout.alignment: Qt.AlignHCenter
          implicitWidth: 32
          implicitHeight: 32

          Image {
            anchors.centerIn: parent
            width: 22
            height: 22
            source: modelData.icon
            sourceSize: Qt.size(44, 44)
            smooth: true
            opacity: trayMouse.containsMouse ? 1 : 0.7

            Behavior on opacity {
              NumberAnimation { duration: 220 }
            }
          }

          MouseArea {
            id: trayMouse
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            onPressed: modelData.activate()
          }
        }
      }
    }
  }

  IconButton {
    Layout.alignment: Qt.AlignHCenter
    Layout.topMargin: -6
    flat: true
    icon: "chevron-down"
    iconRotation: top.trayOpen ? 180 : 0
    iconColor: Colors.dim
    onClicked: top.trayOpen = !top.trayOpen
  }
}
