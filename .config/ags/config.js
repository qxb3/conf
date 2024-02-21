import SideBar from './windows/sidebar/SideBar.js'
import Bar from './windows/bar/Bar.js'

export default {
  style: App.configDir + '/out.css',
  icons: `${App.configDir}/assets/svg`,
  windows: [
    SideBar,
    Bar
  ]
}
