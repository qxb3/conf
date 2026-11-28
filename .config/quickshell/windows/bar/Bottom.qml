import Quickshell
import Quickshell.Services.Mpris

import QtQuick
import QtQuick.Layouts

import "../../common"
import "../../common/widgets"

ColumnLayout {
  id: root

  property var player: Mpris.players.values.filter(p => p.identity.toLowerCase() === "spotify")[0]

  anchors.bottom: parent.bottom
  anchors.horizontalCenter: parent.horizontalCenter
  anchors.bottomMargin: 8
  spacing: 6

  // Controls group.
  Rectangle {
    Layout.alignment: Qt.AlignHCenter
    implicitWidth: 40
    implicitHeight: controls.implicitHeight + 16
    color: "transparent"
    border.width: 0

    ColumnLayout {
      id: controls
      anchors.centerIn: parent
      spacing: 6

      // Media: toggles play / pause, lit while playing.
      IconButton {
        flat: true
        animated: true
        Layout.alignment: Qt.AlignHCenter
        icon: "headphones"
      }

      IconButton {
        flat: true
        animated: true
        Layout.alignment: Qt.AlignHCenter
        icon: "sliders"
        onClicked: Quickshell.execDetached(["pavucontrol"])
      }

      IconButton {
        flat: true
        animated: true
        Layout.alignment: Qt.AlignHCenter
        icon: "aperture"
        onClicked: Quickshell.execDetached(["sh", "-c", "grim -g \"$(slurp)\" - | wl-copy"])
      }
    }
  }

  // Clock.
  Rectangle {
    id: clockBox

    Layout.alignment: Qt.AlignHCenter
    implicitWidth: 40
    implicitHeight: clockColumn.implicitHeight + 16
    color: (CalendarState.open || clockMouse.containsMouse) ? Colors.surface2 : "transparent"
    border.width: 1
    border.color: (CalendarState.open || clockMouse.containsMouse) ? Colors.muted : Qt.rgba(1, 1, 1, 0.15)

    Behavior on color {
      ColorAnimation { duration: 220; easing.type: Easing.OutCubic }
    }

    Behavior on border.color {
      ColorAnimation { duration: 220; easing.type: Easing.OutCubic }
    }

    MouseArea {
      id: clockMouse
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true
      onPressed: CalendarState.open = !CalendarState.open
    }

    SystemClock {
      id: clock
      precision: SystemClock.Minutes
    }

    // One formatted string, split into hour, minute and AM/PM.
    readonly property var timeParts: Qt.formatDateTime(clock.date, "hh mm AP").split(" ")

    ColumnLayout {
      id: clockColumn
      anchors.centerIn: parent
      spacing: 6

      CText {
        Layout.alignment: Qt.AlignHCenter
        font.pixelSize: 18
        text: parent.parent.timeParts[0]
      }

      CText {
        Layout.alignment: Qt.AlignHCenter
        font.pixelSize: 18
        text: parent.parent.timeParts[1]
      }

      CText {
        Layout.alignment: Qt.AlignHCenter
        font.pixelSize: 18
        color: Colors.accent
        text: parent.parent.timeParts[2]
      }
    }
  }
}
