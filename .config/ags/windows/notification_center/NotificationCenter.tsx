import Notifyd from 'gi://AstalNotifd'

import { Astal, Gdk, Gtk } from 'astal/gtk3'
import { timeout, Variable } from 'astal'

import { FloatingWindow, Notification } from '@widgets'
import { revealNotificationCenter } from './vars'

const notifyd = Notifyd.get_default()

  const notificationSize = Variable(0)

function Header() {
  return (
    <box className='header'>
      <box spacing={8}>
        <icon
          className='icon'
          icon='custom-bell-symbolic'
        />

        <label
          className='title'
          label='Notifications'
        />
      </box>

      <box hexpand />

      <button
        className='clear'
        cursor='pointer'
        onClick={() => {
          notifyd.get_notifications()
            .map((n, i) => {
              timeout((USER_SETTINGS.animationSpeed * i) / 3, () => {
                n.dismiss()
              })
            })
        }}>
        <icon
          className='icon'
          icon='edit-clear-symbolic'
        />
      </button>
    </box>
  )
}

function NotificationList() {
  return (
    <scrollable vexpand={true}>
      <box
        className='notifications'
        spacing={16}
        vertical={true}
        hexpand={true}
        setup={(self) => {
          const notifications = new Map<number, Gtk.Widget>()

          function onAdded(id: number) {
            const notification = notifyd.get_notification(id)
            if (!notification)
              return

            const replace = notifications.get(id)
            if (replace)
              replace.destroy()

            const notificationWidget = Notification({ notification, reveal: !!replace })
            notifications.set(id, notificationWidget)
            notificationSize.set(notifications.size)

            self.pack_start(notificationWidget, false, false, 0)
          }

          function onRemove(id: number) {
            if (!notifications.has(id))
              return

            notifications.delete(id)
            notificationSize.set(notifications.size)
          }

          self.hook(notifyd, 'notified', (_, id) => onAdded(id))
          self.hook(notifyd, 'resolved', (_, id) => onRemove(id))

          notifyd
            .get_notifications()
            .map((notification, i) => {
              timeout((USER_SETTINGS.animationSpeed * i) / 3, () => {
                onAdded(notification.get_id())
              })
            })
        }}
      />
    </scrollable>
  )
}

function NoNotification() {
  return (
    <box
      className='no_notification'
      visible={
        notificationSize()
          .as(size => size <= 0)
      }
      valign={Gtk.Align.CENTER}
      hexpand={true}
      vexpand={true}
      vertical={true}
      spacing={12}>
      <icon
        className='icon'
        icon='custom-slash-bell-symbolic'
      />

      <label
        className='title'
        label='No Notification'
        hexpand={true}
      />
    </box>
  )
}

function NotificationCenter() {
  return (
    <box
      className='content'
      vertical={true}>
      <Header />
      <Gtk.Separator visible />

      <NoNotification />
      <NotificationList />
    </box>
  )
}

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <FloatingWindow
      className='notification_center'
      title='Notifications'
      gdkmonitor={gdkmonitor}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
      revealer={revealNotificationCenter}
      transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}>
      <NotificationCenter />
    </FloatingWindow>
  )
}
