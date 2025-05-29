import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

Item {
  id: quickApps
  Layout.preferredWidth: 110
  Layout.preferredHeight: quickAppsContent.height

  Rectangle {
    anchors.fill: parent
    color: Colors.bg
  }

  ColumnLayout {
    id: quickAppsContent
    implicitWidth: parent.width
    spacing: 20

    QuickApp {
      id: termApp
      Layout.alignment: Qt.AlignCenter
      icon: `file:///${Quickshell.shellRoot}/assets/skill1.png`
    }

    QuickApp {
      Layout.alignment: Qt.AlignCenter
      icon: `file:///${Quickshell.shellRoot}/assets/skill2.png`
    }

    QuickApp {
      Layout.alignment: Qt.AlignCenter
      icon: `file:///${Quickshell.shellRoot}/assets/skill3.png`
    }

    QuickApp {
      Layout.alignment: Qt.AlignCenter
      Layout.bottomMargin: 20
      icon: `file:///${Quickshell.shellRoot}/assets/skill4.png`
      func: () => {
      }
    }
  }
}
