import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

ColumnLayout {
  implicitWidth: parent.width
  anchors.top: parent.top
  anchors.left: parent.left
  anchors.right: parent.right
  spacing: 8

  MouseArea {
    Layout.fillWidth: true
    Layout.preferredHeight: 40
    cursorShape: Qt.PointingHandCursor
    onPressed: States.sidebar.isOpen = !States.sidebar.isOpen

    ClippingRectangle {
      id: profile
      anchors.fill: parent
      radius: Settings.rounding.full

      IconImage {
        anchors.fill: parent
        source: "file:///home/qxb3/.face"
      }
    }
  }

  // Horizontal Line.
  Rectangle {
    Layout.fillWidth: true
    Layout.preferredHeight: 1
    color: "transparent"

    Rectangle {
      anchors.fill: parent
      implicitWidth: parent.width
      implicitHeight: parent.width
      color: Settings.colors.bgSofter
    }
  }

  // AppLauncher Button.
  SectionButton {
    Layout.fillWidth: true
    Layout.preferredHeight: 40
    icon: ""
    active: States.sidebar.currentPage == "appLauncher"
    onPressed: (_) => {
      Process {
        command: ["quickshell", "ipc", "call", "sidebar", "toggle", "appLauncher"]
        running: true
      }
    }
  }

  // Wallpapers Button.
  SectionButton {
    Layout.fillWidth: true
    Layout.preferredHeight: 40
    icon: "󰸉"
    active: States.sidebar.currentPage == "wallpapers"
    onPressed: (_) => {}
  }

  // Themes Button.
  SectionButton {
    Layout.fillWidth: true
    Layout.preferredHeight: 40
    icon: ""
    active: States.sidebar.currentPage == "themes"
    onPressed: (_) => {}
  }

  // Systray stuff.
  ColumnLayout {
    Layout.fillWidth: true
    spacing: 0

    Item {
      property bool isOpen: false

      id: systray
      Layout.fillWidth: true
      implicitHeight: isOpen ? systrayItems.height : 0
      clip: true

      Behavior on implicitHeight {
        NumberAnimation {
          duration: Settings.animation.speed
          easing.type: Settings.animation.easing
        }
      }

      Column {
        id: systrayItems
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 8

        Repeater {
          model: SystemTray.items

          MouseArea {
            required property SystemTrayItem modelData
            required property int index

            id: systrayItem
            implicitWidth: 24
            implicitHeight: 24
            cursorShape: Qt.PointingHandCursor
            x: -100
            onPressed: (_) => {
            }

            states: State {
              when: systray.isOpen

              PropertyChanges {
                target: systrayItem
                x: 0
              }
            }

            transitions: Transition {
              NumberAnimation {
                properties: "x"
                duration: Settings.animation.speed * (index + 2)
                easing.type: Settings.animation.easing
              }
            }

            IconImage {
              anchors.fill: parent
              source: modelData.icon
            }
          }
        }
      }
    }

    MouseArea {
      id: systrayToggler
      Layout.fillWidth: true
      Layout.preferredHeight: systrayTogglerIcon.height
      cursorShape: Qt.PointingHandCursor
      onPressed: (_) => {
        systray.isOpen = !systray.isOpen
      }

      StyledText {
        id: systrayTogglerIcon
        anchors.horizontalCenter: parent.horizontalCenter
        text: systray.isOpen ? "󰅃" : "󰅀"
        font.pixelSize: 24
      }
    }
  }
}
