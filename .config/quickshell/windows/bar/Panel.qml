import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris

import QtQuick
import QtQuick.Layouts

import "../../common"

Item {
  id: root

  readonly property var sink: Pipewire.defaultAudioSink
  readonly property var player: Mpris.players.values.filter(p => p.identity.toLowerCase() === "spotify")[0]
  property real musicLastVolume: 0.5
  property string screenName: ""

  PwObjectTracker {
    objects: [root.sink]
  }

  anchors.fill: parent
  anchors.margins: 16
  clip: true

  Item {
    id: stage

    anchors.fill: parent

    // Page 0: header and status row, stacked vertically.
    ColumnLayout {
      width: stage.width
      height: stage.height
      x: (0 - BarState.tab) * stage.width
      spacing: 0

      Behavior on x {
        enabled: !BarState.snapTabs
        NumberAnimation { duration: 200; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.2, 0.8, 0.3, 1, 1, 1] }
      }

      PanelHeader {
        Layout.fillWidth: true
      }

      StatusRow {
        Layout.fillWidth: true
      }

      ColumnLayout {
        Layout.fillWidth: true
        Layout.topMargin: 32
        spacing: 12

        // Desktop volume.
        VolumeSlider {
          Layout.fillWidth: true
          icon: (root.sink?.audio?.muted ?? false) || (root.sink?.audio?.volume ?? 1) === 0 ? "audio-muted" : "audio"
          value: root.sink?.audio?.volume ?? 0
          muted: root.sink?.audio?.muted ?? false
          onMoved: newValue => {
            if (root.sink?.audio) root.sink.audio.volume = newValue
          }
          onIconClicked: {
            if (root.sink?.audio) root.sink.audio.muted = !root.sink.audio.muted
          }
        }

        // Music volume (Spotify).
        VolumeSlider {
          Layout.fillWidth: true
          icon: (root.player?.volume ?? 1) === 0 ? "music-muted" : "music"
          value: root.player?.volume ?? 0
          muted: (root.player?.volume ?? 1) === 0
          onMoved: newValue => {
            if (root.player) root.player.volume = newValue
          }
          onIconClicked: {
            if (!root.player) return
            if (root.player.volume > 0) {
              root.musicLastVolume = root.player.volume
              root.player.volume = 0
            } else {
              root.player.volume = root.musicLastVolume
            }
          }
        }
      }

      NowPlaying {
        Layout.fillWidth: true
      }

      Notifications {
        Layout.fillWidth: true
        Layout.fillHeight: true
      }
    }

    // Page 2: gallery (placeholder).
    Gallery {
      width: stage.width
      height: stage.height
      x: (2 - BarState.tab) * stage.width

      Behavior on x {
        enabled: !BarState.snapTabs
        NumberAnimation { duration: 200; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.2, 0.8, 0.3, 1, 1, 1] }
      }
    }

    // Page 1: app launcher.
    AppLauncher {
      screenName: root.screenName
      width: stage.width
      height: stage.height
      x: (1 - BarState.tab) * stage.width

      Behavior on x {
        enabled: !BarState.snapTabs
        NumberAnimation { duration: 200; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.2, 0.8, 0.3, 1, 1, 1] }
      }
    }
  }
}
