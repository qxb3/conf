import { Astal, Gdk, Gtk } from 'astal/gtk4'

import { revealPower } from './vars'
import { execAsync } from 'astal'

const powers = [
  { name: '/ Shutdown //',  fn: () => execAsync(`systemctl poweroff`) },
  { name: '/// Restart /',  fn: () => execAsync(`systemctl reboot`) },
  { name: '/ Sleep',        fn: () => execAsync(`systemctl suspend`) },
  { name: '/ Lock ///',     fn: () => execAsync(`hyprlock`) },
  { name: '// Logout //',   fn: () => execAsync(`hyprctl dispatch exit`) },
]

function Power() {
  return (
    <box
      cssName='power'
      spacing={8}
      vertical={true}>
      {powers.map(({ name, fn }) => (
        <button
          cssClasses={['power']}
          cursor={Gdk.Cursor.new_from_name('pointer', null)}
          hexpand={true}
          onClicked={fn}>
          <label
            label={name}
            xalign={0}
          />
        </button>
      ))}
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
        revealChild={revealPower()}
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
        transitionDuration={200}>
        <Power />
      </revealer>
    </window>
  )
}
