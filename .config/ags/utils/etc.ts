import Notifyd from 'gi://AstalNotifd'

import { Astal } from 'astal/gtk3'
import { GLib } from 'astal'

export function isIcon(icon: string) {
  !!Astal.Icon.lookup_icon(icon)
}

export function fileExists(path: string) {
  GLib.file_test(path, GLib.FileTest.EXISTS)
}

export function notifUrgency(notification: Notifyd.Notification) {
  const { CRITICAL, NORMAL, LOW } = Notifyd.Urgency

  switch (notification.get_urgency()) {
    case CRITICAL: return 'critical'
    case NORMAL: return 'normal'
    case LOW:
    default:
      return 'low'
  }
}
