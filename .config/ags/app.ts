import { App } from 'astal/gtk3'

import TopBar from './windows/top_bar/TopBar'
import SideBar from './windows/side_bar/SideBar'
import BottomSide from './windows/bottom_side/BottomSide'

import style from './style.scss'

App.start({
  css: style,
  main() {
    const monitor = App.get_monitors().at(0)!

    TopBar(monitor)
    SideBar(monitor)
    BottomSide(monitor)
  }
})
