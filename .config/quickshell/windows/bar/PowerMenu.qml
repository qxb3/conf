import Quickshell

import QtQuick
import QtQuick.Layouts

import "../../common"
import "../../common/widgets"

Rectangle {
  id: root

  readonly property int menuWidth: 200
  readonly property int slideDistance: 16

  width: menuWidth
  height: content.implicitHeight + 32
  x: PowerState.anchorX - width
  y: PowerState.anchorY
  color: Colors.bg
  border.width: 1
  border.color: Colors.border
  focus: PowerState.open
  clip: true
  opacity: PowerState.open ? 1 : 0

  transform: Translate {
    id: slideShift

    y: PowerState.open ? 0 : -root.slideDistance

    Behavior on y {
      NumberAnimation { duration: 260; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.2, 0.8, 0.3, 1, 1, 1] }
    }
  }

  Behavior on opacity {
    NumberAnimation { duration: 260; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.2, 0.8, 0.3, 1, 1, 1] }
  }

  Keys.onEscapePressed: PowerState.open = false

  // Swallows clicks on the menu background so they don't reach the outside catcher.
  MouseArea {
    anchors.fill: parent
  }

  function run(cmd) {
    PowerState.open = false
    Quickshell.execDetached(cmd)
  }

  ColumnLayout {
    id: content

    anchors.fill: parent
    anchors.margins: 16
    spacing: 8

    CText {
      Layout.fillWidth: true
      font.pixelSize: 14
      font.bold: true
      font.letterSpacing: 3
      color: Colors.dim
      text: "POWER"
    }

    Repeater {
      model: [
        { label: "Shutdown", cmd: ["systemctl", "poweroff"] },
        { label: "Reboot", cmd: ["systemctl", "reboot"] },
        { label: "Sleep", cmd: ["systemctl", "suspend"] },
        { label: "Lock", cmd: ["hyprlock"] },
        { label: "Log out", cmd: ["hyprctl", "dispatch", "exit"] }
      ]

      Rectangle {
        required property var modelData

        Layout.fillWidth: true
        implicitHeight: 36
        color: "transparent"
        border.width: 1
        border.color: optionMouse.containsMouse ? Colors.muted : Colors.border

        CText {
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.leftMargin: 12
          text: modelData.label
          color: optionMouse.containsMouse ? Colors.primary : Colors.fg
        }

        MouseArea {
          id: optionMouse

          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          hoverEnabled: true

          onClicked: root.run(modelData.cmd)
        }
      }
    }
  }
}
