import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import Qt.labs.platform

import "../../common"

Rectangle {
  anchors.left: sidebar.right
  implicitWidth: 45
  implicitHeight: parent.height
  topRightRadius: 16
  bottomRightRadius: 16
  color: Config.theme.bg

  Behavior on anchors.left {
    NumberAnimation {
      duration: Config.anim.duration
      easing.type: Easing.OutQuint
    }
  }

  // Top.
  ColumnLayout {
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.topMargin: 8
    anchors.bottomMargin: 8
    anchors.leftMargin: 4
    anchors.rightMargin: 4

    ClippingWrapperRectangle {
      Layout.fillWidth: true
      Layout.preferredHeight: 38
      color: "red"
      radius: 999
      clip: true

      AnimatedImage {
        anchors.fill: parent
        playing: true
        fillMode: Image.PreserveAspectCrop
        source: `${Config.homeDir}/.face`
      }
    }
  }
}
