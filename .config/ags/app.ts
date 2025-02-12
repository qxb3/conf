import { App } from 'astal/gtk4'

import Bar from './windows/bar/Bar';
import Launcher from './windows/launcher/Launcher';

import requestHandler from './requestHandler';
import style from './style.scss'

App.start({
  css: style,
  main() {
    App.get_monitors().forEach(monitor => {
      Bar(monitor)
      Launcher(monitor)
    })
  },
  requestHandler
})
