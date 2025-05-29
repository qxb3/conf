pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Controls

import "root:/common"

Singleton {
  property QtObject notifServer
  property ListModel list: ListModel {}
  property ListModel popups: ListModel {}

  function removeNotif(id) {
    for (let i = 0; i < list.count; i++) {
      if (list.get(i).id == id) {
        list.remove(i)
      }
    }
  }

  function removePopup(id) {
    for (let i = 0; i < popups.count; i++) {
      if (popups.get(i).id == id) {
        popups.remove(i)
      }
    }
  }

  NotificationServer {
    id: notifServer
    onNotification: (notification) => {
      GlobalState.isNotifCenterOpen = false
      notification.tracked = true

      popups.insert(0, {
        id: notification.id,
        appName: notification.appName,
        summary: notification.summary,
        body: notification.body
      })

      list.insert(0, {
        id: notification.id,
        appName: notification.appName,
        summary: notification.summary,
        body: notification.body
      })

      console.log(`[Notification] ${notification.appName}`)
    }

    Component.onCompleted: {
      console.log("[Notification] Started")
    }
  }
}
