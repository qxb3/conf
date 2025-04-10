import { Astal, Gdk, Gtk } from 'astal/gtk3'

function BottomSide() {
  return (
    <box
      className='bottom_side'
      vertical={true}
      spacing={16}>
      <label
        halign={Gtk.Align.END}
        label={'white'.split('').join('\n').toUpperCase()}
      />

      <box
        halign={Gtk.Align.END}
        valign={Gtk.Align.END}
        spacing={16}>
        <label
          className='black'
          label={'black'.toUpperCase()}
          valign={Gtk.Align.END}
        />

        <label
          label='&'
          valign={Gtk.Align.END}
        />
      </box>
    </box>
  )
}

export default function(m: Gdk.Monitor) {
  return (
    <window
      namespace='astal_window'
      gdkmonitor={m}
      layer={Astal.Layer.BACKGROUND}
      exclusivity={Astal.Exclusivity.IGNORE}
      anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}>
      <BottomSide />
    </window>
  )
}
