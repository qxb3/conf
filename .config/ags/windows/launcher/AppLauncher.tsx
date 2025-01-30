import Applications from 'gi://AstalApps'
import Pango from 'gi://Pango'

import { Astal, Gdk, Gtk, hook } from 'astal/gtk4'
import { Variable } from 'astal'

import { revealApplauncher } from './vars'
import Wp05 from 'gi://Wp'

const applications = new Applications.Apps({
  nameMultiplier: 2,
  entryMultiplier: 0,
  executableMultiplier: 2
})

const query = Variable('')
const queriedApps = Variable(applications.fuzzy_query(''))
const selectedApp = Variable(queriedApps.get()[0])
const selectedIndex = Variable(0)

function ApplicationList() {
  return (
    <Gtk.ScrolledWindow
      cssClasses={['applications']}
      hexpand={true}
      vexpand={true}>
      <box
        vertical={true}
        spacing={8}>
        {queriedApps(apps =>
          apps.length <= 0
            ? <label label='No result (dumbass)' />
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
                  revealApplauncher.set(false)
                  app.launch()
                }}>
                <box spacing={4}>
                  <label label={'/'.repeat(Math.random() * 3)} />
                  <label
                    label={app.get_name()}
                    maxWidthChars={20}
                    ellipsize={Pango.EllipsizeMode.END}
                  />
                  <label label={'/'.repeat(Math.random() * 3)} />
                </box>
              </button>
            ))
        )}
      </box>
    </Gtk.ScrolledWindow>
  )
}

function QueryBox() {
  return (
    <box cssClasses={['query_box']}>
      <entry
        cssClasses={['query']}
        hexpand={true}
        placeholderText='Search'
        onNotifyText={({ text }) => {
          query.set(text)
          queriedApps.set(applications.fuzzy_query(text))
          selectedApp.set(queriedApps.get()[0])
        }}
        onKeyReleased={(_, keyval) => {
          console.log(keyval)
        }}
        setup={(self) => {
          hook(self, revealApplauncher, () => {
            if (!revealApplauncher.get()) {
              self.text = ''

              queriedApps.set(applications.fuzzy_query(''))
              selectedApp.set(queriedApps.get()[0])
              selectedIndex.set(0)
            }

            self.grab_focus()
          })
        }}
      />
    </box>
  )
}

function AppLauncher() {
  return (
    <box
      cssName='app_launcher'
      vertical={true}
      spacing={8}>
      <ApplicationList />
      <QueryBox />
    </box>
  )
}

export default function(monitor: Gdk.Monitor) {
  return (
    <window
      namespace='astal_window_applauncher'
      gdkmonitor={monitor}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.TOP}
      exclusivity={Astal.Exclusivity.NORMAL}
      defaultWidth={1}
      defaultHeight={1}
      visible={true}
      keymode={
        revealApplauncher(revealed =>
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

            revealApplauncher.set(false)

            break
        }
      }}>
      <revealer
        revealChild={revealApplauncher()}
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
        transitionDuration={200}>
        <AppLauncher />
      </revealer>
    </window>
  )
}
