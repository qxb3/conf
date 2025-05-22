import Quickshell
import Quickshell.Hyprland

import QtQuick

import "root:/common"

Item {
  anchors.centerIn: parent
  implicitWidth: parent.width
  implicitHeight: workspaceContainer.height

  Rectangle {
    anchors.fill: parent
    color: Settings.colors.bgSoft
    radius: Settings.rounding.general
  }

  Column {
    id: workspaceContainer
    anchors.horizontalCenter: parent.horizontalCenter
    topPadding: 16
    bottomPadding: 16
    spacing: 8

    Repeater {
      model: 5

      MouseArea {
        required property int modelData

        id: workspaceBtn
        implicitWidth: 10
        implicitHeight: Hyprland.focusedWorkspace.id == (modelData + 1) ? 64 : 32
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onPressed: (_) => {
          Hyprland.dispatch(`workspace ${modelData + 1}`)
        }

        Behavior on implicitHeight {
          NumberAnimation {
            duration: Settings.animation.speed
            easing.type: Settings.animation.easing
          }
        }

        states: State {
          when: workspaceBtn.containsMouse

          PropertyChanges {
            target: workspaceBtn
            implicitHeight: 48
          }

          PropertyChanges {
            target: workspaceContent
            color: Settings.colors.secondary
          }
        }

        transitions: Transition {
          NumberAnimation {
            target: workspaceBtn
            duration: Settings.animation.speed
            easing.type: Settings.animation.easing
          }

          ColorAnimation {
            target: workspaceContent
            duration: Settings.animation.speed
            easing.type: Settings.animation.easing
          }
        }

        Rectangle {
          id: workspaceContent
          anchors.fill: parent
          color: Hyprland.focusedWorkspace.id == (modelData + 1) ? Settings.colors.primary : Settings.colors.fg
          radius: Settings.rounding.workspace

          Behavior on color {
            ColorAnimation {
              duration: Settings.animation.speed
              easing.type: Settings.animation.easing
            }
          }
        }
      }
    }
  }
}
