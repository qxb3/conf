import NetworkService from 'gi://AstalNetwork'
import BluetoothService from 'gi://AstalBluetooth'
import WpService from 'gi://AstalWp'
import MprisService from 'gi://AstalMpris'
import NotifdService from 'gi://AstalNotifd'

import { Gtk } from 'astal/gtk3'
import { bind, Binding, Variable } from 'astal'

export interface ButtonProps {
  name: string,
  className?: string | Binding<string | undefined> | undefined
  icon: string | Binding<string | undefined> | undefined
}

const network = NetworkService.get_default()
const bluetooth = BluetoothService.get_default()
const audio = WpService.get_default()!.get_audio()!
const spotify = MprisService.Player.new('spotify')
const notifyd = NotifdService.get_default()

function ButtonIcon({ name, className, icon = 'icon' }: ButtonProps) {
  return (
    <box
      vertical={true}
      spacing={6}>
      <icon
        className={className}
        icon={icon}
      />

      <label
        className='name'
        label={name}
      />
    </box>
  )
}

function NetworkButton() {
  return (
    <button
      className='network_button'
      valign={Gtk.Align.CENTER}>
      {bind(network, 'primary').as(primary => (
        <stack shown={primary.toString()}>
          {/* Wired */}
          <box name={NetworkService.Primary.WIRED.toString()}>
            <ButtonIcon
              name='WIRED'
              className='icon'
              icon={bind(network.get_wired()!, 'state').as(state => {
                switch (state) {
                  case  NetworkService.DeviceState.ACTIVATED:
                    return 'network-wired-symbolic'
                  case  NetworkService.DeviceState.DISCONNECTED:
                    return 'network-wired-disconnected-symbolic'
                  case  NetworkService.DeviceState.UNKNOWN |
                    NetworkService.DeviceState.UNAVAILABLE:
                    return 'network-wired-no-route-symbolic'
                  default:
                    return 'network-wireless-offline-symbolic'
                }
              })}
            />
          </box>

          {/* Wifi */}
          <box name={NetworkService.Primary.WIFI.toString()}>
            <ButtonIcon
              name='WIFI'
              className='icon'
              icon={bind(network.get_wifi()!, 'state').as(state => {
                switch (state) {
                  case  NetworkService.DeviceState.ACTIVATED:
                    return 'network-wireless-symbolic'
                  case  NetworkService.DeviceState.UNKNOWN |
                    NetworkService.DeviceState.UNAVAILABLE:
                    return 'network-wireless-offline-symbolic'
                  case  NetworkService.DeviceState.DISCONNECTED:
                    return 'network-wireless-no-route-symbolic'
                  default:
                    return 'network-wireless-offline-symbolic'
                }
              })}
            />
          </box>
        </stack>
      ))}
    </button>
  )
}

function BluetoothButton() {
  return (
    <button
      className='blueetoth_button'
      valign={Gtk.Align.CENTER}
      cursor='pointer'
      onClick={() => bluetooth.toggle()}>
      <stack
        shown={
          bind(bluetooth, 'isPowered')
            .as(isPowered => isPowered ? 'on' : 'off')
        }>
        <box name='on'>
          <ButtonIcon
            name='BLUE'
            className='icon'
            icon='bluetooth-active-symbolic'
          />
        </box>

        <box name='off'>
          <ButtonIcon
            name='BLUE'
            className='icon inactive'
            icon='bluetooth-disconnected-symbolic'
          />
        </box>
      </stack>
    </button>
  )
}

function MuteButton() {
  const isMute = Variable(false)

  isMute.subscribe((value) => {
    if (value) {
      audio
        .get_speakers()!
        .map(speaker => speaker.set_mute(true))
    }

    if (!value) {
      audio
        .get_speakers()!
        .map(speaker => speaker.set_mute(false))
    }
  })

  return (
    <button
      className='mute_button'
      cursor='pointer'
      valign={Gtk.Align.CENTER}
      onClick={() => isMute.set(!isMute.get())}
      onDestroy={() => isMute.drop()}>
      <stack shown={isMute().as(mute => !mute ? 'active' : 'silent')}>
        <box name='active'>
          <ButtonIcon
            name='SILENT'
            className='icon'
            icon='audio-volume-high-symbolic'
          />
        </box>

        <box name='silent'>
          <ButtonIcon
            name='SILENT'
            className='icon inactive'
            icon='audio-volume-muted-symbolic'
          />
        </box>
      </stack>
    </button>
  )
}

function DnDButton() {
  return (
    <button
      className='dnd_button'
      cursor='pointer'
      valign={Gtk.Align.CENTER}
      onClick={() => notifyd.set_dont_disturb(!notifyd.get_dont_disturb())}>
      <stack shown={bind(notifyd, 'dontDisturb').as(isDnD => !isDnD ? 'active' : 'dnd')}>
        <box name='active'>
          <ButtonIcon
            name='DND'
            className='icon'
            icon='preferences-system-notifications'
          />
        </box>

        <box name='dnd'>
          <ButtonIcon
            name='DND'
            className='icon inactive'
            icon='notifications-disabled-symbolic'
          />
        </box>
      </stack>
    </button>
  )
}

function ButtonControls() {
  return (
    <box
      className='buttons'
      valign={Gtk.Align.CENTER}
      homogeneous={true}
      spacing={12}>
      <NetworkButton />
      <BluetoothButton />
      <MuteButton />
      <DnDButton />
    </box>
  )
}

function Sliders() {
  return (
    <box
      className='sliders'
      vertical={true}>
      {/* Volume Slider */}
      {bind(audio, 'defaultSpeaker').as(speaker => (
        <box
          className='volume_slider'
          spacing={12}>
          <button
            cursor='pointer'
            onClick={() => speaker.set_mute(!speaker.get_mute())}>
            <label
              className='icon'
              label={
                bind(speaker, 'mute')
                  .as(isMute => !isMute ? '󰕾' : '󰸈')
              }
            />
          </button>

          <slider
            className={
              bind(speaker, 'mute')
                .as(isMute => isMute ?
                    'slider mute' : 'slider'
                )
            }
            cursor='pointer'
            value={bind(speaker, 'volume')}
            max={1.5}
            drawValue={false}
            hexpand={true}
            onDragged={({ value }) => speaker.set_volume(value)}
          />
        </box>
      ))}

      {/* Music Slider */}
      <box
        className='music_slider'
        spacing={12}>
        <button
          cursor='pointer'
          onClick={() => spotify.set_volume(spotify.get_volume() <= 0 ? 100 : 0)}>
          <label
            className='icon'
            label={
              bind(spotify, 'volume')
                .as(volume => volume <= 0 ? '󰎊' : '󰎌')
            }
          />
        </button>

        <slider
          className='slider'
          cursor='pointer'
          value={bind(spotify, 'volume')}
          max={1}
          drawValue={false}
          hexpand={true}
          onDragged={({ value }) => spotify.set_volume(value)}
        />
      </box>
    </box>
  )
}

export default function() {
  return (
    <box
      className='desktop_controls'
      vertical={true}
      spacing={12}>
      <ButtonControls />
      <Sliders />
    </box>
  )
}
