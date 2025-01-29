import Hyprland from 'gi://AstalHyprland'
import { Astal, Gdk, Gtk, hook } from 'astal/gtk4'
import { bind } from 'astal'

const hyprland = Hyprland.get_default()

function Workspaces() {
  return (
    <box
      cssClasses={['workspaces']}>
      {['one', 'two', 'three', 'four', 'five'].map((name, i) =>
        <button
          cssClasses={
            bind(hyprland, 'focused_workspace')
            .as(focusedWorkspace =>
              focusedWorkspace.get_id() === i + 1
                ? ['workspace', 'active']
                : ['workspace']
            )
          }
          cursor={Gdk.Cursor.new_from_name('pointer', null)}
          halign={Gtk.Align.CENTER}
          onClicked={() => hyprland.message(`dispatch workspace ${i + 1}`)}
          setup={(self) => {
            hook(self, hyprland, 'event', () => {
            })
          }}>
          <label
            label={name}
          />
        </button>
      )}
    </box>
  )
}

function Bottom() {
  return (
    <box
      cssName='bottom'>
      <Workspaces />
    </box>
  )
}

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <window
      namespace='astal_window_bottom'
      gdkmonitor={gdkmonitor}
      layer={Astal.Layer.TOP}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.BOTTOM}
      visible={true}>
      <Bottom />
    </window>
  )
}
