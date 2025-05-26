import Quickshell.Io
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

import "./calendar_layout.js" as CalendarLayout

Item {
  property int monthShift: 0
  property var viewingDate: CalendarLayout.getDateInXMonthsTime(monthShift)
  property var calendarLayout: CalendarLayout.getCalendarLayout(viewingDate, monthShift === 0)

  implicitWidth: parent.width
  implicitHeight: calendarContainer.height

  Rectangle {
    anchors.fill: parent
    color: Colors.bg
    border.color: Colors.border
    border.width: 6
  }

  ColumnLayout {
    id: calendarContainer
    anchors.left: parent.left
    anchors.right: parent.right

    CornerPixel {
      Layout.fillWidth: true
      Layout.preferredHeight: 6
      Layout.topMargin: 6
      Layout.leftMargin: 6
      Layout.rightMargin: 6
    }

    ColumnLayout {
      Layout.alignment: Qt.AlignCenter
      Layout.fillWidth: true
      Layout.topMargin: 12
      Layout.bottomMargin: 12
      spacing: 0

      StyledText {
        id: monthText
        Layout.alignment: Qt.AlignCenter
        text: "Jan"

        Process {
          id: monthTextProc
          command: ["date", "+%b"]
          running: true
          stdout: SplitParser {
            onRead: data => monthText.text = data
          }
        }

        Timer {
          interval: 300000
          running: true
          repeat: true
          onTriggered: monthTextProc.running = true
        }
      }

      StyledText {
        id: monthDayText
        Layout.alignment: Qt.AlignCenter
        text: "00"
        font.pixelSize: 80

        Process {
          id: monthDayTextProc
          command: ["date", "+%d"]
          running: true
          stdout: SplitParser {
            onRead: data => monthDayText.text = data
          }
        }

        Timer {
          interval: 300000
          running: true
          repeat: true
          onTriggered: monthDayTextProc.running = true
        }
      }

      ColumnLayout {
        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true

        // Week days.
        RowLayout {
          Layout.alignment: Qt.AlignHCenter
          Layout.fillWidth: true

          Repeater {
            model: CalendarLayout.weekDays

            StyledText {
              text: modelData.day
              font.pixelSize: 20
            }
          }
        }

        Repeater {
          model: 5

          RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            spacing: 7

            Repeater {
              model: Array(7).fill(modelData)

              StyledText {
                text: calendarLayout[modelData][index].day
                font.pixelSize: 19
              }
            }
          }
        }
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
