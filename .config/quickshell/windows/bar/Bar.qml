import Quickshell
import QtQuick

import "root:/common"

import "./persistent-bar"
import "./sidebar"

Scope {
  id: bar

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: barWindow

      property ShellScreen modelData
      screen: modelData

      anchors {
        left: true
        top: true
        bottom: true
      }

      implicitWidth: 450
      exclusiveZone: 50
      color: "transparent"

      mask: Region {
        width: States.sidebar.isOpen ? barWindow.implicitWidth : barWindow.exclusiveZone
        height: barWindow.height
      }

      Item {
        anchors.fill: parent

        Row {
          id: barContent
          anchors.fill: parent

          Sidebar {}
          PersistentBar {}
        }
      }
    }
  }
}
