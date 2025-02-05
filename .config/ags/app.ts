import { App } from 'astal/gtk4'
import { compileScss } from './cssHotReload'

import Bar from '@windows/bar/Bar'
import Desktop from '@windows/desktop/Desktop'
import AppLauncher from '@windows/launcher/AppLauncher'
import Music from '@windows/music/Music'
import Wallpapers from '@windows/wallpapers/Wallpapers'
import Themes from '@windows/themes/Themes'
import Calendar from '@windows/calendar/Calendar'
import Power from '@windows/power/Power'

import requestHandler from './requestHandler'

App.start({
  css: compileScss(),
  icons: `${SRC}/assets/icons`,
  main() {
    const monitor = App.get_monitors().at(0)!

    Bar(monitor)
    Desktop(monitor)
    AppLauncher(monitor)
    Music(monitor)
    Wallpapers(monitor)
    Themes(monitor)
    Calendar(monitor)
    Power(monitor)
  },
  requestHandler
})
