import { Astal, Gdk, Gtk } from 'astal/gtk3'
import { execAsync } from 'astal'

import { revealAppLauncher } from '@windows/app_launcher/vars'
import { revealWallpapers } from '@windows/wallpapers/vars'
import { revealMusicPlayer } from '@windows/music_player/vars'
import { revealWeather } from '@windows/weather/vars'
import { revealControls } from '@windows/controls/vars'

function SideBar() {
  return (
    <box
      className='side_bar'
      spacing={12}
      vertical={true}>
      <box
        className='bun'
        css={`background-image: url("${SRC}/assets/bun.png")`}
        valign={Gtk.Align.START}
      />

      <box
        className='buttons'
        vertical={true}
        spacing={24}
        halign={Gtk.Align.CENTER}>
        <button
          className={
            revealAppLauncher().as(revealed =>
              revealed
                ? 'search active'
                : 'search'
            )
          }
          cursor='pointer'
          onClick={() => {
            revealAppLauncher.set(
              !revealAppLauncher.get()
            )
          }}>
          <box vertical={true}>
            <icon icon='custom-search-symbolic' />
            <label label='Apps' />
          </box>
        </button>

        <button
          className={
            revealWallpapers().as(revealed =>
              revealed
                ? 'wallpaper active'
                : 'wallpaper'
            )
          }
          cursor='pointer'
          onClick={() => {
            revealWallpapers.set(
              !revealWallpapers.get()
            )
          }}>
          <box vertical={true}>
            <icon icon='custom-wallpaper-symbolic' />
            <label label='Walls' />
          </box>
        </button>

        <button
          className={
            revealMusicPlayer().as(revealed =>
              revealed
                ? 'music active'
                : 'music'
            )
          }
          cursor='pointer'
          onClick={() => {
            revealMusicPlayer.set(
              !revealMusicPlayer.get()
            )
          }}>
          <box vertical={true}>
            <icon icon='custom-music-symbolic' />
            <label label='Music' />
          </box>
        </button>

        <button
          className={
            revealWeather().as(revealed =>
              revealed
                ? 'weather_btn active'
                : 'weather_btn'
            )
          }
          cursor='pointer'
          onClick={() => {
            revealWeather.set(
              !revealWeather.get()
            )
          }}>
          <box vertical={true}>
            <icon icon='custom-weather-symbolic' />
            <label label='Weather' />
          </box>
        </button>

        <button
          className='code'
          cursor='pointer'
          onClick={() => {
            // GUI based editor
            if (
              USER_SETTINGS.codeEditor === 'vscode' ||
              USER_SETTINGS.codeEditor === 'atom' ||
              USER_SETTINGS.codeEditor === 'sublime' ||
              USER_SETTINGS.codeEditor === 'gedit' ||
              USER_SETTINGS.codeEditor === 'kate' ||
              USER_SETTINGS.codeEditor === 'geany' ||
              USER_SETTINGS.codeEditor === 'jetbrains' ||
              USER_SETTINGS.codeEditor === 'notepadqq'
            ) {
              return execAsync(USER_SETTINGS.codeEditor)
            }

            // Terminal based code editor
            execAsync(`bash -c "${USER_SETTINGS.terminal} ${USER_SETTINGS.codeEditor} ~/"`)
          }}>
          <box vertical={true}>
            <icon icon='custom-code-symbolic' />
            <label label='Code' />
          </box>
        </button>

        <button
          className='browser'
          cursor='pointer'
          onClick={() => {
            execAsync(`bash -c "${USER_SETTINGS.browser}"`)
          }}>
          <box vertical={true}>
            <icon icon='custom-browser-symbolic' />
            <label label='Browser' />
          </box>
        </button>

        <button
          className='color_picker'
          cursor='pointer'
          onClick={() => {
            execAsync(`${HOME_DIR}/.config/hypr/scripts/color-picker.sh`)
          }}>
          <box vertical={true}>
            <icon icon='custom-color-picker-symbolic' />
            <label label='Picker' />
          </box>
        </button>


        <button
          className={
            revealControls().as(revealed =>
              revealed
                ? 'controls_btn active'
                : 'controls_btn'
            )
          }
          cursor='pointer'
          onClick={() => {
            revealControls.set(
              !revealControls.get()
            )
          }}>
          <box vertical={true}>
            <icon icon='custom-controls-symbolic' />
            <label label='Controls' />
          </box>
        </button>
      </box>
    </box>
  )
}

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <window
      namespace='astal_window_side_bar'
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.LEFT | Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM}>
      <SideBar />
    </window>
  )
}
