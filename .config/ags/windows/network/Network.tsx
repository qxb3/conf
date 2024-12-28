import Network from 'gi://AstalNetwork'
import { Astal, Gdk, Gtk } from 'astal/gtk3'
import { bind, exec, execAsync, subprocess, Variable } from 'astal'

import { FloatingWindow, CheckButton} from '@widgets'
import { revealNetwork } from './vars'

const wifi = Network
  .get_default()
  .get_wifi()!

if (wifi.state) {
  wifi.scan()
}

function ApDropdownNotConnected(props: { ap: Network.AccessPoint }) {
  const { ap } = props

  const password = Variable('')
  const showPassword = Variable(false)
  const err = Variable('')

  return (
    <box
      className='dropdown'
      vertical={true}
      spacing={24}
      onDestroy={() => {
        password.drop()
        showPassword.drop()
        err.drop()
      }}>
      <box
        vertical={true}
        spacing={8}>
        <overlay
          className='password_container'
          passThrough={true}>
          <entry
            className='password'
            hexpand={true}
            visibility={showPassword()}
            css={
              showPassword(show =>
                show ? 'letter-spacing: 1px;' : 'letter-spacing: 4px;'
              )
            }
            onChanged={(self) => {
              password.set(self.text)
            }}
          />

          <label
            className='placeholder'
            label={
              password(password =>
                password.length <= 0 ? 'Password' : ''
              )
            }
            xalign={0}
          />
        </overlay>

        <box spacing={8}>
          <CheckButton
            className='show_password'
            cursor='pointer'
            halign={Gtk.Align.START}
            valign={Gtk.Align.CENTER}
            onButtonPressEvent={(self) => {
              self.connect('notify::active', () => {
                showPassword.set(self.active)
              })
            }}
          />

          <label label='Show Password' />
        </box>
      </box>

      <box
        vertical={true}
        spacing={2}>
        <button
          className='connect'
          cursor='pointer'
          onClick={() => {
            if (password.get().length <= 0)
              return err.set('Password needs 8+ chars long')

            console.log(ap.get_ssid())
            console.log(password.get())
            subprocess(
              `nmcli dev wifi connect ${ap.get_ssid()} password ${password.get()}`,
              () => {},
              () => err.set(`Failed to connect: ${ap.get_ssid()}`)
            )
          }}>
          <label
            className='label'
            label='Connect'
          />
        </button>

        <label
          className='err'
          label={err()}
          visible={
            err()
              .as(err => err.length > 0)
          }
        />
      </box>
    </box>
  )
}

function ApDropdownConnected(props: {
  activeAp: Network.AccessPoint | undefined
}) {
  const { activeAp } = props

  return (
    <box
      className='dropdown'
      vertical={true}>
      <button
        className='disconnected'
        cursor='pointer'
        onClick={() => {
          execAsync(`nmcli connection delete ${activeAp?.get_ssid()}`)
        }}>
        <label
          className='label'
          label='Disconnected'
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

  const menuRevealer = Variable(false)

  return (
    <box
      className='ap'
      vertical={true}
      spacing={8}
      onDestroy={() => menuRevealer.drop()}>
      <button
        cursor='pointer'
        onClick={() => {
          menuRevealer.set(
            !menuRevealer.get()
          )
        }}>
        <box
          className='details'
          spacing={8}
          valign={Gtk.Align.CENTER}>
          <icon
            className='icon'
            icon={bind(ap, 'iconName')}
          />

          <box>
            <label
              className='ssid'
              label={
                bind(ap, 'ssid')
                .as(ssid =>
                  `${ssid} ${activeAp?.get_ssid() === ssid ? '(Connected)' : ''}`
                )
              }
              maxWidthChars={24}
              valign={Gtk.Align.CENTER}
              truncate={true}
              xalign={0}
              yalign={0}
            />

            <icon
              className='down-icon'
              icon={
                menuRevealer()
                .as(revealed =>
                  revealed
                    ? 'go-up-symbolic'
                    : 'go-down-symbolic'
                )
              }
            />
          </box>
        </box>
      </button>

      <revealer
        revealChild={menuRevealer()}
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
        transitionDuration={USER_SETTINGS.animationSpeed}>
        {activeAp?.get_ssid() === ap.get_ssid() && (
          <ApDropdownConnected activeAp={activeAp} />
        )}

        {activeAp?.get_ssid() !== ap.get_ssid() && (
          <ApDropdownNotConnected ap={ap} />
        )}
      </revealer>
    </box>
  )
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
        valign={Gtk.Align.CENTER}
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

            sortedAPGroups.sort((a, b) => {
              if (a === activeAp) return -1
              if (b === activeAp) return 1
              return b.get_strength() - a.get_strength()
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
      transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
      keymode={Astal.Keymode.ON_DEMAND}>
      <NetworkWindow />
    </FloatingWindow>
  )
}
