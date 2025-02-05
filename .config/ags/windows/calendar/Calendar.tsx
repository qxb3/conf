import { Astal, Gdk, Gtk } from 'astal/gtk4'

import { Calendar } from '@widgets'
import { revealCalendar } from './vars'

function CalendarWin() {
  return (
    <box
      cssName='calendar'
      hexpand={true}>
      <Calendar />
    </box>
  )
}

export default function(monitor: Gdk.Monitor) {
  return (
    <window
      namespace='astal_window'
      gdkmonitor={monitor}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
      exclusivity={Astal.Exclusivity.NORMAL}
      defaultWidth={1}
      defaultHeight={1}
      visible={true}>
      <revealer
        revealChild={revealCalendar()}
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
        transitionDuration={200}>
        <CalendarWin />
      </revealer>
    </window>
  )
}

