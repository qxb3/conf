import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland

import QtQuick

import "../../common"
import "../calendar"

Scope {
  IpcHandler {
    target: "bar"

    function toggle(): void {
      BarState.toggle(Hyprland.focusedMonitor?.name ?? "DP-1")
    }

    function launcher(): void {
      const name = Hyprland.focusedMonitor?.name ?? "DP-1"
      if (BarState.isOn(name, 1)) BarState.open(0, name)
      else BarState.open(1, name)
    }
  }

  // Top-right notification popups, on DP-1.
  NotificationPopups {
    screen: Quickshell.screens.filter(s => s.name === "DP-1")[0]
  }

  Connections {
    target: BarState

    function onExpandedChanged() {
      if (!BarState.expanded) {
        PowerState.open = false
        TrayMenuState.open = false
        VolumeState.open = false
        CalendarState.open = false
      }
    }
  }

  // A menu survives the first window focus change after it opens (leaving it onto a window beneath),
  // and closes on the second one.
  readonly property bool menuOpen: PowerState.open || TrayMenuState.open || VolumeState.open || CalendarState.open
  property int menuFocusChanges: 0

  onMenuOpenChanged: if (menuOpen) menuFocusChanges = 0

  Connections {
    target: Hyprland

    function onRawEvent(event) {
      if (!menuOpen) return
      if (event.name !== "activewindow" && event.name !== "activewindowv2") return

      menuFocusChanges++
      if (menuFocusChanges >= 2) {
        PowerState.open = false
        TrayMenuState.open = false
        VolumeState.open = false
        CalendarState.open = false
      }
    }
  }

  Variants {
    model: Quickshell.screens

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
      readonly property bool sidebarOpen: BarState.expanded && BarState.activeScreen === modelData.name
      readonly property bool trayShown: TrayMenuState.open && TrayMenuState.screen === modelData.name
      readonly property bool volumeShown: VolumeState.open && VolumeState.screen === modelData.name
      readonly property bool popupShown: PowerState.open || trayShown || volumeShown || calendar.isOpen
      WlrLayershell.keyboardFocus: (sidebarOpen && BarState.tab === 1) ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

      // Only the panel, the sidebar, the open calendar and the open power menu take clicks.
      mask: Region {
        item: panelArea

        Region { item: barArea }
        Region { item: calendarHitbox }
        Region { item: powerHitbox }
        Region { item: powerCatcher }
        Region { item: trayHitbox }
        Region { item: volumeHitbox }
      }

      // Click area for the volume popup, only present while it is shown.
      Item {
        id: volumeHitbox

        x: volumePopup.x
        y: volumePopup.y
        width: volumeShown ? volumePopup.width : 0
        height: volumeShown ? volumePopup.height : 0
      }

      // Full-window catcher, only while the power menu is open. Lowest in stacking, so
      // any real control above it still gets its click; a click on empty space closes the menu.
      Item {
        id: powerCatcher

        width: popupShown ? parent.width : 0
        height: popupShown ? parent.height : 0

        MouseArea {
          anchors.fill: parent
          onPressed: {
            PowerState.open = false
            TrayMenuState.open = false
            VolumeState.open = false
            CalendarState.open = false
          }
        }
      }

      // Hidden panel to the left of the bar. Its width pushes the bar to the right.
      Item {
        id: panelArea

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: sidebarOpen ? 500 : 0
        clip: true

        Behavior on width {
          NumberAnimation { duration: 200; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.2, 0.8, 0.3, 1, 1, 1] }
        }

        Rectangle {
          width: 500
          height: parent.height
          x: sidebarOpen ? 0 : -500
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

          Panel { screenName: modelData.name }
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

        Top { screenName: modelData.name }
        Workspaces { screen: modelData }
        Bottom { screenName: modelData.name }
      }

      Calendar {
        screenName: modelData.name
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

        visible: PowerState.open || opacity > 0
      }

      // Click area for the power menu, only present while it is shown.
      Item {
        id: powerHitbox

        x: powerMenu.x
        y: powerMenu.y
        width: PowerState.open ? powerMenu.width : 0
        height: PowerState.open ? powerMenu.height : 0
      }

      // Tray app menu, opened by right-clicking a tray icon.
      TrayMenu {
        screenName: modelData.name
        id: trayMenu

        visible: trayShown || opacity > 0
      }

      // Click area for the tray menu, only present while it is shown.
      Item {
        id: trayHitbox

        x: trayMenu.x
        y: trayMenu.y
        width: trayShown ? trayMenu.width : 0
        height: trayShown ? trayMenu.height : 0
      }

      // Volume popup, slim vertical slider beside the bar, opened by the headphones button.
      VolumePopup {
        screenName: modelData.name
        id: volumePopup

        anchors.left: barArea.right
        anchors.leftMargin: 8
      }

    }
  }
}
