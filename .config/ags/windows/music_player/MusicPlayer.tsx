import Mpris from 'gi://AstalMpris'
import { Astal, Gdk, Gtk } from 'astal/gtk3'

import { FloatingWindow, ProgressBar } from '@widgets'
import { revealMusicPlayer } from './vars'
import { bind } from 'astal'

const spotify = Mpris.Player.new('spotify')

function CoverArt() {
  return (
    <box>
      {bind(spotify, 'available').as(isAvailable => (
        <box
          className='cover_art'
          halign={Gtk.Align.CENTER}
          css={
            bind(spotify, 'coverArt')
            .as(coverArt =>
              isAvailable
                ? `background-image: url("${coverArt}");`
                : `background-image: url("${SRC}/assets/no_music.png");`
            )
          }
        />
      ))}
    </box>
  )
}

function Meta() {
  return (
    <box>
      {bind(spotify, 'available').as(isAvailable => (
        <box
          className='meta'
          vertical={true}>
          <label
            className='title'
            label={
              bind(spotify, 'title')
                .as(title => isAvailable ? title : 'No Music')
            }
            maxWidthChars={18}
            hexpand={true}
            truncate={true}
          />

          <label
            className='artist'
            label={
              bind(spotify, 'artist')
                .as(aritst => isAvailable ? aritst : 'Artist')
            }
            maxWidthChars={18}
            hexpand={true}
            truncate={true}
          />
        </box>
      ))}
    </box>
  )
}

function Controls() {
  return (
    <box
      className='controls'
      homogeneous={true}>
      <button
        className='prev'
        cursor='pointer'
        onClick={() => {
          spotify.previous()
        }}>
        <icon
          className='icon'
          icon='media-skip-backward-symbolic'
        />
      </button>

      <button
        className='prev'
        cursor='pointer'
        onClick={() => {
          spotify.play_pause()
        }}>
        <icon
          className='icon'
          icon={
            bind(spotify, 'playbackStatus')
              .as(status =>
                status === Mpris.PlaybackStatus.STOPPED
                  ? 'media-playback-stop-symbolic'
                  : status === Mpris.PlaybackStatus.PLAYING
                    ? 'media-playback-pause-symbolic'
                    : 'media-playback-start-symbolic'
              )
          }
        />
      </button>

      <button
        className='prev'
        cursor='pointer'
        onClick={() => {
          spotify.next()
        }}>
        <icon
          className='icon'
          icon='media-skip-forward-symbolic'
        />
      </button>
    </box>
  )
}

function Position() {
  return (
    <box
      className='position'
      valign={Gtk.Align.CENTER}
      spacing={8}
      vertical={true}>
      {bind(spotify, 'length').as(length => (
        <ProgressBar
          className='progress'
          fraction={
            bind(spotify, 'position')
            .as(position => position / length)
          }
          valign={Gtk.Align.CENTER}
          hexpand={true}
        />
      ))}

      {bind(spotify, 'available').as(isAvailable => (
        <box className='meta'>
          <label
            className='current_progress'
            label={
              bind(spotify, 'position')
              .as(position =>
                !isAvailable || position <= 0
                  ? '0:00'
                  : `${Math.floor(position / 60)}:${String(Math.round(position) % 60).padStart(2, '0')}`
              )
            }
          />

          <box
            className='seperator'
            valign={Gtk.Align.CENTER}
            hexpand={true}
          />

          <label
            className='current_progress'
            label={
              bind(spotify, 'length')
                .as(length =>
                  !isAvailable
                    ? '0:00'
                    : `${Math.floor(length / 60)}:${String(Math.round(length) % 60).padStart(2, '0')}`
                )
            }
          />
        </box>
      ))}
    </box>
  )
}

function MusicPlayer() {
  return (
    <box
      className='content'
      vertical={true}
      spacing={12}>
      <CoverArt />
      <Meta />
      <Controls />
      <Position />
    </box>
  )
}

export default function(gdkmonitor: Gdk.Monitor) {
  return (
    <FloatingWindow
      className='music_player'
      title='Spotify'
      gdkmonitor={gdkmonitor}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT}
      revealer={revealMusicPlayer}
      transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}>
      <MusicPlayer />
    </FloatingWindow>
  )
}
