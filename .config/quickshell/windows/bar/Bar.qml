import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland

import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

import "./game"
import "./topbar"

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property ShellScreen modelData
      screen: modelData

      anchors.top: true
      anchors.left: true
      anchors.right: true
      exclusiveZone: GlobalState.isGaming ? 200 : 80
      color: "transparent"
      mask: Region {}
    }
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: root

      required property ShellScreen modelData
      screen: modelData

      anchors.top: true
      anchors.left: true
      anchors.right: true
      anchors.bottom: true
      exclusionMode: ExclusionMode.Ignore
      color: "transparent"

      mask: Region {
        Region { item: stats }
        Region { item: quickApps }
        Region { item: topBar }
      }

      Game { id: game }

      Rectangle {
        id: normalStuff
        anchors.top: game.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "transparent"

        Rectangle {
          id: leftBar
          implicitWidth: 325
          implicitHeight: leftBarContent.height
          x: GlobalState.isLeftbarOpen ? 0 : -leftBar.width
          color: "transparent"
          clip: true

          Behavior on x {
            NumberAnimation {
              duration: 500
              easing.type: Easing.OutQuart
            }
          }

          ColumnLayout {
            id: leftBarContent
            implicitWidth: parent.width
            spacing: 0

            Stats { id: stats }
            QuickApps { id: quickApps }
          }

          Shape {
            anchors.fill: parent

            ShapePath {
              strokeWidth: 0
              strokeColor: Colors.border
              fillColor: Colors.border

              // Stats + QuickApps vertical border.
              PathRectangle { x: 0; y: 0; width: 6; height: leftBar.height }

              // Stats borders.
              PathRectangle { x: quickApps.width; y: stats.height; width: (stats.width - quickApps.width); height: 6 }
              PathRectangle { x: stats.width - 6; y: topBar.height; width: 6; height: (stats.height - topBar.height) }

              // QuickApps borders.
              PathRectangle { x: 6; y: leftBar.height - 6; width: quickApps.width - 6; height: 6 }
              PathRectangle { x: quickApps.width - 6; y: stats.height; width: 6; height: quickApps.height - 6 }

              // Corner Pixels.
              PathRectangle { x: 6; y: 6; width: 6; height: 6 }
              PathRectangle { x: stats.width - 12; y: stats.height - 6; width: 6; height: 6 }
              PathRectangle { x: 6; y: leftBar.height - 12; width: 6; height: 6 }
              PathRectangle { x: quickApps.width - 12; y: leftBar.height - 12; width: 6; height: 6 }
            }
          }
        }

        Rectangle {
          id: topBar

          anchors.left: leftBar.right
          anchors.right: parent.right
          implicitHeight: 80
          z: 1

          Topbar {}
        }

        Shape {
          anchors.fill: normalStuff
          z: 1

          ShapePath {
            strokeWidth: 0
            strokeColor: Colors.border
            fillColor: Colors.border

            // Topbar borders.
            PathRectangle { x: 0; y: 0; width: root.width; height: 6 }
            PathRectangle { x: leftBar.x + stats.width - 6; y: topBar.height - 6; width: root.width + 6; height: 6 }
            PathRectangle { x: root.width - 6; y: 6; width: 6; height: topBar.height - 12 }

            // Corner Pixels.
            PathRectangle { x: root.width - 12; y: 6; width: 6; height: 6 }
            PathRectangle { x: root.width - 12; y: topBar.height - 12; width: 6; height: 6 }
          }
        }
      }
    }
  }
}
