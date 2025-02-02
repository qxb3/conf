import { App, Astal, Gdk, Gtk } from 'astal/gtk4'
import { exec, GLib, monitorFile, Variable } from 'astal'

import { revealWallpapers } from './vars'

const wallpapers = Variable(getWallpapers());

monitorFile(
  `${GLib.get_user_state_dir()}/retro/theme_changed`,
  () => wallpapers.set(getWallpapers())
)

function getWallpapers() {
  return exec(`find -L ${GLib.get_user_state_dir()}/retro/wallpapers -iname '*.png'`)
    .split('\n')
}

function Wallpapers() {
  return (
    <box cssName='wallpapers'>
      <Gtk.ScrolledWindow
        cssClasses={['list']}
        vscrollbarPolicy={Gtk.PolicyType.NEVER}
        hscrollbarPolicy={Gtk.PolicyType.ALWAYS}
        hexpand={true}>
        <box
          hexpand={true}
          spacing={8}>
          {wallpapers(wallpapers => wallpapers.map(wallpaper => (
            <button
              cursor={Gdk.Cursor.new_from_name('pointer', null)}
              onClicked={() => {}}>
              <box
                cssClasses={['wallpaper_img']}
                setup={() => App.apply_css(`.wallpaper_img { background-image: url("file://${wallpaper}"); }`)}
              />
            </button>
          )))}
        </box>
      </Gtk.ScrolledWindow>
    </box>
  )
}

export default function(monitor: Gdk.Monitor) {
  return (
    <window
      namespace='astal_window'
      gdkmonitor={monitor}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.TOP}
      exclusivity={Astal.Exclusivity.NORMAL}
      defaultWidth={1}
      defaultHeight={1}
      visible={true}>
      <revealer
        revealChild={revealWallpapers()}
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
        transitionDuration={200}>
        <Wallpapers />
      </revealer>
    </window>
  )
}
