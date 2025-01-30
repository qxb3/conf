import { App } from 'astal/gtk4'

import Bar from './windows/bar/Bar'
import Music from './windows/music/Music'

import style from './style.scss'
import requestHandler from './requestHandler'

App.start({
  css: style,
  icons: `${SRC}/assets/icons`,
  main() {
    const monitor = App.get_monitors().at(0)!

    Bar(monitor)
    Music(monitor)
  },
  requestHandler
})
