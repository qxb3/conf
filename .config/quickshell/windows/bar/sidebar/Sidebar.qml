import Quickshell.Io

import QtQuick
import QtQuick.Controls

import "root:/common"
import "root:/common/widgets"

Item {
  implicitWidth: States.sidebar.isOpen ? 400 : 0
  implicitHeight: parent.height
  clip: true

  Behavior on implicitWidth {
    NumberAnimation {
      duration: Settings.animation.speed
      easing.type: Settings.animation.easing
    }
  }

  Rectangle {
    anchors.fill: parent
    color: Settings.colors.bg

    Rectangle {
      anchors.top: parent.top
      anchors.bottom: parent.bottom
      anchors.right: parent.right
      implicitWidth: 1
      color: Settings.colors.bgSofter
    }

    StackView {
      id: stackPage
      anchors.fill: parent
      initialItem: home

      replaceEnter: Transition {
        NumberAnimation {
          properties: "x"
          duration: Settings.animation.speed
          easing.type: Settings.animation.easing
          from: stackPage.width
          to: 0
        }
      }

      replaceExit: Transition {
        NumberAnimation {
          properties: "x"
          duration: Settings.animation.speed
          easing.type: Settings.animation.easing
          from: 0
          to: -stackPage.width
        }
      }

      // Replace the stackview and sets the sidebar.currentPage.
      function replacePage(page: string): void {
        States.sidebar.currentPage = page
        switch (page) {
          case "home":
            stackPage.replace(home)
            break
          case "appLauncher":
            stackPage.replace(appLauncher)
            break
          case "wallpapers":
            stackPage.replace(wallpapers)
            break
          case "themes":
            stackPage.replace(themes)
            break
        }
      }
    }

    Component { id: home; Home {} }
    Component { id: appLauncher; AppLauncher {} }
    Component { id: wallpapers; Wallpapers {} }
    Component { id: themes; Themes {} }
  }

  IpcHandler {
    target: "sidebar"

    // Opens the sidebar.
    function open(page: string): void {
      States.sidebar.isOpen = true
      stackPage.replacePage(page)
    }

    // Closes the sidebar.
    function close(): void {
      States.sidebar.isOpen = false
      States.sidebar.page = "home"
    }

    // Toggles the sidebar.
    function toggle(page: string): void {
      // Toggle sidebar normally if the page is "home".
      if (page == "home") {
        States.sidebar.isOpen = !States.sidebar.isOpen
        stackPage.replacePage("home")
        return
      }

      // If the page is not "home" open the sidebar if its not open.
      // This way its just gonna toggle the pages but not close the sidebar.
      if (!States.sidebar.isOpen) {
        States.sidebar.isOpen = true
      }

      // Replace pages.
      if (page != States.sidebar.currentPage) {
        stackPage.replacePage(page)
      } else {
        stackPage.replacePage("home")
      }
    }
  }
}
