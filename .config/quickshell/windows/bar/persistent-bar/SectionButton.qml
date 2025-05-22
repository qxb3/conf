import Quickshell
import Quickshell.Widgets

import QtQuick

import "root:/common"
import "root:/common/widgets"

MouseArea {
  required property string icon
  required property bool active

  id: button
  hoverEnabled: true
  cursorShape: Qt.PointingHandCursor

  states: State {
    when: button.containsMouse || active

    PropertyChanges {
      target: content
      color: Settings.colors.primary
    }

    PropertyChanges {
      target: bottomBorder
      xScale: 1.02
    }
  }

  transitions: Transition {
    ColorAnimation {
      target: content
      duration: Settings.animation.speed
      easing.type: Settings.animation.easing
    }

    NumberAnimation {
      target: bottomBorder
      property: "xScale"
      duration: Settings.animation.speed
      easing.type: Settings.animation.easing
    }
  }

  Rectangle {
    id: content
    anchors.fill: parent
    color: Settings.colors.bgSoft
    radius: Settings.rounding.general
    z: 1

    StyledText {
      anchors.centerIn: parent
      font.pixelSize: 24
      text: icon
    }
  }

  Rectangle {
    anchors.fill: content
    radius: Settings.rounding.general
    z: 0

    transform: Scale {
      id: bottomBorder
      origin.x: 40
      xScale: 0
    }
  }
}
