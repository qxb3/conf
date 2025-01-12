import { Astal, Gdk } from 'astal/gtk4'

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <window
      name='app_launcher'
      namespace='astal_app_launcher'
      gdkmonitor={gdkmonitor}
      layer={Astal.Layer.TOP}
      exclusivity={Astal.Exclusivity.NORMAL}>
      <label label='Hi' />
    </window>
  )
}
