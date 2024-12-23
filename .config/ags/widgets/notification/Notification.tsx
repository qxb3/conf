import Notifyd from 'gi://AstalNotifd'
import Pango from 'gi://Pango'

import { Gtk } from 'astal/gtk3'
import { GLib, timeout, Variable } from 'astal'

const notifyd = Notifyd.get_default()

function NotifHeader(props: { notification: Notifyd.Notification }) {
  const { notification } = props

  return (
    <box
      className='notif_header'
      valign={Gtk.Align.CENTER}
      spacing={8}>
      <label
        className='app_name'
        label={notification.get_app_name()}
        maxWidthChars={12}
        truncate={true}
        xalign={0}
        yalign={1}
      />

      <label
        className='time'
        label={
          GLib.DateTime
          .new_from_unix_local(notification.get_time())
          .format('• %I:%M %p')!
        }
        xalign={0}
        yalign={1}
      />

      <button
        className='close'
        cursor='pointer'
        halign={Gtk.Align.END}
        valign={Gtk.Align.CENTER}
        hexpand={true}
        onClick={() => {
          notification.dismiss()
        }}>
        <icon
          className='icon'
          icon='window-close-symbolic'
        />
      </button>
    </box>
  )
}

function NotifContent(props: { notification: Notifyd.Notification }) {
  const { notification } = props

  return (
    <box className='content'>
      <box
        vertical={true}
        spacing={4}>
        <label
          className='summary'
          label={notification.get_summary()}
          maxWidthChars={16}
          truncate={true}
          xalign={0}
        />

        <label
          className='body'
          label={
            notification.get_body()
            .replace(/(\r\n|\n|\r)/gm, ' ')
          }
          maxWidthChars={32}
          wrapMode={Pango.WrapMode.WORD_CHAR}
          wrap={true}
          truncate={true}
          lines={3}
          xalign={0}
        />
      </box>
    </box>
  )
}

function NotifActions(props: { notification: Notifyd.Notification }) {
  const { notification } = props

  return (
    <box
      className='actions'
      vertical={true}
      spacing={8}>
      <Gtk.Separator visible />

      <box spacing={4}>
        {notification.get_actions().map(action => (
          <button
            className='action'
            cursor='pointer'
            hexpand={true}
            onClick={() => {
              notification.invoke(action.id)
            }}>
            <label
              className='name'
              label={action.label}
              halign={Gtk.Align.CENTER}
              hexpand={true}
            />
          </button>
        ))}
      </box>
    </box>
  )
}

function NotificationWidget(props: { notification: Notifyd.Notification }) {
  const { notification } = props

  return (
    <box
      className='widget_notification'
      vertical={true}
      spacing={8}>
      <NotifHeader notification={notification} />
      <Gtk.Separator visible />
      <NotifContent notification={notification} />
      {notification.get_actions().length > 0 && <NotifActions notification={notification} />}
    </box>
  )
}

export default function Notification(props: {
  notification: Notifyd.Notification,
  reveal: boolean
}) {
  const {
    notification,
    reveal = false
  } = props

  const downRevealer = Variable(reveal)
  const sideRevealer = Variable(reveal)

  const notificationWidget = (
    <box vertical={true}>
      <revealer
        revealChild={downRevealer()}
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
        transitionDuration={USER_SETTINGS.animationSpeed}
        onDestroy={() => downRevealer.drop()}
        onRealize={() => {
          timeout(1, () => {
            downRevealer.set(true);
          })
        }}>
        <box halign={Gtk.Align.END}>
          <revealer
            revealChild={sideRevealer()}
            transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
            transitionDuration={USER_SETTINGS.animationSpeed}
            onRealize={() => {
              timeout(USER_SETTINGS.animationSpeed, () => {
                sideRevealer.set(true)
              })
            }}
            onDestroy={() => sideRevealer.drop()}>
            <NotificationWidget notification={notification} />
          </revealer>
        </box>
      </revealer>
    </box>
  )

  const resolvedHandler = notifyd.connect('resolved', (_, id) => {
    if(id == notification.id) {
      notifyd.disconnect(resolvedHandler)
      sideRevealer.set(false)

      timeout(USER_SETTINGS.animationSpeed, () => {
        downRevealer.set(false)
        timeout(USER_SETTINGS.animationSpeed, () => {
          notificationWidget.destroy()
        })
      })
    }
  })

  return notificationWidget
}
