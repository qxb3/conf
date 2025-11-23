import Quickshell

import QtQuick
import QtQuick.Layouts

import "../../common"

import "./sidebar"

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property ShellScreen modelData

      screen: modelData

      anchors.left: true
      anchors.top: true
      anchors.bottom: true

      implicitWidth: 45
      color: "transparent"

      mask: Region {}
    }
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property ShellScreen modelData

      screen: modelData

      anchors.left: true
      anchors.top: true
      anchors.bottom: true

      implicitWidth: 445
      exclusionMode: ExclusionMode.Ignore
      focusable: true

      color: "transparent"

      mask: Region {
        Region { item: sidebar }
        Region { item: bar }
      }

      Sidebar { id: sidebar }
      BarItself { id: bar }
    }
  }
}
