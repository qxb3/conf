import QtQuick

import "../../common"
import "../../common/widgets"

Item {
  id: root

  property date viewDate: new Date()
  readonly property int offset: new Date(viewDate.getFullYear(), viewDate.getMonth(), 1).getDay()
  readonly property int dim: new Date(viewDate.getFullYear(), viewDate.getMonth() + 1, 0).getDate()
  readonly property var weekdays: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

  function shiftMonth(n) {
    viewDate = new Date(viewDate.getFullYear(), viewDate.getMonth() + n, 1)
  }

  function isToday(day) {
    const now = new Date()
    return day === now.getDate() && viewDate.getMonth() === now.getMonth() && viewDate.getFullYear() === now.getFullYear()
  }

  width: 272
  height: panel.height
  clip: true
  visible: CalendarState.shown

  Connections {
    target: CalendarState

    function onOpenChanged() {
      if (CalendarState.open) {
        root.viewDate = new Date()
        CalendarState.shown = true
      } else {
        closeTimer.restart()
      }
    }
  }

  Timer {
    id: closeTimer

    interval: 280
    onTriggered: CalendarState.shown = false
  }

  Rectangle {
    id: panel

    width: root.width
    height: content.height + 32
    x: CalendarState.open ? 0 : -width
    color: Colors.bg
    border.width: 1
    border.color: Colors.border

    Behavior on x {
      NumberAnimation { duration: 260; easing.type: Easing.OutCubic }
    }

    Item {
      id: content

      x: 16
      y: 16
      width: panel.width - 32
      height: header.height + 8 + grid.height

      Item {
        id: header

        width: parent.width
        height: 20

        CText {
          id: prevButton

          anchors.left: parent.left
          anchors.verticalCenter: parent.verticalCenter
          text: "<"

          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onPressed: root.shiftMonth(-1)
          }
        }

        CText {
          anchors.centerIn: parent
          text: Qt.formatDateTime(root.viewDate, "MMMM yyyy")
        }

        CText {
          id: nextButton

          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          text: ">"

          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onPressed: root.shiftMonth(1)
          }
        }
      }

      Grid {
        id: grid

        y: header.height + 8
        width: parent.width
        columns: 7
        spacing: 2

        readonly property real cellWidth: (width - spacing * 6) / 7

        Repeater {
          model: 49

          Rectangle {
            required property int index

            readonly property bool isHeader: index < 7
            readonly property int day: index - 7 - root.offset + 1
            readonly property bool valid: !isHeader && day >= 1 && day <= root.dim

            width: grid.cellWidth
            height: isHeader ? 16 : 26
            color: valid && root.isToday(day) ? Colors.primary : "transparent"

            CText {
              anchors.centerIn: parent
              visible: parent.isHeader || parent.valid
              font.pixelSize: parent.isHeader ? 12 : 16
              color: parent.isHeader ? Colors.dim : (root.isToday(parent.day) ? Colors.bg : Colors.fg)
              text: parent.isHeader ? root.weekdays[parent.index] : parent.day
            }
          }
        }
      }
    }
  }
}
