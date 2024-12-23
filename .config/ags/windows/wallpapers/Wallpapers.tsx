import { Astal, Gdk, Gtk } from 'astal/gtk3'
import { exec, execAsync } from 'astal'

import { FloatingWindow, FlowBox } from '@widgets'
import { revealWallpapers } from './vars'

function getWallpapers() {
  return exec(`find -L ${HOME_DIR}/.config/swww -iname '*.png'`)
    .split('\n')
}

function Wallpapers() {
  const wallpapers = getWallpapers()

  return (
    <scrollable
      hexpand={true}
      vexpand={true}>
      <FlowBox
        className='content'
        maxChildrenPerLine={2}
        column_spacing={8}
        rowSpacing={8}>
        {wallpapers.map(wallpaper => (
          <button
            cursor='pointer'
            halign={Gtk.Align.CENTER}
            onClick={() => {
              execAsync(`swww img ${wallpaper}`)
              revealWallpapers.set(false)
            }}>
            <box
              className='wallpaper'
              css={`background-image: url("${wallpaper}");`}
            />
          </button>
        ))}
      </FlowBox>
    </scrollable>
  )
}

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <FloatingWindow
      className='wallpapers'
      title='Wallpapers'
      gdkmonitor={gdkmonitor}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT}
      revealer={revealWallpapers}
      transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}>
      <Wallpapers />
    </FloatingWindow>
  )
}
