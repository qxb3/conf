import Hyprland from 'gi://AstalHyprland'
import { Astal, Gdk, Gtk } from 'astal/gtk3'

const hyprland = Hyprland.get_default()

function SideBar() {
  return (
    <box
      className='side_bar'
      vertical={true}
      spacing={10}
      halign={Gtk.Align.CENTER}>
      {['one', 'two', 'three', 'four', 'five'].map((n, i) => (
        <button
          cursor='pointer'
          onClick={() => hyprland.message(`dispatch workspace ${i + 1}`)}>
          <label label={n.split('').join('\n').toUpperCase()} />
        </button>
      ))}
    </box>
  )
}

export default function(m: Gdk.Monitor) {
  return (
    <window
      namespace='astal_window'
      gdkmonitor={m}
      layer={Astal.Layer.TOP}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.BOTTOM}>
      <SideBar />
    </window>
  )
}
