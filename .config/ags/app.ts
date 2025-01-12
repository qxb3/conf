import { App } from 'astal/gtk4'

import AppLauncher from './windows/appLauncher/AppLauncher'
import style from './style.scss'

App.start({
  css: style,
  main() {
    const mainMonitor = App.get_monitors().at(0)!

    AppLauncher(mainMonitor)
  }
})
