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
      Layout.topMargin: -6
      icon: "file:///home/qxb3/.config/qs-comp/assets/skill1.png"
    }

    QuickApp {
      Layout.alignment: Qt.AlignCenter
      icon: "file:///home/qxb3/.config/qs-comp/assets/skill2.png"
    }

    QuickApp {
      Layout.alignment: Qt.AlignCenter
      icon: "file:///home/qxb3/.config/qs-comp/assets/skill3.png"
    }

    QuickApp {
      Layout.alignment: Qt.AlignCenter
      Layout.bottomMargin: 20
      icon: "file:///home/qxb3/.config/qs-comp/assets/skill4.png"
      func: () => {
      }
    }
  }
}

// Item {
//   Layout.preferredWidth: 110
//   Layout.preferredHeight: apps.height
//
//   Rectangle {
//     anchors.fill: parent
//     color: Colors.bg
//   }
//
//   ColumnLayout {
//     id: apps
//     implicitWidth: parent.width
//     spacing: 20
//
//     QuickApp {
//       id: termApp
//       Layout.alignment: Qt.AlignCenter
//       Layout.topMargin: -5
//       icon: "file:///home/qxb3/.config/qs-comp/assets/skill1.png"
//     }
//
//     QuickApp {
//       Layout.alignment: Qt.AlignCenter
//       icon: "file:///home/qxb3/.config/qs-comp/assets/skill2.png"
//     }
//
//     QuickApp {
//       Layout.alignment: Qt.AlignCenter
//       icon: "file:///home/qxb3/.config/qs-comp/assets/skill3.png"
//     }
//
//     QuickApp {
//       Layout.alignment: Qt.AlignCenter
//       Layout.bottomMargin: 20
//       icon: "file:///home/qxb3/.config/qs-comp/assets/skill4.png"
//       func: () => {
//       }
//     }
//   }
// }
