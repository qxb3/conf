import { App } from 'astal/gtk4'

import Bar from '@windows/bar/Bar'
import Desktop from '@windows/desktop/Desktop'
import AppLauncher from '@windows/launcher/AppLauncher'
import Music from '@windows/music/Music'
import Wallpapers from '@windows/wallpapers/Wallpapers'
import Power from '@windows/power/Power'

import style from './style.scss'
import requestHandler from './requestHandler'

App.start({
  css: style,
  icons: `${SRC}/assets/icons`,
  main() {
    const monitor = App.get_monitors().at(0)!

    Bar(monitor)
    Desktop(monitor)
    AppLauncher(monitor)
    Music(monitor)
    Wallpapers(monitor)
    Power(monitor)
  },
  requestHandler
})
