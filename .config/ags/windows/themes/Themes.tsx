import ThemeManager from '@services/ThemeManager'

import { App, Astal, Gdk, Gtk } from 'astal/gtk4'
import { exec, execAsync, readFile } from 'astal'

import { ScrolledWindow } from '@widgets'
import { revealThemes } from './vars'

const themeManager = ThemeManager.get_default()

function Themes() {
  const themes = exec(`find -L ${SRC}/themes -iname '*.scss'`)
    .split('\n')
    .map(path => ({
      name: path.split('/').pop()!.replace('.scss', ''),
      path,
      lines: readFile(path)
        .split('\n')
        .filter(line => line.startsWith('$') && line.includes('#'))
    }))
    .map(theme => ({
      name: themeManager.fromString(theme.name),
      colors: theme.lines.map(line => {
        const [identifier, value] = line.split(':')
        const name = identifier.replace('$', '').trim()
        const color = value.replace(';', '').trim()

        return { name, color }
      })
    }))

  return (
    <box cssName='themes'>
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
          {themes.map(theme => (
            <button
              cursor={Gdk.Cursor.new_from_name('pointer', null)}
              onClicked={() => {
                themeManager.set_theme(theme.name)
                revealThemes.set(false)
              }}>
              <box
                cssClasses={['theme', themeManager.toString(theme.name)]}
                setup={() => {
                  App.apply_css(`.theme.${themeManager.toString(theme.name)} { background-color: ${theme.colors.find(color => color.name === 'primary')!.color} }`)
                  themeManager.connect('notify::changed', () => {
                    console.log('foo')
                  })
                }}
              />
            </button>
          ))}
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
        revealChild={revealThemes()}
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
        transitionDuration={200}>
        <Themes />
      </revealer>
    </window>
  )
}
