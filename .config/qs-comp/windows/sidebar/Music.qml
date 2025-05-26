import Quickshell.Widgets
import Quickshell.Services.Mpris

import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

Item {
  property MprisPlayer spotifyPlayer: Mpris.players.values.find(p => p.identity == "Spotify") ?? null

  Layout.bottomMargin: 38
  implicitWidth: parent.width
  implicitHeight: statusContainer.height

  Rectangle {
    anchors.fill: parent
    color: Colors.bg
    border.color: Colors.border
    border.width: 6
  }

  ColumnLayout {
    id: statusContainer
    anchors.left: parent.left
    anchors.right: parent.right

    CornerPixel {
      Layout.fillWidth: true
      Layout.preferredHeight: 6
      Layout.topMargin: 6
      Layout.leftMargin: 6
      Layout.rightMargin: 6
    }

    Item {
      Layout.alignment: Qt.AlignCenter
      Layout.fillWidth: true
      Layout.preferredHeight: songTitle.height
      Layout.leftMargin: 32
      Layout.rightMargin: 32
      Layout.topMargin: 24
      Layout.bottomMargin: 24

      StyledText {
        id: songTitle
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        elide: Text.ElideRight
        wrapMode: Text.NoWrap
        maximumLineCount: 1
        text: spotifyPlayer != null ? spotifyPlayer.trackTitle : "No Music"
        font.pixelSize: 30
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
