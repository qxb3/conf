import QtQuick

import "../../../common"

Rectangle {
  implicitWidth: SessionState.sidebarActive ? 400 : 0
  implicitHeight: parent.height
  color: Config.theme.bg
  clip: true

  Behavior on implicitWidth {
    NumberAnimation {
      duration: Config.anim.duration
      easing.type: Easing.OutQuint
    }
  }

  // Right divider.
  Rectangle {
    anchors.right: parent.right
    implicitWidth: 1
    implicitHeight: parent.height
    color: Config.theme.fg
  }
}
