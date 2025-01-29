import { App, Astal } from 'astal/gtk4'

import WindowBorder from './windows/window_border/WindowBorder'
import Bottom from './windows/bottom/Bottom'

import style from './style.scss'

App.start({
  css: style,
  main() {
    const mainMonitor = App.get_monitors().at(0)!

    // Full window borders
    WindowBorder(mainMonitor, Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT)
    WindowBorder(mainMonitor, Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT)
    WindowBorder(mainMonitor, Astal.WindowAnchor.LEFT | Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM)
    WindowBorder(mainMonitor, Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM)

    Bottom(mainMonitor)
  }
})
