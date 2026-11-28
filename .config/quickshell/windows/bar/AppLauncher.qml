import Quickshell
import Quickshell.Io
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "../../common"
import "../../common/widgets"
import "./fuzzy.js" as Fuzzy

Item {
  id: root

  readonly property bool shown: BarState.expanded && BarState.tab === 1

  onShownChanged: if (shown) searchInput.forceActiveFocus()
  readonly property var launchableApps: DesktopEntries.applications.values.filter(e => !e.noDisplay && !e.hidden && !e.terminal)
  readonly property var results: Fuzzy.fuzz(searchInput.text, launchableApps, ["name", "id", "genericName", "comment"], usageOf)

  function usageOf(entry) {
    return usageData.counts[entry.id] ?? 0
  }

  function launch(entry) {
    if (!entry) return

    BarState.expanded = false
    searchInput.text = ""

    const counts = Object.assign({}, usageData.counts)
    counts[entry.id] = (counts[entry.id] ?? 0) + 1
    usageData.counts = counts
    mkdirUsage.running = true

    entry.execute()
  }

  FileView {
    id: usageFile

    path: Quickshell.env("HOME") + "/.local/state/quickshell/launcher-usage.json"
    watchChanges: true
    atomicWrites: true
    onFileChanged: reload()

    JsonAdapter {
      id: usageData
      property var counts: ({})
    }
  }

  Process {
    id: mkdirUsage

    command: ["mkdir", "-p", Quickshell.env("HOME") + "/.local/state/quickshell"]
    onExited: usageFile.writeAdapter()
  }

  ColumnLayout {
    anchors.fill: parent
    spacing: 8

    TextField {
      id: searchInput

      Layout.fillWidth: true

      implicitHeight: 44
      leftPadding: 26
      rightPadding: 10
      background: Rectangle {
        color: Colors.bg

        Rectangle {
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.bottom: parent.bottom
          height: 1
          color: Colors.border
        }
      }
      color: Colors.fg
      font.family: "Iosevka Nerd Font Mono"
      font.pixelSize: 18

      onTextChanged: appList.selectedIndex = 0
      onAccepted: root.launch(root.results[appList.selectedIndex])

      Keys.onDownPressed: {
        if (appList.selectedIndex < root.results.length - 1) appList.selectedIndex++
        appList.positionViewAtIndex(appList.selectedIndex, ListView.Contain)
      }

      Keys.onUpPressed: {
        if (appList.selectedIndex > 0) appList.selectedIndex--
        appList.positionViewAtIndex(appList.selectedIndex, ListView.Contain)
      }

      Keys.onTabPressed: (event) => {
        if (appList.selectedIndex < root.results.length - 1) appList.selectedIndex++
        appList.positionViewAtIndex(appList.selectedIndex, ListView.Contain)
        event.accepted = true
      }

      Keys.onEscapePressed: BarState.expanded = false

      CText {
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 18
        color: Colors.primary
        text: ">"
      }
    }

    ListView {
      id: appList

      property int selectedIndex: 0

      Layout.fillWidth: true
      Layout.fillHeight: true
      clip: true
      model: root.results

      delegate: Rectangle {
        required property var modelData
        required property int index

        width: ListView.view.width
        height: 48
        color: index === appList.selectedIndex ? Colors.primary : "transparent"

        IconImage {
          id: appIcon

          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.leftMargin: 8
          width: 32
          height: 32
          source: Quickshell.iconPath(modelData.icon, "application-x-executable")
        }

        CText {
          id: label

          anchors.verticalCenter: parent.verticalCenter
          anchors.left: appIcon.right
          anchors.leftMargin: 12
          anchors.right: parent.right
          anchors.rightMargin: 8
          elide: Text.ElideRight
          font.pixelSize: 16
          text: modelData.name
          color: index === appList.selectedIndex ? Colors.bg : Colors.fg
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          hoverEnabled: true

          onClicked: root.launch(modelData)
        }
      }
    }
  }
}
