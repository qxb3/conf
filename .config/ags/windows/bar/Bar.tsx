import Hyprland from 'gi://AstalHyprland'

import { Astal, Gdk } from 'astal/gtk4'
import { bind } from 'astal'

const hyprland = Hyprland.get_default()

function Workspaces() {
  return (
    <box
      cssClasses={['workspaces']}
      spacing={8}>
      {['one', 'two', 'three', 'four', 'five'].map((name, i) => (
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
          onClicked={() => hyprland.message(`dispatch workspace ${i + 1}`)}>
          <label
            cssClasses={['name']}
            label={name}
          />
        </button>
      ))}
    </box>
  )
}

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
      <Workspaces />
    </box>
  )
}

function Right() {
  return (
    <box cssClasses={['right']}>
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
