import Quickshell
import Quickshell.Bluetooth
import Quickshell.Networking
import Quickshell.Services.Pipewire

import QtQuick
import QtQuick.Layouts

import "../../common"
import "../../common/widgets"

RowLayout {
  id: root
  Layout.topMargin: 20

  // Wired wins whenever a wired device is connected, even if wifi is also up.
  readonly property bool wired: Networking.devices.values.some(d => d.connected && d.type === DeviceType.Wired)

  readonly property var sink: Pipewire.defaultAudioSink
  readonly property bool btOn: Bluetooth.defaultAdapter?.enabled ?? false
  readonly property bool muted: sink?.audio?.muted ?? false

  PwObjectTracker {
    objects: [root.sink]
  }

  spacing: 0

  // Each slot is an equal share of the row. The column inside is centred on the slot,
  // so a wide label can't push its neighbours.
  Item {
    Layout.fillWidth: true
    Layout.preferredWidth: 1
    implicitHeight: wifiCol.implicitHeight

    ColumnLayout {
      id: wifiCol

      anchors.horizontalCenter: parent.horizontalCenter
      spacing: 6

      IconButton {
        Layout.alignment: Qt.AlignHCenter
        animated: true
        buttonSize: 86
        iconSize: 65
        flat: true
        icon: root.wired ? "wired" : "wifi"
      }

      CText {
        Layout.alignment: Qt.AlignHCenter
        font.pixelSize: 12
        font.letterSpacing: 2
        color: Colors.dim
        text: root.wired ? "WIRED" : "WIFI"
      }
    }
  }

  Item {
    Layout.fillWidth: true
    Layout.preferredWidth: 1
    implicitHeight: btCol.implicitHeight

    ColumnLayout {
      id: btCol

      anchors.horizontalCenter: parent.horizontalCenter
      spacing: 6

      IconButton {
        Layout.alignment: Qt.AlignHCenter
        animated: true
        buttonSize: 86
        iconSize: 60
        flat: true
        icon: root.btOn ? "bluetooth" : "bluetooth-off"
        iconColor: root.btOn ? Colors.fg : Colors.dim
        onClicked: {
          const adapter = Bluetooth.defaultAdapter
          if (adapter) adapter.enabled = !adapter.enabled
        }
      }

      CText {
        Layout.alignment: Qt.AlignHCenter
        font.pixelSize: 12
        font.letterSpacing: 2
        color: Colors.dim
        text: "BLUETOOTH"
      }
    }
  }

  Item {
    Layout.fillWidth: true
    Layout.preferredWidth: 1
    implicitHeight: audioCol.implicitHeight

    ColumnLayout {
      id: audioCol

      anchors.horizontalCenter: parent.horizontalCenter
      spacing: 6

      IconButton {
        Layout.alignment: Qt.AlignHCenter
        animated: true
        buttonSize: 86
        iconSize: 70
        flat: true
        icon: root.muted ? "audio-off" : "audio"
        iconColor: root.muted ? Colors.dim : Colors.fg
        onClicked: {
          if (root.sink?.audio) root.sink.audio.muted = !root.sink.audio.muted
        }
      }

      CText {
        Layout.alignment: Qt.AlignHCenter
        font.pixelSize: 12
        font.letterSpacing: 2
        color: Colors.dim
        text: root.muted ? "MUTED" : "SILENT"
      }
    }
  }

  Item {
    Layout.fillWidth: true
    Layout.preferredWidth: 1
    implicitHeight: dndCol.implicitHeight

    ColumnLayout {
      id: dndCol

      anchors.horizontalCenter: parent.horizontalCenter
      spacing: 6

      IconButton {
        Layout.alignment: Qt.AlignHCenter
        animated: true
        buttonSize: 86
        iconSize: 70
        flat: true
        icon: DndState.active ? "dnd-active" : "dnd"
        onClicked: DndState.active = !DndState.active
      }

      CText {
        Layout.alignment: Qt.AlignHCenter
        font.pixelSize: 12
        font.letterSpacing: 2
        color: Colors.dim
        text: "DND"
      }
    }
  }
}
