import { Astal, Gdk, Gtk } from 'astal/gtk3'

import { Calendar, FloatingWindow } from '@widgets'
import { revealCalendar } from './vars'

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <FloatingWindow
      className='calendar'
      title='Calendar'
      gdkmonitor={gdkmonitor}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
      revealer={revealCalendar}
      transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}>
      <Calendar />
    </FloatingWindow>
  )
}
