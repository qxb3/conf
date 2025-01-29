import { Astal, Gdk } from 'astal/gtk4'

export default function(gdkmonitor: Gdk.Monitor, anchor: Astal.WindowAnchor) {
  return (
    <window
      namespace='astal_window_border'
      gdkmonitor={gdkmonitor}
      layer={Astal.Layer.TOP}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={anchor}
      visible={true}>
      <box cssName='window_border' />
    </window>
  )
}
