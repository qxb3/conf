import Quickshell

import QtQuick
import QtQuick.Layouts

import "../../common"
import "../../common/widgets"

Rectangle {
  id: root

  readonly property int menuWidth: 200
  readonly property int slideDistance: 16

  width: menuWidth
  height: content.implicitHeight + 32
  property string screenName: ""
  readonly property bool isOpen: TrayMenuState.open && TrayMenuState.screen === screenName

  x: TrayMenuState.anchorX + 20
  y: TrayMenuState.anchorY
  color: Colors.bg
  border.width: 1
  border.color: Colors.border
  focus: isOpen
  clip: true
  opacity: isOpen ? 1 : 0

  transform: Translate {
    y: isOpen ? 0 : -root.slideDistance

    Behavior on y {
      NumberAnimation { duration: 260; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.2, 0.8, 0.3, 1, 1, 1] }
    }
  }

  Behavior on opacity {
    NumberAnimation { duration: 260; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.2, 0.8, 0.3, 1, 1, 1] }
  }

  Keys.onEscapePressed: TrayMenuState.open = false

  // Swallows clicks on the menu background so they don't reach the outside catcher.
  MouseArea {
    anchors.fill: parent
  }

  QsMenuOpener {
    id: opener

    menu: TrayMenuState.item ? TrayMenuState.item.menu : null
  }

  ColumnLayout {
    id: content

    anchors.fill: parent
    anchors.margins: 16
    spacing: 8

    Repeater {
      model: opener.children

      Item {
        id: entry

        required property QsMenuEntry modelData

        Layout.fillWidth: true
        implicitHeight: modelData.isSeparator ? 9 : label.implicitHeight + 8

        Rectangle {
          visible: entry.modelData.isSeparator
          anchors.verticalCenter: parent.verticalCenter
          width: parent.width
          height: 1
          color: Colors.muted
        }

        CText {
          id: label

          visible: !entry.modelData.isSeparator
          anchors.verticalCenter: parent.verticalCenter
          font.pixelSize: 14
          color: !entry.modelData.enabled ? Colors.muted : (entryMouse.containsMouse ? Colors.primary : Colors.dim)
          text: entry.modelData.text
        }

        MouseArea {
          id: entryMouse

          anchors.fill: parent
          enabled: !entry.modelData.isSeparator && entry.modelData.enabled
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            entry.modelData.triggered()
            TrayMenuState.open = false
          }
        }
      }
    }
  }
}
