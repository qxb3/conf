import Quickshell
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

import "../../common"

Rectangle {
  id: root

  required property ShellScreen screen

  anchors.centerIn: parent
  implicitWidth: 28
  implicitHeight: column.implicitHeight + 16
  color: "transparent"
  border.width: 1
  border.color: Colors.border

  ColumnLayout {
    id: column
    anchors.centerIn: parent
    spacing: 4

    Repeater {
      model: Hyprland.workspaces.values
        .filter(w => w.monitor?.name === root.screen.name && w.id !== -1)
        .slice(0, 5)

      Rectangle {
        id: pill

        required property HyprlandWorkspace modelData

        readonly property bool isActive: modelData.active

        Layout.alignment: Qt.AlignHCenter
        implicitWidth: 10
        implicitHeight: isActive ? 48 : 30
        color: isActive ? Colors.primary : (mouse.containsMouse ? Colors.muted : Colors.border)

        Behavior on implicitHeight {
          NumberAnimation { duration: 260; easing.type: Easing.InOutCubic }
        }

        Behavior on color {
          ColorAnimation { duration: 260; easing.type: Easing.InOutCubic }
        }

        MouseArea {
          id: mouse
          anchors.fill: parent
          anchors.margins: -3
          cursorShape: Qt.PointingHandCursor
          hoverEnabled: true

          onPressed: pill.modelData.activate()
        }
      }
    }
  }
}
