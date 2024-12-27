import './globals'

import { App } from 'astal/gtk3'
import { compileScss } from './cssHotReload'

import SideBar from '@windows/side_bar/SideBar'
import TopBar from '@windows/top_bar/TopBar'

import Battery from '@windows/battery/Battery'
import NotificationPopups from '@windows/notification_popups/NotificationPopups'
import NotificationCenter from '@windows/notification_center/NotificationCenter'

import AppLauncher from '@windows/app_launcher/AppLauncher'
import Calendar from '@windows/calendar/Calendar'
import Wallpapers from '@windows/wallpapers/Wallpapers'
import MusicPlayer from '@windows/music_player/MusicPlayer'
import Weather from '@windows/weather/Weather'
import Controls from '@windows/controls/Controls'

import requestHandler from './requestHandler'

App.start({
  css: compileScss(),
  icons: `${SRC}/assets/icons`,
  main() {
    const mainMonitor = App
      .get_monitors()
      .at(0)!

    SideBar(mainMonitor)
    TopBar(mainMonitor)

    // TopBar Floating Windows
    Battery(mainMonitor)
    NotificationPopups(mainMonitor)
    NotificationCenter(mainMonitor)

    // SideBar Floating Windows
    AppLauncher(mainMonitor)
    Calendar(mainMonitor)
    Wallpapers(mainMonitor)
    MusicPlayer(mainMonitor)
    Weather(mainMonitor)
    Controls(mainMonitor)
  },
  requestHandler: requestHandler
})
