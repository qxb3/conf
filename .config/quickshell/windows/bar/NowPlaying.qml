import Quickshell
import Quickshell.Services.Mpris

import QtQuick
import QtQuick.Layouts

import "../../common"
import "../../common/widgets"

Item {
  id: root
  Layout.topMargin: 24
  implicitHeight: col.implicitHeight + 32
  clip: true

  readonly property var player: Mpris.players.values.filter(p => p.identity.toLowerCase() === "spotify")[0] ?? null
  readonly property bool playing: player?.playbackState === MprisPlaybackState.Playing
  readonly property real pos: player?.position ?? 0
  readonly property real len: player?.length ?? 0
  readonly property string artSource: player?.trackArtUrl ? player.trackArtUrl : Qt.resolvedUrl("../../assets/art/default.svg")
  readonly property string trackKey: (player?.trackTitle ?? "") + "|" + artSource
  property string lastKey: trackKey
  property int dir: 1
  property real lastPress: 0

  // Position only updates on signal, so emit it every 500ms while a player exists.
  Timer {
    interval: 500
    running: root.player !== null
    repeat: true
    onTriggered: root.player?.positionChanged()
  }

  function fmt(s) {
    const t = Math.floor(s)
    return Math.floor(t / 60) + ":" + String(t % 60).padStart(2, "0")
  }

  // The button press sets the direction and animates right away, so repeated presses always match.
  function slideTo(d) {
    dir = d
    ghostShift.x = 0
    faceShift.x = root.width * d
    slide.restart()
  }

  function press(d) {
    lastPress = Date.now()
    ghost.scheduleUpdate()
    slideTo(d)
  }

  // A track change within 3s of a press is already animated by that press. Any other change slides in from the right.
  onTrackKeyChanged: {
    if (trackKey === lastKey) return
    lastKey = trackKey
    if (Date.now() - lastPress > 8000) slideTo(1)
  }

  // Snapshot of the card as it was before the change, so the outgoing card can slide out.
  // It is captured while idle and sits under the live face, which is opaque.
  ShaderEffectSource {
    id: ghost

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    height: face.height
    sourceItem: face
    live: false
    hideSource: false

    transform: Translate {
      id: ghostShift
    }
  }

  Timer {
    interval: 250
    running: !slide.running
    repeat: true
    onTriggered: ghost.scheduleUpdate()
  }

  Component.onCompleted: ghost.scheduleUpdate()

  // Live card. Opaque, with its own border, so the snapshot moves as a whole card.
  Rectangle {
    id: face

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    height: col.implicitHeight + 32
    color: Colors.bg
    border.width: 1
    border.color: Colors.border

    transform: Translate {
      id: faceShift
    }

    ColumnLayout {
      id: col

      anchors.fill: parent
      anchors.margins: 16
      spacing: 12

      RowLayout {
        Layout.fillWidth: true
        spacing: 16

        Rectangle {
          Layout.preferredWidth: 182
          Layout.preferredHeight: 182
          Layout.alignment: Qt.AlignTop
          color: "transparent"
          border.width: 1
          border.color: Colors.border

          Image {
            anchors.fill: parent
            anchors.margins: 1
            source: root.artSource
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
          }
        }

        ColumnLayout {
          Layout.fillWidth: true
          Layout.fillHeight: true
          spacing: 4

          CText {
            Layout.fillWidth: true
            font.pixelSize: 30
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            text: root.player?.trackTitle ?? "Nothing playing"
          }

          CText {
            Layout.fillWidth: true
            font.pixelSize: 18
            font.bold: true
            color: Colors.accent
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            text: root.player?.trackArtist ?? "Unknown"
          }

          Item {
            Layout.fillHeight: true
          }

          RowLayout {
            Layout.fillWidth: true
            Layout.bottomMargin: 12
            spacing: 0

            IconButton {
              Layout.fillWidth: true
              flat: true
              animated: true
              icon: "skip-back"
              onClicked: {
                root.press(-1)
                root.player?.previous()
              }
            }

            IconButton {
              Layout.fillWidth: true
              flat: true
              animated: true
              icon: root.playing ? "pause" : "play"
              onClicked: root.player?.togglePlaying()
            }

            IconButton {
              Layout.fillWidth: true
              flat: true
              animated: true
              icon: "skip-forward"
              onClicked: {
                root.press(1)
                root.player?.next()
              }
            }
          }

          Item {
            id: progress

            readonly property real ratio: root.len > 0 ? Math.max(0, Math.min(1, root.pos / root.len)) : 0
            property bool seeking: false
            property real seekRatio: 0

            function setSeek(x) {
              seekRatio = Math.max(0, Math.min(1, x / width))
            }

            Layout.fillWidth: true
            Layout.preferredHeight: 12

            Rectangle {
              anchors.verticalCenter: parent.verticalCenter
              width: parent.width
              height: 6
              color: Colors.border

              Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.width * (progress.seeking ? progress.seekRatio : progress.ratio)
                color: Colors.primary
              }
            }

            MouseArea {
              anchors.fill: parent
              enabled: root.player?.canSeek ?? false
              cursorShape: Qt.PointingHandCursor

              onPressed: mouse => {
                progress.seeking = true
                progress.setSeek(mouse.x)
              }
              onPositionChanged: mouse => {
                if (progress.seeking) progress.setSeek(mouse.x)
              }
              onReleased: {
                if (root.player) root.player.position = progress.seekRatio * root.len
                progress.seeking = false
              }
              onCanceled: progress.seeking = false
            }
          }

          RowLayout {
            Layout.fillWidth: true
            Layout.topMargin: 8

            CText {
              font.pixelSize: 14
              color: Colors.dim
              text: root.fmt(root.pos)
            }

            Item {
              Layout.fillWidth: true
            }

            CText {
              font.pixelSize: 14
              color: Colors.dim
              text: root.fmt(root.len)
            }
          }
        }
      }
    }
  }

  // Old card leaves and new card enters together on the same curve as the panel tabs.
  ParallelAnimation {
    id: slide

    NumberAnimation {
      target: faceShift
      property: "x"
      to: 0
      duration: 380
      easing.type: Easing.InOutCubic
    }

    NumberAnimation {
      target: ghostShift
      property: "x"
      to: -root.width * root.dir
      duration: 380
      easing.type: Easing.InOutCubic
    }
  }
}
