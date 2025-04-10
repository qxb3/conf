import Mpris from 'gi://AstalMpris'
import Battery from 'gi://AstalBattery'
import Network from 'gi://AstalNetwork'

import { Astal, Gdk, Gtk } from 'astal/gtk3'
import { bind, exec, Variable } from 'astal'

const spotify = Mpris.Player.new('spotify')
const network = Network.get_default()
const battery = Battery.get_default()

const kernelRelease = exec(`uname --kernel-release`)
const time = Variable('').poll(1000, `date +"%B %d, %Y"`)

function TopBar() {
  return (
    <centerbox
      className='top_bar'>
      <box
        halign={Gtk.Align.START}>
        <label
          label={`kernel v${kernelRelease}`.toUpperCase()}
        />
      </box>

      <box
        halign={Gtk.Align.CENTER}>
        {bind(spotify, 'available').as(isAvailable => (
          <label
            label={bind(spotify, 'title').as(title => isAvailable ? `Playing: ${title}` : `No Music`)
              .as(res => res.toUpperCase())}
          />
        ))}
      </box>

      <box
        halign={Gtk.Align.END}
        spacing={10}>
        {
          bind(network, 'primary')
            .as(primary => {
              if (primary === Network.Primary.WIFI) return 'wifi'
              else if (primary === Network.Primary.WIRED) return 'wired'
              else return 'unknown'
            })
            .as(primary => <label label={primary.toUpperCase()} />)
        }

        <label
          label={
            bind(battery, 'percentage')
              .as(p => p * 100)
              .as(p => `${p} percent`.toUpperCase())
            }
        />

        <label
          label={time(t => t.toUpperCase())}
        />
      </box>
    </centerbox>
  )
}

export default function(m: Gdk.Monitor) {
  return (
    <window
      namespace='astal_window'
      gdkmonitor={m}
      layer={Astal.Layer.TOP}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT}>
      <TopBar />
    </window>
  )
}
