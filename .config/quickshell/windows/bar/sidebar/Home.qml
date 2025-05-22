import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

Item {
  clip: true

  Rectangle {
    anchors.fill: parent
    anchors.margins: 8
    color: Settings.colors.bg
    clip: true

    ColumnLayout {
      anchors.fill: parent
      spacing: 8

      Item {
        id: userHeader
        Layout.fillWidth: true
        Layout.preferredHeight: userHeaderContent.height

        Rectangle {
          anchors.fill: parent
          color: Settings.colors.bgSoft
          radius: Settings.rounding.general
        }

        RowLayout {
          id: userHeaderContent
          implicitWidth: parent.width
          implicitHeight: parent.height

          ClippingRectangle {
            Layout.preferredWidth: 80
            Layout.preferredHeight: 80
            Layout.margins: 8
            radius: Settings.rounding.full

            AnimatedImage {
              anchors.fill: parent
              source: "file:///home/qxb3/Downloads/foo.gif"
              playing: true
            }
          }

          Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 8

            ColumnLayout {
              anchors.verticalCenter: parent.verticalCenter

              StyledText {
                text: "qxb3"
                font.pixelSize: 24
                color: Settings.colors.primary
              }

              StyledText {
                text: "HYPRLAND"
                font.pixelSize: 16
              }
            }
          }

          ClippingRectangle {
            Layout.preferredWidth: 50
            Layout.preferredHeight: 50
            Layout.margins: 8
            radius: Settings.rounding.full

            StyledText {
              anchors.centerIn: parent
              text: "󰐥"
              font.pixelSize: 28
            }

            MouseArea {
              anchors.fill: parent
              cursorShape: Qt.PointingHandCursor
            }
          }
        }
      }

      Item {
        id: desktopControls
        Layout.fillWidth: true
        Layout.preferredHeight: desktopControlsContent.height

        ColumnLayout {
          id: desktopControlsContent

          ClippingRectangle {
            Layout.preferredWidth: 50
            Layout.preferredHeight: 50
            Layout.margins: 16
            radius: Settings.rounding.full

            IconImage {
              anchors.centerIn: parent
              source: "file:///usr/share/icons/Adwaita/symbolic/places/folder-symbolic.svg"
            }

            MouseArea {
              anchors.fill: parent
              cursorShape: Qt.PointingHandCursor
            }
          }
        }
      }

      Item {
        Layout.fillWidth: true
        Layout.fillHeight: true

        Rectangle {
          anchors.fill: parent
          color: Settings.colors.bgSoft
          radius: Settings.rounding.general
        }
      }
    }
  }
}
