import Notifyd from 'gi://AstalNotifd'
import { Astal, Gdk, Gtk } from 'astal/gtk3'

import { Notification } from '@widgets'
import { revealNotificationCenter } from '@windows/notification_center/vars'
import { revealCalendar } from '@windows/calendar/vars'

const notifyd = Notifyd.get_default()

function NotifPopupList() {
  const popups = new Map<number, Gtk.Widget>()

  return (
    <box
      className='popups'
      vertical={true}
      vexpand={true}
      spacing={4}
      setup={(self) => {
        function onNotify(id: number) {
          const notification = notifyd.get_notification(id)
          if (!notification || notifyd.get_dont_disturb())
            return

          const notificationWidget = Notification({
            notification,
            popup: true,
            onClick: (remove) => onRemove(id, remove),
            onHoverLost: (remove) => onRemove(id, remove),
            onPopupTimeoutDone: (remove) => onRemove(id, remove)
          })

          revealNotificationCenter.set(false)
          revealCalendar.set(false)

          popups.set(id, notificationWidget)
          self.pack_start(notificationWidget, false, false, 0)
        }

        function onRemove(id: number, remove: () => void) {
          if (!popups.has(id))
            return

          popups.delete(id)
          remove()
        }

        self.hook(notifyd, 'notified', (_, id) => onNotify(id))
      }}>
    </box>
  )
}

function NotificationPopups() {
  return (
    <box className='notification_popups'>
      <NotifPopupList />
    </box>
  )
}

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <window
      namespace='astal_window_notification_popups'
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.NORMAL}
      layer={Astal.Layer.OVERLAY}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}>
      <NotificationPopups />
    </window>
  )
}
