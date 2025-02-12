import Hyprland from 'gi://AstalHyprland'

import { Astal, Gdk, Gtk } from 'astal/gtk4'
import { bind, exec, Variable } from 'astal'

const hyprland = Hyprland.get_default()

const time = Variable(exec(`date +"%b %d, %Y - %I : %M %p"`))
                .poll(1000, `date +"%b %d, %Y - %I : %M %p"`)

function Bar() {
  return (
    <centerbox cssName='bar'>
      <box
        cssClasses={['top']}
        valign={Gtk.Align.START}
        spacing={8}>
        <box cssClasses={['workspaces']}>
          {Array.from({ length: 5 }).map((_, i) => (
            <button
              cssClasses={
                bind(hyprland, 'focusedWorkspace')
                  .as(focusedWorkspace => (
                    focusedWorkspace.get_id() === (i + 1)
                      ? ['workspace', 'active']
                      : ['workspace']
                  ))
              }
              cursor={Gdk.Cursor.new_from_name('pointer', null)}
              onClicked={() => hyprland.message_async(`dispatch workspace ${i + 1}`)}>
              {i + 1}
            </button>
          ))}
        </box>

        <label
          cssClasses={['active_window']}
          label={
            bind(hyprland, 'focusedClient')
              .as(focusedClient => focusedClient.get_initial_title())
              .as(title => `* ${title}`)
          }
        />
      </box>

      <box
        cssClasses={['center']}
        valign={Gtk.Align.CENTER}>
      </box>

      <box
        cssClasses={['bottom']}
        valign={Gtk.Align.END}>
        <label
          cssClasses={['time']}
          label={time()}
        />
      </box>
    </centerbox>
  )
}

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <window
      namespace='astal_window'
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT}
      visible={true}>
      <Bar />
    </window>
  )
}
