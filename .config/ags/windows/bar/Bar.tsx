import Hyprland from 'gi://AstalHyprland'

import { Astal, Gdk, Gtk } from 'astal/gtk4'
import { bind, Variable } from 'astal'
import { revealMusic } from '../music/vars'

const hyprland = Hyprland.get_default()

const time = Variable('').poll(1000, `date +'%I/%M/%p'`)

const workspaces = [
  { name: 'one /',        action: 'music player', fn: () => revealMusic.set(!revealMusic.get()) },
  { name: 'two //',       action: 'none',         fn: () => {} },
  { name: '/ three //',   action: 'none',         fn: () => {} },
  { name: '/// four /',   action: 'none',         fn: () => {} },
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

      // {workspaces.map(({ name, fn }, i) => (
      //   <button
      //     cssClasses={
      //       bind(hyprland, 'focusedWorkspace')
      //         .as(focusedWorkspace => (
      //           focusedWorkspace.get_id() === i + 1
      //             ? ['workspace', 'active']
      //             : ['workspace']
      //         ))
      //     }
      //     cursor={Gdk.Cursor.new_from_name('pointer', null)}
      //     onButtonPressed={(_, event) => {
      //       switch (event.get_button()) {
      //         case 1:
      //           hyprland.message(`dispatch workspace ${i + 1}`)
      //           break
      //         case 3:
      //           fn()
      //       }
      //     }}>
      //     <label
      //       cssClasses={['name']}
      //       label={name}
      //     />
      //   </button>
      // ))}
      //
function Left() {
  return (
    <box
      cssClasses={['left']}
      spacing={8}>
      <image
        cssClasses={['logo']}
        iconName='arch-symbolic'
        pixelSize={24}
      />

      <label
        cssClasses={['title']}
        label='/ Hyprland //'
      />
    </box>
  )
}

function Center() {
  return (
    <box cssClasses={['center']}>
      <stack
        visibleChildName={
          bind(Variable.derive([bind(revealMusic)], (revealMusic) => {
            if (revealMusic) return 'music'

            return 'workspaces'
          }))
        }>
        <Workspaces />

        <button
          name='music'
          cssClasses={['music_title']}
          cursor={Gdk.Cursor.new_from_name('pointer', null)}
          label='Music Player'
          halign={Gtk.Align.CENTER}
          onClicked={() => revealMusic.set(false)}
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
      <label label='//' />
      <label label={time()} />
      <label label='/' />

      <button
        cssClasses={['power_btn']}
        cursor={Gdk.Cursor.new_from_name('pointer', null)}
        onClicked={() => {}}>
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
      namespace='astal_window_bar'
      gdkmonitor={monitor}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      visible={true}>
      <Bar />
    </window>
  )
}
