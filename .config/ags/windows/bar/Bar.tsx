import Hyprland from 'gi://AstalHyprland'
import ThemeManager, { Themes } from '@services/ThemeManager'

import { Astal, Gdk, Gtk, hook } from 'astal/gtk4'
import { bind, Variable } from 'astal'

import { revealDesktop } from '../desktop/vars'
import { revealApplauncher } from '../launcher/vars'
import { revealMusic } from '../music/vars'
import { revealPower } from '../power/vars'
import { revealWallpapers } from '@windows/wallpapers/vars'
import { revealThemes } from '@windows/themes/vars'
import { revealCalendar } from '@windows/calendar/vars'

const hyprland = Hyprland.get_default()
const themeManager = ThemeManager.get_default()

const time = Variable('').poll(1000, `date +'%I/%M/%p'`)

const workspaces = [
  { name: 'one /',        action: 'app launcher', fn: () => revealApplauncher.set(!revealApplauncher.get()) },
  { name: 'two //',       action: 'music player', fn: () => revealMusic.set(!revealMusic.get()) },
  { name: '/ three //',   action: 'wallpapers',   fn: () => revealWallpapers.set(!revealWallpapers.get()) },
  { name: '/// four /',   action: 'themes',       fn: () => revealThemes.set(!revealThemes.get()) },
  { name: '/// five //',  action: 'none',         fn: () => {} }
]

function Workspaces() {
  return (
    <box
      name='workspaces'
      cssClasses={['workspaces']}
      spacing={8}>
      {workspaces.map(({ name, action, fn }, i) => {
        const revealAction = Variable(false)

        return (
          <button
            cssClasses={
              bind(hyprland, 'focusedWorkspace')
              .as(focusedWorkspace => (
                focusedWorkspace.get_id() === i + 1
                  ? ['workspace', 'active']
                  : ['workspace']
              ))
            }
            cursor={Gdk.Cursor.new_from_name('pointer', null)}
            onButtonPressed={(_, event) => {
              switch (event.get_button()) {
                case 1:
                  hyprland.message(`dispatch workspace ${i + 1}`)
                  break
                case 2:
                  revealAction.set(!revealAction.get())
                  break
                case 3:
                  fn()
              }
            }}>
            <label
              cssClasses={['name']}
              label={
                revealAction(reveal =>
                  reveal ? `${name} (${action})` : `${name}`
                )
              }
            />
          </button>
        )
      })}
    </box>
  )
}

function Left() {
  return (
    <box
      cssClasses={['left']}
      spacing={8}>
      <button
        cursor={Gdk.Cursor.new_from_name('pointer', null)}
        onClicked={() => revealDesktop.set(!revealDesktop.get())}>
        <box spacing={8}>
          <image
            cssClasses={['logo']}
            pixelSize={24}
            setup={(self) => {
              const applyArch = (theme: Themes) => {
                self.file = `${SRC}/assets/arch/${themeManager.toString(theme)}.svg`
              }

              applyArch(themeManager.currentTheme)
              hook(self, themeManager, 'changed', () => {
                applyArch(themeManager.currentTheme)
              })
            }}
          />

          <label
            cssClasses={['title']}
            label='/ Hyprland //'
          />
        </box>
      </button>
    </box>
  )
}

function Center() {
  return (
    <box cssClasses={['center']}>
      <stack
        visibleChildName={
          bind(Variable.derive([
            bind(revealApplauncher),
            bind(revealMusic),
            bind(revealWallpapers),
            bind(revealThemes)
          ], (revealApplauncher, revealMusic, revealWallpapers, revealThemes) => {
            if (revealApplauncher) return 'launcher'
            if (revealMusic) return 'music'
            if (revealWallpapers) return 'wallpapers'
            if (revealThemes) return 'themes'

            return 'workspaces'
          }))
        }>
        <Workspaces />

        <button
          name='launcher'
          cssClasses={['bar_mode']}
          cursor={Gdk.Cursor.new_from_name('pointer', null)}
          label='// App Launcher ///'
          halign={Gtk.Align.CENTER}
          onClicked={() => revealApplauncher.set(false)}
        />

        <button
          name='wallpapers'
          cssClasses={['bar_mode']}
          cursor={Gdk.Cursor.new_from_name('pointer', null)}
          label='/ Wallpapers //'
          halign={Gtk.Align.CENTER}
          onClicked={() => revealWallpapers.set(false)}
        />

        <button
          name='music'
          cssClasses={['bar_mode']}
          cursor={Gdk.Cursor.new_from_name('pointer', null)}
          label='Music Player /'
          halign={Gtk.Align.CENTER}
          onClicked={() => revealMusic.set(false)}
        />

        <button
          name='themes'
          cssClasses={['bar_mode']}
          cursor={Gdk.Cursor.new_from_name('pointer', null)}
          label='/ Themes //'
          halign={Gtk.Align.CENTER}
          onClicked={() => revealThemes.set(false)}
        />
      </stack>
    </box>
  )
}

function Right() {
  return (
    <box
      cssClasses={['right']}
      spacing={12}>
      <button
        cursor={Gdk.Cursor.new_from_name('pointer', null)}
        onClicked={() => revealCalendar.set(!revealCalendar.get())}>
        <box>
          <label label='//' />
          <label label={time()} />
          <label label='/' />
        </box>
      </button>

      <button
        cssClasses={['power_btn']}
        cursor={Gdk.Cursor.new_from_name('pointer', null)}
        onClicked={() => revealPower.set(!revealPower.get())}>
        <label label='/ POWER //' />
      </button>
    </box>
  )
}

function Bar() {
  return (
    <centerbox cssName='bar'>
      <Left />
      <Center />
      <Right />
    </centerbox>
  )
}

export default function(monitor: Gdk.Monitor) {
  return (
    <window
      namespace='astal_window'
      gdkmonitor={monitor}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      visible={true}>
      <Bar />
    </window>
  )
}
