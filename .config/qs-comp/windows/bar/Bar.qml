import Quickshell

import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

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
      anchors.bottom: true
      exclusionMode: ExclusionMode.Ignore
      aboveWindows: false
      color: "transparent"

      RowLayout {
        id: container
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 0

        Item {
          id: leftBar
          Layout.preferredWidth: 325
          Layout.preferredHeight: leftBarContent.height

          ColumnLayout {
            id: leftBarContent
            implicitWidth: parent.width
            spacing: 0

            Stats { id: stats }
            QuickApps { id: quickApps }
          }
        }

        Topbar { id: topBar }
      }

      Shape {
        ShapePath {
          strokeWidth: 0
          strokeColor: Colors.border
          fillColor: Colors.border

          // Borders.
          PathRectangle { x: 0; y: 0; width: container.width; height: 6 }
          PathRectangle { x: 0; y: 6; width: 6; height: container.height - 6 }
          PathRectangle { x: 6; y: container.height - 6; width: quickApps.width - 6; height: 6 }
          PathRectangle { x: quickApps.width - 6; y: stats.height; width: 6; height: quickApps.height - 6 }
          PathRectangle { x: quickApps.width - 6; y: stats.height - 6; width: stats.width - quickApps.width; height: 6 }
          PathRectangle { x: stats.width - 6; y: topBar.height; width: 6; height: stats.height - topBar.height }
          PathRectangle { x: stats.width - 6; y: topBar.height - 6; width: topBar.width + 6; height: 6 }
          PathRectangle { x: stats.width + topBar.width - 6; y: 6; width: 6; height: topBar.height - 12 }

          // Corner Pixels.
          PathRectangle { x: 6; y: 6; width: 6; height: 6 }
          PathRectangle { x: stats.width + topBar.width - 12; y: 6; width: 6; height: 6 }
          PathRectangle { x: stats.width + topBar.width - 12; y: topBar.height - 12; width: 6; height: 6 }
          PathRectangle { x: stats.width - 12; y: stats.height - 12; width: 6; height: 6 }
          PathRectangle { x: 6; y: container.height - 12; width: 6; height: 6 }
          PathRectangle { x: quickApps.width - 12; y: container.height - 12; width: 6; height: 6 }
        }
      }
    }
  }
}
