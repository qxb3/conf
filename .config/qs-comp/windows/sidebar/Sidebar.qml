import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property ShellScreen modelData
      screen: modelData

      anchors.top: true
      anchors.right: true
      anchors.bottom: true
      implicitWidth: 300
      exclusionMode: ExclusionMode.Ignore
      aboveWindows: false
      color: "transparent"

      Rectangle {
        property bool isOpen: false

        id: sidebarContainer
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 38
        anchors.rightMargin: 38
        implicitHeight: sidebarContainer.isOpen ? sidebarContent.height : 0
        color: "transparent"
        clip: true

        Behavior on implicitHeight {
          NumberAnimation {
            duration: 1000
            easing.type: Easing.OutQuart
          }
        }

        ColumnLayout {
          id: sidebarContent
          anchors.top: parent.top
          anchors.left: parent.left
          anchors.right: parent.right
          spacing: 32
          clip: true

          Time {}
          Status {}
          Calendar {}
          Music {}
        }
      }

      MouseArea {
        id: openerBtn
        anchors.top: sidebarContainer.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 38
        anchors.rightMargin: 38
        implicitHeight: openerContainer.height
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onPressed: sidebarContainer.isOpen = !sidebarContainer.isOpen

        Rectangle {
          anchors.fill: parent
          color: Colors.bg
          border.color: Colors.border
          border.width: 6
        }

        ColumnLayout {
          id: openerContainer
          anchors.left: parent.left
          anchors.right: parent.right

          CornerPixel {
            Layout.fillWidth: true
            Layout.preferredHeight: 6
            Layout.topMargin: 6
            Layout.leftMargin: 6
            Layout.rightMargin: 6
          }

          Shape {
            id: openerIcon
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: 34
            Layout.bottomMargin: 34
            scale: 10
            rotation: 0

            states: State {
              name: "rotation"
              when: sidebarContainer.isOpen

              PropertyChanges {
                target: openerIcon
                rotation: 180
              }
            }

            transitions: Transition {
              NumberAnimation {
                properties: "rotation"
                duration: 800
                easing.type: Easing.InOutSine
              }
            }

            ShapePath {
              strokeWidth: 0
              strokeColor: Colors.fg
              fillColor: Colors.fg

              PathRectangle { x: 0; y: 0; width: 1; height: 1 }
              PathRectangle { x: 1; y: 1; width: 1; height: 1 }
              PathRectangle { x: 2; y: 2; width: 1; height: 1 }
              PathRectangle { x: 3; y: 1; width: 1; height: 1 }
              PathRectangle { x: 4; y: 0; width: 1; height: 1 }
            }
          }

          CornerPixel {
            Layout.fillWidth: true
            Layout.preferredHeight: 6
            Layout.bottomMargin: 6
            Layout.leftMargin: 6
            Layout.rightMargin: 6
          }
        }
      }
    }
  }
}
