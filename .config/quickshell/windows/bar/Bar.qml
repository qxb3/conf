import Quickshell
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

import "../../common"

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar

      required property ShellScreen modelData
      screen: modelData

      anchors.top: true
      anchors.left: true
      anchors.right: true

      margins.top: 10
      margins.left: 10
      margins.right: 10

      implicitHeight: 24
      color: "transparent"

      Rectangle {
        id: bg
        anchors.fill: parent
        color: Colors.bg
      }

      Left {}
      Right {}
    }
  }
}
