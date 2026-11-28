import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire

import QtQuick

import "../../common"
import "../../common/widgets"

Item {
  id: root

  property string screenName: ""
  readonly property bool isOpen: VolumeState.isOn(screenName)

  readonly property var sink: Pipewire.defaultAudioSink
  readonly property var player: Mpris.players.values.filter(p => p.identity.toLowerCase() === "spotify")[0]
  readonly property real musicVolume: player?.volume ?? 0
  property real musicLastVolume: 0.5

  PwObjectTracker {
    objects: [root.sink]
  }

  function toggleMusicMute() {
    if (!player) return
    if (player.volume > 0) {
      musicLastVolume = player.volume
      player.volume = 0
    } else {
      player.volume = musicLastVolume
    }
  }

  width: 84
  height: 291
  anchors.bottom: parent.bottom
  anchors.bottomMargin: 8
  clip: true
  visible: isOpen || panel.x > -root.width

  // Slides in from the left edge of this clipped frame, like the calendar.
  Rectangle {
    id: panel

    width: root.width
    height: root.height
    x: root.isOpen ? 0 : -root.width
    color: Colors.bg
    border.width: 1
    border.color: Colors.border

    Behavior on x {
      NumberAnimation { duration: 260; easing.type: Easing.OutCubic }
    }

    // Swallows clicks on the background so they don't reach the outside catcher.
    MouseArea {
      anchors.fill: parent
    }

    Item {
      id: sliders

      anchors.fill: parent
      clip: true

      VerticalSlider {
        x: 0
        width: 48
        height: parent.height
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

      VerticalSlider {
        x: 36
        width: 48
        height: parent.height
        icon: root.musicVolume === 0 ? "music-muted" : "music"
        value: root.musicVolume
        muted: root.musicVolume === 0
        onMoved: newValue => {
          if (root.player) root.player.volume = newValue
        }
        onIconClicked: root.toggleMusicMute()
      }
    }
  }
}
