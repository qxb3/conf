import Battery from 'gi://AstalBattery'
import BatteryLogs from '@services/BatteryLogs'

import { Astal, Gdk, Gtk } from 'astal/gtk3'
import { bind, Variable } from 'astal'

import { FloatingWindow } from '@widgets'
import { formatDuration } from '@utils/etc'
import { revealBattery } from './vars'

const battery = Battery.get_default()
const batteryLogs = BatteryLogs.get_default()

function BatteryWindow() {
  return (
    <box
      className='content'
      vertical={true}
      spacing={16}>
      <box
        valign={Gtk.Align.CENTER}
        spacing={4}>
        <icon
          className='battery_icon'
          icon={bind(battery, 'iconName')}
        />

        <label
          className='percentage'
          label={
            bind(battery, 'percentage')
              .as(percentage => `${Math.round(percentage * 100)}%`)
          }
          xalign={0}
          yalign={0}
        />
      </box>

      <box>
        <label
          className='time_left'
          label={
            Variable.derive(
              [
                bind(battery, 'state'),
                bind(battery, 'timeToFull'),
                bind(battery, 'timeToEmpty')
              ],
              (state, timeToFull, timeToEmpty) => {
                switch(state) {
                  case Battery.State.CHARGING:
                    return `Time To Full: ${formatDuration(timeToFull)}`
                  case Battery.State.DISCHARGING:
                    return `Time To Empty: ${formatDuration(timeToEmpty)}`
                  default:
                    return `Unknown State`
                }
              }
            )()
          }
        />
      </box>

      <Gtk.Separator visible />

      {bind(batteryLogs, 'logs').as(logs => (
        <box
          className='graph'
          valign={Gtk.Align.END}
          css={`min-height: 125px;`}
          homogeneous={true}
          spacing={4}>
          {Array.from({ length: 12 }).map((_, i) => (
            <box
              vertical={true}
              valign={Gtk.Align.END}>
              <box
                className='bar'
                css={`min-height: ${(logs[i]?.battery_level / 100) * 125 || 1}px;`}
              />
            </box>
          ))}
        </box>
      ))}
    </box>
  )
}

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <FloatingWindow
      className='battery'
      title='Battery'
      gdkmonitor={gdkmonitor}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
      revealer={revealBattery}
      transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}>
      <BatteryWindow />
    </FloatingWindow>
  )
}
