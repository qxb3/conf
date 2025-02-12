import Mpris from 'gi://AstalMpris'

import { Gdk, Gtk } from 'astal/gtk4'
import { bind } from 'astal'

const spotify = Mpris.Player.new('spotify')

function Music() {
  return (
    <box cssName='music'>
      {bind(spotify, 'available').as(isAvailable => (
        <box
          vertical={true}
          spacing={8}>
          <image
            cssClasses={['cover_art']}
            file={bind(spotify, 'coverArt')}
          />

          <box
            cssClasses={['meta']}
            vertical={true}>
            <label
              cssClasses={['title']}
              label={
                bind(spotify, 'title')
                  .as(title => isAvailable ? title : 'No Music')
              }
            />
          </box>

          <box
            cssClasses={['controls']}
            halign={Gtk.Align.CENTER}
            spacing={32}>
            <button
              cssClasses={['prev']}
              cursor={Gdk.Cursor.new_from_name('pointer', null)}
              onClicked={() => spotify.previous()}>
              󰒮
            </button>

            <button
              cssClasses={['play_pause']}
              cursor={Gdk.Cursor.new_from_name('pointer', null)}
              onClicked={() => spotify.play_pause()}>
              {bind(spotify, 'playbackStatus').as(status => {
                switch (status) {
                  case Mpris.PlaybackStatus.STOPPED:
                    return '󰓛'
                  case Mpris.PlaybackStatus.PLAYING:
                    return '󰏤'
                  case Mpris.PlaybackStatus.PAUSED:
                    return '󰐊'
                }
              })}
            </button>

            <button
              cssClasses={['prev']}
              cursor={Gdk.Cursor.new_from_name('pointer', null)}
              onClicked={() => spotify.previous()}>
              󰒭
            </button>
          </box>
        </box>
      ))}
    </box>
  )
}

export default new Gtk.Window({
  title: 'Music Player',
  default_width: 30,
  default_height: 100,
  visible: true,
  child: Music()
})
