import { App, Astal, Gdk, Gtk } from 'astal/gtk4'
import { exec, execAsync, GLib, monitorFile, Variable } from 'astal'

import { ScrolledWindow } from '@widgets';
import { revealWallpapers } from './vars'

const wallpapers = Variable(getWallpapers());

monitorFile(
  `${GLib.get_user_state_dir()}/retro/theme_name`,
  () => wallpapers.set(getWallpapers())
)

function getWallpapers() {
  return exec(`find -L ${GLib.get_user_state_dir()}/retro/wallpapers/previews -iname '*.png'`)
    .split('\n')
    .map(path => ({
      name: path.split('/').pop()!.replace('.png', ''),
      path
    }))
}

function Wallpapers() {
  return (
    <box cssName='wallpapers'>
      <ScrolledWindow
        cssClasses={['list']}
        vscrollbarPolicy={Gtk.PolicyType.NEVER}
        hscrollbarPolicy={Gtk.PolicyType.ALWAYS}
        hexpand={true}
        onScroll={(self, _, dy) => {
          const adjustment = self.get_hadjustment()
          adjustment.set_value(adjustment.get_value() + dy * 50)
        }}>
        <box
          hexpand={true}
          spacing={8}>
          {wallpapers(wallpapers => wallpapers.map(wallpaper => (
            <button
              cursor={Gdk.Cursor.new_from_name('pointer', null)}
              onClicked={() => {
                exec(`ln -sf \
                  ${GLib.get_user_state_dir()}/retro/wallpapers/${wallpaper.name}.png \
                  ${GLib.get_user_state_dir()}/retro/current_wallpaper`
                )

                let randomX = Math.random()
                let randomY = Math.random()

                execAsync(`
                  swww img \
                    ${GLib.get_user_state_dir()}/retro/current_wallpaper \
                    --transition-type "grow" \
                    --transition-pos ${randomX},${randomY} \
                    --transition-duration 2`
                )

                revealWallpapers.set(false)
              }}>
              <box
                cssClasses={['wallpaper_img', wallpaper.name]}
                setup={() => App.apply_css(`.wallpaper_img.${wallpaper.name} { background-image: url("file://${wallpaper.path}"); }`)}
              />
            </button>
          )))}
        </box>
      </ScrolledWindow>
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
