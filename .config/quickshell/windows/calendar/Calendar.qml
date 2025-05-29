import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

import "root:/common"
import "root:/common/widgets"

import "./calendar_layout.js" as CalendarLayout

Scope {
  property int monthShift: 0
  property var viewingDate: CalendarLayout.getDateInXMonthsTime(monthShift)
  property var calendarLayout: CalendarLayout.getCalendarLayout(viewingDate, monthShift === 0)

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property ShellScreen modelData
      screen: modelData

      anchors.top: true
      anchors.right: true
      implicitWidth: 270
      implicitHeight: content.height
      color: "transparent"

      mask: Region { item: calendar }

      Rectangle {
        anchors.fill: parent
        anchors.topMargin: 10
        anchors.rightMargin: 10
        color: "transparent"

        Rectangle {
          id: calendar
          implicitWidth: parent.width
          implicitHeight: parent.height
          color: Colors.bg
          y: GlobalState.isCalendarOpen ? 0 : -parent.height * 2

          Behavior on y {
            NumberAnimation {
              duration: 500
              easing.type: Easing.OutQuart
            }
          }

          ColumnLayout {
            id: content
            anchors.left: parent.left
            anchors.right: parent.right

            StyledText {
              id: monthText
              Layout.alignment: Qt.AlignHCenter
              Layout.topMargin: 30
              text: "Jan"
              font.pixelSize: 50

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
              Layout.alignment: Qt.AlignHCenter
              text: "01"
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
              Layout.bottomMargin: 60
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

          Shape {
            anchors.fill: calendar

            ShapePath {
              strokeWidth: 0
              strokeColor: Colors.border
              fillColor: Colors.border

              // Borders.
              PathRectangle { x: 0; y: 0; width: calendar.width; height: 6 }
              PathRectangle { x: 0; y: 6; width: 6; height: calendar.height }
              PathRectangle { x: 6; y: calendar.height - 6; width: calendar.width - 6; height: 6 }
              PathRectangle { x: calendar.width - 6; y: 6; width: 6; height: calendar.height - 6 }

              // Corner Pixels.
              PathRectangle { x: 6; y: 6; width: 6; height: 6 }
              PathRectangle { x: calendar.width - 12; y: 6; width: 6; height: 6 }
              PathRectangle { x: 6; y: calendar.height - 12; width: 6; height: 6 }
              PathRectangle { x: calendar.width - 12; y: calendar.height - 12; width: 6; height: 6 }
            }
          }
        }
      }
    }
  }
}
