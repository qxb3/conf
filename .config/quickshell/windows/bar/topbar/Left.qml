import Quickshell.Hyprland
import QtQuick

import "root:/common"
import "root:/common/widgets"

Item {
  id: left
  anchors.left: parent.left
  anchors.leftMargin: 15
  implicitWidth: 120
  implicitHeight: parent.height

  Rectangle {
    id: currentWorkspaceBg
    anchors.left: work1.left
    anchors.right: work1.right
    anchors.top: work1.top
    anchors.bottom: work1.bottom
    anchors.margins: -4
    color: Colors.border
    state: "work" + Hyprland.focusedWorkspace?.id ?? ''

    states: [
      State {
        name: "work1"
        AnchorChanges { target: currentWorkspaceBg; anchors.left: work1.left; anchors.right: work1.right; anchors.top: work1.top; anchors.bottom: work1.bottom }
      },

      State {
        name: "work2"
        AnchorChanges { target: currentWorkspaceBg; anchors.left: work2.left; anchors.right: work2.right; anchors.top: work2.top; anchors.bottom: work2.bottom }
      },

      State {
        name: "work3"
        AnchorChanges { target: currentWorkspaceBg; anchors.left: work3.left; anchors.right: work3.right; anchors.top: work3.top; anchors.bottom: work3.bottom }
      },

      State {
        name: "work4"
        AnchorChanges { target: currentWorkspaceBg; anchors.left: work4.left; anchors.right: work4.right; anchors.top: work4.top; anchors.bottom: work4.bottom }
      },

      State {
        name: "work5"
        AnchorChanges { target: currentWorkspaceBg; anchors.left: work5.left; anchors.right: work5.right; anchors.top: work5.top; anchors.bottom: work5.bottom }
      }
    ]

    transitions: Transition {
      AnchorAnimation {
        duration: 250
        easing.type: Easing.OutQuart
      }
    }
  }

  StyledText {
    id: work1
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    text: "I"

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true

      onPressed: () => Hyprland.dispatch("workspace 1")
    }
  }

  StyledText {
    id: work2
    anchors.left: work1.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: 18
    text: "II"

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true

      onPressed: () => Hyprland.dispatch("workspace 2")
    }
  }

  StyledText {
    id: work3
    anchors.left: work2.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: 25
    text: "III"

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true

      onPressed: () => Hyprland.dispatch("workspace 3")
    }
  }

  StyledText {
    id: work4
    anchors.left: work3.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: 32
    text: "IV"

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true

      onPressed: () => Hyprland.dispatch("workspace 4")
    }
  }

  StyledText {
    id: work5
    anchors.left: work4.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: 32
    text: "V"

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true

      onPressed: () => Hyprland.dispatch("workspace 5")
    }
  }
}
