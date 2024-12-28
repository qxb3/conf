import Network from 'gi://AstalNetwork'
import { Astal, Gdk, Gtk } from 'astal/gtk3'

import { FloatingWindow } from '@widgets'
import { revealNetwork } from './vars'
import { bind, Variable } from 'astal'

const wifi = Network
  .get_default()
  .get_wifi()!

if (wifi.state) {
  wifi.scan()
}

function Header() {
  return (
    <box
      className='header'
      valign={Gtk.Align.CENTER}
      spacing={8}>
      <label
        className='title'
        label='Wifi Networks'
        yalign={0}
      />

      <switch
        className='switch'
        cursor='pointer'
        state={bind(wifi, 'enabled')}
        setup={(self) => {
          self.connect('notify::active', () => {
            wifi.set_enabled(self.state)
          })
        }}
      />

      <button
        className='refresh'
        cursor='pointer'
        halign={Gtk.Align.END}
        hexpand={true}
        onClick={() => {
          wifi.scan()
        }}>
        <icon
          className='icon'
          icon='view-refresh-symbolic'
        />
      </button>
    </box>
  )
}

function Ap(props: {
  ap: Network.AccessPoint,
  activeAp: Network.AccessPoint
}) {
  const { ap, activeAp } = props

  return (
    <button
      className='ap'
      cursor='pointer'
      onClick={() => {
      }}>
      <box
        spacing={8}
        valign={Gtk.Align.CENTER}>
        <icon
          className='icon'
          icon={bind(ap, 'iconName')}
        />

        <label
          className='ssid'
          label={bind(ap, 'ssid')}
          maxWidthChars={16}
          valign={Gtk.Align.CENTER}
          truncate={true}
          xalign={0}
          yalign={0}
        />

        {activeAp?.get_ssid() === ap.get_ssid() && (
          <button
            className='disconnect'
            valign={Gtk.Align.CENTER}
            halign={Gtk.Align.END}
            hexpand={true}
            onClick={() => {}}>
            <label
              className='label'
              label='Disconnect'
            />
          </button>
        )}

        {activeAp?.get_ssid() !== ap.get_ssid() && (
          <button
            className='connect'
            valign={Gtk.Align.CENTER}
            halign={Gtk.Align.END}
            hexpand={true}
            onClick={() => {}}>
            <label
              className='label'
              label='Connect'
            />
          </button>
        )}
      </box>
    </button>
  )
}

function WifiNetworks() {
  return (
    <scrollable vexpand={true}>
      <box
        className='wifi_networks'
        vertical={true}>
        {Variable.derive(
          [
            bind(wifi, 'accessPoints'),
            bind(wifi, 'activeAccessPoint')
          ],
          (aps, activeAp) => {
            const groupedAPs = aps.reduce((acc: Record<string, Network.AccessPoint[]>, ap: any) => {
              const ssid = ap.ssid?.trim()
              if (ssid)
                (acc[ssid] ||= []).push(ap)

              return acc
            }, {})

            const sortedAPGroups = Object.values(groupedAPs).map(apGroup => {
              apGroup.sort((a, b) => {
                if (a === activeAp) return -1
                if (b === activeAp) return 1
                return b.get_strength() - a.get_strength()
              })

              return apGroup[0]
            })

            return (
              sortedAPGroups.map(ap => (
                <Ap
                  ap={ap}
                  activeAp={activeAp}
                />
              ))
            )
          }
        )()}
      </box>
    </scrollable>
  )
}

function NoWifiNetwork() {
  return (
    <box
      className='no_wifi_network'
      vertical={true}
      vexpand={true}
      spacing={12}>
      <icon
        className='icon'
        icon='network-wireless-offline-symbolic'
      />

      <label
        className='title'
        label='Wifi Disconnected'
      />
    </box>
  )
}

function NetworkWindow() {
  return (
    <box
      className='content'
      vertical={true}>
      <Header />
      <Gtk.Separator visible />

      {bind(wifi, 'enabled').as(enabled =>
        enabled
          ? <WifiNetworks />
          : <NoWifiNetwork />
      )}
    </box>
  )
}

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <FloatingWindow
      className='network'
      title={
        Variable.derive(
          [
            bind(wifi, 'enabled'),
            bind(wifi, 'scanning')
          ],
          (enabled, scanning) => {
            if (!enabled) return 'Network'

            if (scanning) return 'Network (scanning)'
              else return 'Network'
          }
        )()
      }
      gdkmonitor={gdkmonitor}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
      revealer={revealNetwork}
      transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}>
      <NetworkWindow />
    </FloatingWindow>
  )
}
