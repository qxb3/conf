import { Astal, Gdk } from 'astal/gtk4'

function AppLauncherWin() {
  return (
    <box>
      <label label='hello' />
    </box>
  )
}

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <window
      name='app_launcher'
      namespace='astal_app_launcher'
      gdkmonitor={gdkmonitor}
      layer={Astal.Layer.TOP}
      exclusivity={Astal.Exclusivity.NORMAL}
      anchor={Astal.WindowAnchor.TOP}>
      <AppLauncherWin />
    </window>
  )
}
