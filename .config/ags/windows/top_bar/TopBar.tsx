import Hyprland from 'gi://AstalHyprland'
import Network from 'gi://AstalNetwork'
import Battery from 'gi://AstalBattery'

import { Astal, Gdk, Gtk } from 'astal/gtk3'
import { bind, Variable } from 'astal'

import { revealNetwork } from '@windows/network/vars'
import { revealBattery } from '@windows/battery/vars'
import { revealNotificationCenter } from '@windows/notification_center/vars'
import { revealCalendar } from '@windows/calendar/vars'

const hyprland = Hyprland.get_default()
const network = Network.get_default()
const battery = Battery.get_default()

const time = Variable('')
  .poll(1000, `date +"%h %d - %I:%M %p"`)

function Left() {
  return (
    <box
      className='left'
      halign={Gtk.Align.START}>
      <label
        className='distro'
        label={`${DISTRO}  インク`}
      />
    </box>
  )
}

function Center() {
  return (
    <box
      className='center'
      halign={Gtk.Align.CENTER}>
      <box
        className='workspaces'
        spacing={8}>
        {Array.from({ length: 5 }).map((_, i) =>
          <button
            className='workspace'
            cursor='pointer'
            valign={Gtk.Align.CENTER}
            onClick={() => hyprland.message(`dispatch workspace ${i + 1}`)}
            setup={(self) => {
              self.hook(hyprland, 'event', () => {
                self.toggleClassName(
                  'active',
                  hyprland.get_focused_workspace().get_id() === i + 1
                )
              })
            }}/>
        )}
      </box>
    </box>
  )
}

function Right() {
  return (
    <box
      className='right'
      halign={Gtk.Align.END}
      spacing={10}>
      <button
        className={
          revealNetwork()
            .as(revealed =>
              revealed
                ? 'network_btn active'
                : 'network_btn'
            )
        }
        cursor='pointer'
        onClick={() => {
          revealNetwork.set(
            !revealNetwork.get()
          )
        }}>
          {bind(network, 'primary').as(primary => {
            if (primary === Network.Primary.UNKNOWN) {
              return (
                <icon icon='network-wireless-offline-symbolic' />
              )
            }

            if (primary === Network.Primary.WIRED) {
              const wiredNetwork = network.get_wired()!

              return (
                <icon icon={bind(wiredNetwork, 'iconName')} />
              )
            }

            if (primary === Network.Primary.WIFI) {
              const wifiNetwork = network.get_wifi()!

              return (
                <icon icon={bind(wifiNetwork, 'iconName')} />
              )
            }
        })}
      </button>

      <button
        className={
          revealBattery()
            .as(revealed =>
              revealed
                ? 'battery_btn active'
                : 'battery_btn'
            )
        }
        cursor='pointer'
        visible={bind(battery, 'isPresent')}
        onClick={() => {
          revealBattery.set(
            !revealBattery.get()
          )
        }}>
        <icon
          icon={bind(battery, 'iconName')}
        />
      </button>

      <button
        className={
          revealNotificationCenter()
            .as(revealed =>
              revealed
                ? 'bell active'
                : 'bell'
            )
        }
        cursor='pointer'
        onClick={() => {
          revealNotificationCenter.set(
            !revealNotificationCenter.get()
          )
        }}>
        <icon
          icon='custom-bell-symbolic'
        />
      </button>

      <button
        className={
          revealCalendar().as(revealed =>
            revealed
              ? 'time active'
              : 'time'
          )
        }
        cursor='pointer'
        onClick={() => {
          revealCalendar.set(
            !revealCalendar.get()
          )
        }}>
        <label
          label={time()}
        />
      </button>
    </box>
  )
}


function TopBar() {
  return (
    <centerbox className='top_bar'>
      <Left />
      <Center />
      <Right />
    </centerbox>
  )
}

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <window
      namespace='astal_window_top_bar'
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT}>
      <TopBar />
    </window>
  )
}
