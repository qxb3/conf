import Quickshell
import Quickshell.Io

import QtQuick

import "../../common"
import "../../common/widgets"

Item {
  id: root

  property var wallpapers: []

  // Lists the wallpaper folder once when the tab is created, keeping only image files.
  Process {
    running: true
    command: ["sh", "-c", "find -L ~/.config/awww/ -maxdepth 1 -type f | sort"]

    stdout: StdioCollector {
      onStreamFinished: root.wallpapers = text.split("\n").filter(s => /\.(png|jpe?g|webp|gif)$/i.test(s))
    }
  }

  CText {
    anchors.centerIn: parent
    visible: root.wallpapers.length === 0
    font.pixelSize: 14
    color: Colors.dim
    text: "No wallpapers in ~/.config/awww"
  }

  GridView {
    id: grid

    anchors.fill: parent
    clip: true
    cellWidth: width
    cellHeight: Math.floor(cellWidth * 0.3)
    model: root.wallpapers
    boundsBehavior: Flickable.StopAtBounds

    delegate: Item {
      required property var modelData

      width: grid.cellWidth
      height: grid.cellHeight

      Rectangle {
        anchors.fill: parent
        anchors.margins: 4
        color: Colors.surface
        clip: true
        border.width: 1
        border.color: mouse.containsMouse ? Colors.primary : Colors.border

        // Decoded at thumbnail size and cropped to fill, so large wallpapers stay cheap to draw.
        Image {
          anchors.fill: parent
          anchors.margins: 1
          source: "file://" + modelData
          fillMode: Image.PreserveAspectCrop
          asynchronous: true
          sourceSize: Qt.size(320, 200)
        }

        MouseArea {
          id: mouse

          anchors.fill: parent
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            BarState.expanded = false
            Quickshell.execDetached(["sh", "-c", "sleep 0.25; awww img \"$1\" -o HDMI-A-1 --transition-type wipe --transition-angle 40 --transition-duration 2 --transition-fps 60 & sleep 0.25; awww img \"$1\" -o DP-1 --transition-type wipe --transition-angle 40 --transition-duration 2 --transition-fps 60; wait", "sh", modelData])
          }
        }
      }
    }
  }
}
