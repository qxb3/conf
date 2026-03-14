import Quickshell.Services.Mpris

import QtQuick
import QtQuick.Layouts

import "../../common"
import "../../common/widgets"

RowLayout {
  property var player: Mpris.players.values.filter(p => p.identity.toLowerCase() === "spotify")[0]

  anchors.top: parent.top
  anchors.bottom: parent.bottom
  anchors.centerIn: parent
  spacing: 12
  clip: true
  visible: player !== undefined

  CText {
    text: `Playing - ${player !== null ? player?.trackTitle : ''}`
  }

  CText {
    text: "<"

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true

      onPressed: () => player?.previous()
    }
  }

  CText {
    text: {
      if (player?.playbackState === MprisPlaybackState.Playing) return '󰏤'
      if (player?.playbackState === MprisPlaybackState.Paused) return '󰐊'

      return '󰓛'
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true

      onPressed: () => player?.togglePlaying()
    }
  }

  CText {
    text: ">"

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true

      onPressed: () => player?.next()
    }
  }
}
