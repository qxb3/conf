import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import QtQuick

import "../../common"
import "../calendar"

Scope {
  IpcHandler {
    target: "bar"

    function toggle(): void {
      BarState.expanded = !BarState.expanded
    }

    function launcher(): void {
      if (BarState.expanded && BarState.tab === 1) BarState.open(0)
      else BarState.open(1)
    }
  }

  // Top-right notification popups, on DP-1.
  NotificationPopups {
    screen: Quickshell.screens.filter(s => s.name === "DP-1")[0]
  }

  Connections {
    target: BarState

    function onExpandedChanged() {
      if (!BarState.expanded) PowerState.open = false
    }
  }

  Variants {
    model: Quickshell.screens.filter(s => s.name === "DP-1")

    PanelWindow {
      required property ShellScreen modelData
      screen: modelData

      anchors.top: true
      anchors.left: true
      anchors.bottom: true

      margins.top: 0
      margins.left: 0
      margins.bottom: 0

      implicitWidth: 500 + 56 + 8 + 272
      exclusiveZone: barArea.width
      color: "transparent"
      WlrLayershell.keyboardFocus: (BarState.expanded && BarState.tab === 1) ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

      // Only the panel, the sidebar, the open calendar and the open power menu take clicks.
      mask: Region {
        item: panelArea

        Region { item: barArea }
        Region { item: calendarHitbox }
        Region { item: powerHitbox }
        Region { item: powerCatcher }
      }

      // Full-window catcher, only while the power menu is open. Lowest in stacking, so
      // any real control above it still gets its click; a click on empty space closes the menu.
      Item {
        id: powerCatcher

        width: PowerState.open ? parent.width : 0
        height: PowerState.open ? parent.height : 0

        MouseArea {
          anchors.fill: parent
          onPressed: PowerState.open = false
        }
      }

      // Hidden panel to the left of the bar. Its width pushes the bar to the right.
      Item {
        id: panelArea

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: BarState.expanded ? 500 : 0
        clip: true

        Behavior on width {
          NumberAnimation { duration: 200; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.2, 0.8, 0.3, 1, 1, 1] }
        }

        Rectangle {
          width: 500
          height: parent.height
          x: BarState.expanded ? 0 : -500
          color: Colors.bg

          Behavior on x {
            NumberAnimation { duration: 200; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.2, 0.8, 0.3, 1, 1, 1] }
          }

          Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: 1
            color: Colors.border
          }

          Panel {}
        }
      }

      Item {
        id: barArea

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: panelArea.right
        width: 56

        Rectangle {
          anchors.fill: parent
          color: Colors.bg

          Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: 1
            color: Colors.border
          }
        }

        Top {}
        Workspaces { screen: modelData }
        Bottom {}
      }

      Calendar {
        id: calendar

        anchors.left: barArea.right
        anchors.leftMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
      }

      // Click area for the calendar, only present while it is shown.
      Item {
        id: calendarHitbox

        anchors.left: barArea.right
        anchors.leftMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        width: calendar.visible ? calendar.width : 0
        height: calendar.visible ? calendar.height : 0
      }

      // Power menu, floating under the power button.
      PowerMenu {
        id: powerMenu

        visible: PowerState.open
      }

      // Click area for the power menu, only present while it is shown.
      Item {
        id: powerHitbox

        x: powerMenu.x
        y: powerMenu.y
        width: PowerState.open ? powerMenu.width : 0
        height: PowerState.open ? powerMenu.height : 0
      }
    }
  }
}
