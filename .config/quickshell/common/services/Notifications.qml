pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Controls

import "root:/common"

Singleton {
  id: root

  property QtObject notifServer
  property ListModel list: ListModel {}
  property ListModel popups: ListModel {}

  function removeNotif(id) {
    for (let i = 0; i < root.list.count; i++) {
      let notif = root.list.get(i)
      if (notif.id == id) {
        root.list.remove(i)
      }
    }
  }

  function removePopup(id) {
    for (let i = 0; i < root.popups.count; i++) {
      let popup = root.popups.get(i)

      if (popup.id == id) {
        root.list.insert(0, {
          id: popup.id,
          appName: popup.appName,
          summary: popup.summary,
          body: popup.body
        })

        root.popups.remove(i)
      }
    }
  }

  Component {
    id: popupTimer

    Timer {
      required property int id

      interval: 5000
      running: true
      onTriggered: {
        removePopup(id)
        destroy()
      }
    }
  }

  NotificationServer {
    id: notifServer
    onNotification: (notification) => {
      GlobalState.isNotifCenterOpen = false
      // notification.tracked = true

      root.popups.insert(0, {
        id: notification.id,
        appName: notification.appName,
        summary: notification.summary,
        body: notification.body
      })

      popupTimer.createObject(root, {
        id: notification.id
      })

      console.log(`[Notification] ${notification.appName}`)
    }

    Component.onCompleted: {
      console.log("[Notification] Started")
    }
  }
}
