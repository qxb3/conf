import { App } from 'astal/gtk4'

import Bar from './windows/bar/Bar'
import style from './style.scss'

App.start({
  css: style,
  icons: `${SRC}/assets/icons`,
  main() {
    const monitor = App.get_monitors().at(0)!

    Bar(monitor)
  }
})
