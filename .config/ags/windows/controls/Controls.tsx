import Wp from 'gi://AstalWp'
import Mpris from 'gi://AstalMpris'
import Brightness from '@services/Brightness'

import { Astal, Gdk, Gtk } from 'astal/gtk3'
import { bind } from 'astal'

import { FloatingWindow } from '@widgets'
import { revealControls } from './vars'

const audio = Wp.get_default()!.audio!
const spotify = Mpris.Player.new('spotify')
const brightness = Brightness.get_default()

function Controls() {
  return (
    <box
      className='content'
      vertical={true}
      spacing={12}>

      {bind(audio, 'defaultSpeaker').as(speaker => (
        <box
          vertical={true}
          spacing={4}>
          <label
            className={
              bind(speaker, 'mute')
                .as(isMute => isMute ? 'name mute' : 'name')
            }
            label={
              bind(speaker, 'description')
                .as(desc => `${desc}:`)
            }
            xalign={0}
          />

          <slider
            className='slider'
            cursor='pointer'
            value={bind(speaker, 'volume')}
            max={1.5}
            step={0.01}
            drawValue={false}
            hexpand={true}
            onDragged={({ value }) => speaker.set_volume(value)}
          />
        </box>
      ))}

      <box
        vertical={true}
        spacing={4}>
        <label
          className={
            bind(spotify, 'volume')
              .as(volume => volume <= 0 ? 'name mute' : 'name')
          }
          label={
            bind(spotify, 'identity')
              .as(identity => `${identity}:`)
          }
          xalign={0}
        />

        <slider
          className='slider'
          cursor='pointer'
          value={bind(spotify, 'volume')}
          max={1}
          step={0.01}
          drawValue={false}
          hexpand={true}
          onDragged={({ value }) => spotify.set_volume(value)}
        />
      </box>

      <box
        vertical={true}
        spacing={4}>
        <label
          className='name'
          label='Brightness:'
          xalign={0}
        />

        <slider
          className='slider'
          cursor='pointer'
          value={bind(brightness, 'brightness')}
          max={1}
          step={0.1}
          drawValue={false}
          hexpand={true}
          onDragged={({ value }) => brightness.set_brightness(value)}
        />
      </box>
    </box>
  )
}

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <FloatingWindow
      className='controls_window'
      title='Controls'
      gdkmonitor={gdkmonitor}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT}
      revealer={revealControls}
      transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}>
      <Controls />
    </FloatingWindow>
  )
}
