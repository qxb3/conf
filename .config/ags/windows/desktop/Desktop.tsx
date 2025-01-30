import Wp from 'gi://AstalWp'
import Mpris from 'gi://AstalMpris'
import Brightness from '@services/Brightness'

import { Astal, Gdk, Gtk } from 'astal/gtk4'
import { bind, exec, GLib } from 'astal'

import { revealDesktop } from './vars'

const audio = Wp.get_default()!.get_audio()!
const spotify = Mpris.Player.new('spotify')
const brightness = Brightness.get_default()

function Me() {
  return (
    <box
      cssClasses={['me']}
      spacing={12}>
      <image
        cssClasses={['pfp']}
        file={`${GLib.get_home_dir()}/.face`}
      />

      <box
        vertical={true}
        spacing={4}>
        <label
          cssClasses={['name']}
          label={`// ${GLib.get_user_name()} /`}
          xalign={0}
        />

        <label
          cssClasses={['up']}
          label={`/ up ${exec(`bash -c "uptime -p | sed 's/^up //; s/,.*//'"`)}`}
          xalign={0}
        />
      </box>
    </box>
  )
}

function Controls() {
  return (
    <box
      cssClasses={['controls']}
      spacing={4}>
      <box
        vertical={true}
        spacing={2}>
        <label label='A:' />
        <label label='M:' />
        <label label='B:' />
      </box>

      <box
        vertical={true}
        hexpand={true}
        homogeneous={true}>
        {bind(audio, 'defaultSpeaker').as(speaker => (
          <slider
            cssClasses={['audio', 'slider']}
            cursor={Gdk.Cursor.new_from_name('pointer', null)}
            value={bind(speaker, 'volume')}
            max={1.5}
            step={0.01}
            hexpand={true}
            drawValue={false}
            inverted={false}
            valign={Gtk.Align.CENTER}
            onChangeValue={({ value }) => speaker.set_volume(value)}
          />
        ))}

        <slider
          cssClasses={['music', 'slider']}
          cursor={Gdk.Cursor.new_from_name('pointer', null)}
          value={bind(spotify, 'volume')}
          max={1}
          step={0.01}
          hexpand={true}
          drawValue={false}
          inverted={false}
          valign={Gtk.Align.CENTER}
          onChangeValue={({ value }) => spotify.set_volume(value)}
        />

        <slider
          cssClasses={['music', 'slider']}
          cursor={Gdk.Cursor.new_from_name('pointer', null)}
          value={bind(brightness, 'brightness')}
          step={0.01}
          hexpand={true}
          drawValue={false}
          inverted={false}
          valign={Gtk.Align.CENTER}
          onChangeValue={({ value }) => brightness.set_brightness(value)}
        />
      </box>
    </box>
  )
}

function Desktop() {
  return (
    <box
      cssName='desktop'
      vertical={true}
      spacing={8}>
      <Me />
      <Controls />
    </box>
  )
}

export default function(monitor: Gdk.Monitor) {
  return (
    <window
      namespace='astal_window'
      gdkmonitor={monitor}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT}
      exclusivity={Astal.Exclusivity.NORMAL}
      defaultWidth={1}
      defaultHeight={1}
      visible={true}>
      <revealer
        revealChild={revealDesktop()}
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
        transitionDuration={200}>
        <Desktop />
      </revealer>
    </window>
  )
}
