import Applications from 'gi://AstalApps'

import { Astal, Gdk, Gtk, hook } from 'astal/gtk4'

import { revealLauncher } from './vars'
import { Variable } from 'astal'

const applications = new Applications.Apps({
  nameMultiplier: 2,
  entryMultiplier: 0,
  executableMultiplier: 2
})

const queriedApps = Variable<Applications.Application[]>(applications.fuzzy_query(''))
const selectedApp = Variable<Applications.Application>(queriedApps.get()[0])
const selectedIndex = Variable(0)

revealLauncher.subscribe(reveal => {
  if (!reveal) {
    queriedApps.set(applications.fuzzy_query(''))
    selectedApp.set(queriedApps.get()[0])
    selectedIndex.set(0)
  }
})

function Launcher() {
  return (
    <box
      cssName='launcher'
      vertical={true}>
      <Gtk.ScrolledWindow
        hexpand={true}
        vexpand={true}>
        <box
          cssClasses={['list']}
          vertical={true}>
          {queriedApps(apps =>
            apps.length <= 0
              ? <label
                cssClasses={['no_result']}
                label='no result'
              />
              : apps.map(app => (
                <button
                  cssClasses={
                    selectedApp(selectedApp =>
                      selectedApp.get_name() === app.get_name()
                        ? ['app', 'selected']
                        : ['app']
                    )
                  }
                  cursor={Gdk.Cursor.new_from_name('pointer', null)}
                  onClicked={() => {
                    if (!selectedApp.get()) return

                    selectedApp
                      .get()
                      .launch()

                    revealLauncher.set(false)
                  }}>
                  <label
                    label={app.get_name().toLowerCase()}
                    xalign={0}
                  />
                </button>
              ))
          )}
        </box>
      </Gtk.ScrolledWindow>

      <entry
        cssClasses={['input']}
        placeholderText='search'
        hexpand={true}
        onNotifyText={({ text }) => {
          queriedApps.set(applications.fuzzy_query(text))
          selectedApp.set(queriedApps.get()[0])
          selectedIndex.set(0)
        }}
        setup={(self) => {
          hook(self, revealLauncher, () => {
            if (!revealLauncher.get()) {
              self.text = ''

              queriedApps.set(applications.fuzzy_query(''))
              selectedApp.set(queriedApps.get()[0])
              selectedIndex.set(0)
            } else {
              self.grab_focus()
            }
          })
        }}
      />
    </box>
  )
}

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <window
      namespace='astal_window_launcher'
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.NORMAL}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.TOP}
      visible={revealLauncher()}
      keymode={
        revealLauncher(revealed =>
          revealed
            ? Astal.Keymode.EXCLUSIVE
            : Astal.Keymode.NONE
        )
      }
      onKeyReleased={(_, keyval) => {
        switch (keyval) {
          case Gdk.KEY_Tab:
          case Gdk.KEY_Down:
            if (queriedApps.get().length <= 0) return

            if (selectedIndex.get() < queriedApps.get().length - 1) {
              selectedIndex.set(selectedIndex.get() + 1)
              selectedApp.set(queriedApps.get()[selectedIndex.get()])
            }

            break
          case Gdk.KEY_Up:
            if (queriedApps.get().length <= 0) return

            if (selectedIndex.get() > 0) {
              selectedIndex.set(selectedIndex.get() - 1)
              selectedApp.set(queriedApps.get()[selectedIndex.get()])
            }

            break
          case Gdk.KEY_Return:
            if (!selectedApp.get()) return

            selectedApp
              .get()
              .launch()

            revealLauncher.set(false)

            break
        }
      }}>
      <Launcher />
    </window>
  )
}
