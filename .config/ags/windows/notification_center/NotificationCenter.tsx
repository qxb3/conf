import Notifyd from 'gi://AstalNotifd'

import { Astal, Gdk, Gtk } from 'astal/gtk3'
import { timeout, Variable } from 'astal'

import { FloatingWindow } from '@widgets'
import { revealNotificationCenter } from './vars'

const notifyd = Notifyd.get_default()

function Notification(props: {
  notification: Notifyd.Notification,
  reveal: boolean
}) {
  const {
    notification,
    reveal = false
  } = props

  const downRevealer = Variable(true)
  const sideRevealer = Variable(reveal)

  return (
    <box
      hexpand={true}
      vertical={true}
      halign={Gtk.Align.END}>
      <revealer
        revealChild={downRevealer()}
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
        transitionDuration={USER_SETTINGS.animationSpeed}
        onDestroy={() => downRevealer.drop()}>
        <box hexpand={true}>
          <revealer
            revealChild={sideRevealer()}
            transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
            transitionDuration={USER_SETTINGS.animationSpeed}
            setup={() => {
              timeout(1, () => {
                sideRevealer.set(true)
              })
            }}
            onDestroy={() => sideRevealer.drop()}>
            <box
              className='notification'
              vertical={true}
              spacing={8}
              hexpand={true}>
              <label
                className='app_name'
                label={notification.get_app_name()}
                maxWidthChars={8}
                lines={3}
                xalign={0}
              />

              <box
                vertical={true}
                spacing={4}>
                <label
                  className='summary'
                  label={notification.get_summary()}
                  maxWidthChars={8}
                  truncate={true}
                  xalign={0}
                />

                <label
                  className='body'
                  label={notification.get_body()}
                  maxWidthChars={8}
                  truncate={true}
                  xalign={0}
                />
              </box>
            </box>
          </revealer>
        </box>
      </revealer>
    </box>
  )
}

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
            .map(n => n.dismiss())
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

          self.pack_end(notificationWidget, false, false, 0)
        }

        function onRemove(id: number) {
          if (notifications.has(id))
            return

          // notifications.get(id)!.remove()
          notifications.delete(id)
        }

        notifyd.get_notifications().map(notification => onAdded(notification.get_id()))
        self.hook(notifyd, 'notified', (_, id) => onAdded(id))
      }}>
    </box>
  )
}

function NotificationCenter() {
  return (
    <box
      className='content'
      vertical={true}
      spacing={8}>
      <Header />
      <NotificationList />
    </box>
  )
}

export default function(gdkmonitor: Gdk.Monitor) {
  <FloatingWindow
    className='notification_center'
    title='Notifications'
    gdkmonitor={gdkmonitor}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
    revealer={revealNotificationCenter}
    transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}>
    <NotificationCenter />
  </FloatingWindow>
}
