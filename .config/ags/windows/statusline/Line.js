import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js'
import Gdk from 'gi://Gdk'

import {
  hyprSendMessage,
  getDate
} from '../../shared/utils.js'

import {
  revealAppLauncher,
  query
} from './vars.js'

import {
  musicStatus,
  musicTitle
} from '../../shared/music.js'

const Hyprland = await Service.import('hyprland')
// const Mpris = await Service.import('mpris')
const Battery = await Service.import('battery')

import {
  exitAppsSelect,
  appsSelectUp,
  appsSelectDown,
  appLaunch,
  assignBatteryIcon
} from './fns.js'

function BarDivider(margin = '0 5px', divider = '') {
  return Widget.Label({
    className: 'divider',
    label: divider,
    css: `
      font-weight: 900;
      margin: ${margin};
    `
  })
}

function LeftSection() {
  const WindowState = Widget.Label({
    className: 'window_state tiling',
    label: 'TILING',
    setup: (self) => self.hook(Hyprland, () => {
      const isFloating = hyprSendMessage('activewindow').floating

      if (isFloating) {
        self.label = 'FLOATING'
        self.className = 'window_state floating'
      } else {
        self.label = 'TILING'
        self.className = 'window_state tiling'
      }
    }, 'event')
  })

  const ActiveWindow = Widget.Label({
    label: Hyprland.active.client.bind('class')
      .transform(window => {
        const activeWindow = hyprSendMessage('activewindow').class

        return !window
          ? activeWindow
            ? activeWindow
            : '~'
          : window
        }
      )
  })

  const WorkspaceIcon = Widget.Box({
    children: [
      Widget.Label('['),
      Widget.Label('+'),
      Widget.Label(']'),
    ]
  })

  const Music = Widget.Box({
    className: 'music',
    spacing: 2,
    children: [
      Widget.Label({
        label: musicTitle.bind()
          .transform(t => musicStatus === 'Stopped' ? '󰝛 No Music - Title' : `󰝚 Playing - ${t}`),
      })
    ]
  })

  return Widget.Box({
    className: 'left',
    hexpand: true,
    homogeneous: false,
    spacing: 8,
    children: [
      WindowState,
      ActiveWindow,
      WorkspaceIcon,
      BarDivider('0'),
      Music
    ]
  })
}

function RightSection() {
  const NetworkButton = Widget.Button({
    className: 'network_button',
    child: Widget.Label('󰈀')
  })

  const revealBatteryPercent = Variable(false)
  const BatteryIndicator = Widget.EventBox({
    className: 'battery',
    visible: Battery.bind('available'),
    onPrimaryClick: () => revealBatteryPercent.value = !revealBatteryPercent.value,
    child: Widget.Box({
      children: [
        Widget.Label({
          className: 'icon'
        }).hook(Battery, (self) =>
          self.label = assignBatteryIcon(Battery.charging, Battery.percent)
        ),
        Widget.Revealer({
          revealChild: revealBatteryPercent.bind(),
          transition: 'slide_right',
          transitionDuration: 100,
          sensitive: true,
          child: Widget.Label({
            className: 'percent',
            label: Battery.bind('percent')
              .transform(percent => `${percent}%`)
          })
        })
      ]
    })
  })

  const NotificationButton = Widget.Button({
    className: 'notification_button',
    child: Widget.Label('󰂚')
  })

  const User = Widget.Label(Utils.exec('whoami'))

  const TimeIndicator = Widget.Label({
    className: 'time_indicator',
    label: getDate('time'),
    setup: (self) => self.poll(1000, () => self.label = getDate('time'))
  })

  const ModeIndicator = Widget.Stack({
    className: 'mode_indicator',
    shown: revealAppLauncher.bind().transform(r => r ? 'applauncher' : 'workspace'),
    children: {
      workspace: Widget.Label({
        className: 'workspace',
        label: Hyprland.active.workspace.bind('id').transform(id => `${id}:0`)
      }),
      applauncher: Widget.Label({
        className: 'applauncher',
        label: revealAppLauncher.bind().transform(r => r ? 'APP LAUNCHER' : '')
      })
    }
  })

  return Widget.Box({
    className: 'right',
    homogeneous: false,
    children: [
      NetworkButton,
      BarDivider(),
      BatteryIndicator,
      Widget.Box({
        visible: Battery.bind('available'),
        children: [ BarDivider('0 5px 0 0') ]
      }),
      NotificationButton,
      BarDivider(),
      User,

      Widget.Box({
        className: 'sections',
        children: [
          TimeIndicator,
          ModeIndicator
        ]
      })
    ]
  })
}

function AppLauncherInput() {
  const Input = Widget.Box({
    children: [
      Widget.Label(':'),
      Widget.Entry({
        className: 'input',
        hexpand: true,
        onChange: ({ text }) => query.value = text,
        onAccept: () => appLaunch(),
        setup: (self) => self.hook(revealAppLauncher, () => {
          if (revealAppLauncher.value) self.grab_focus()
          else self.text = ''
        })
      })
    ]
  })

  return Widget.Box({
    className: 'applauncher_input',
    children: [
      Input
    ]
  })
}

function Line() {
  return Widget.Box({
    className: 'line',
    children: [
      Widget.Stack({
        className: 'line',
        shown: revealAppLauncher.bind().transform(r => r ? 'appLauncherInput' : 'line'),
        children: {
          line: LeftSection(),
          appLauncherInput: AppLauncherInput()
        }
      }),
      RightSection()
    ]
  })
}

export default Widget.Window({
  name: 'line',
  layer: 'top',
  exclusivity: 'exclusive',
  keymode: revealAppLauncher.bind().transform(reveal => reveal ? 'exclusive' : 'none'),
  anchor: ['left', 'right', 'bottom'],
  child: Line().on('key-press-event', (_, event) => {
    const val = event.get_keyval()[1]
    switch (val) {
      case Gdk.KEY_Escape:
        exitAppsSelect()
        break
      case Gdk.KEY_Up:
        appsSelectUp()
        break
      case Gdk.KEY_Tab:
      case Gdk.KEY_Down:
        appsSelectDown()
        break
    }
  })
})
