import Mpris from 'gi://AstalMpris'

import { Astal, Gdk, Gtk } from 'astal/gtk4'
import { bind } from 'astal'
import { revealMusic } from './vars'
import Pango from 'gi://Pango?version=1.0'

const spotify = Mpris.Player.new('spotify')

function CoverArt({ isAvailable }: { isAvailable: boolean }) {
  return (
    <image
      cssClasses={['cover_art']}
      file={
        bind(spotify, 'coverArt')
          .as(coverArt => isAvailable ? coverArt : `${SRC}/assets/pink.no_music.png`)
      }
    />
  )
}

function Meta({ isAvailable }: { isAvailable: boolean }) {
  return (
    <box
      cssClasses={['meta']}
      vertical={true}
      spacing={8}>
      <label
        cssClasses={['title']}
        label={
          bind(spotify, 'title')
            .as(title => isAvailable ? `// ${title} /` : '// null /')
        }
        maxWidthChars={24}
        ellipsize={Pango.EllipsizeMode.END}
        overflow={Gtk.Overflow.HIDDEN}
        justify={Gtk.Justification.LEFT}
        xalign={0}
      />

      <label
        cssClasses={['artist']}
        label={
          bind(spotify, 'artist')
            .as(artist => isAvailable ? `/ ${artist} //` : '/ null //')
        }
        maxWidthChars={24}
        overflow={Gtk.Overflow.HIDDEN}
        justify={Gtk.Justification.LEFT}
        xalign={0}
      />
    </box>
  )
}

function Controls() {
  return (
    <box
      cssClasses={['controls']}
      spacing={8}
      homogeneous={true}>
      <button
        cssClasses={['control', 'prev']}
        cursor={Gdk.Cursor.new_from_name('pointer', null)}
        onClicked={() => spotify.previous()}>
        <label label='<<' />
      </button>

      <button
        cssClasses={['control', 'toggle']}
        cursor={Gdk.Cursor.new_from_name('pointer', null)}
        onClicked={() => spotify.play_pause()}>
        <label
          label={
            bind(spotify, 'playbackStatus')
              .as(status => (
                status === Mpris.PlaybackStatus.STOPPED
                  ? '[]'
                  : status === Mpris.PlaybackStatus.PAUSED
                    ? '>'
                    : '\\\\'
              ))
          }
        />
      </button>

      <button
        cssClasses={['control', 'next']}
        cursor={Gdk.Cursor.new_from_name('pointer', null)}
        onClicked={() => spotify.next()}>
        <label label='>>' />
      </button>
    </box>
  )
}

function Progress() {
  return (
    <box
      cssClasses={['progress_container']}
      vexpand={true}>
      {bind(spotify, 'length').as(length => (
        <levelbar
          cssClasses={['progress']}
          maxValue={length}
          value={bind(spotify, 'position')}
          hexpand={true}
        />
      ))}
    </box>
  )
}

function Music() {
  return (
    <box
      cssName='music'>
      {bind(spotify, 'available')
        .as(isAvailable => (
          <box spacing={8}>
            <CoverArt isAvailable={isAvailable} />

            <box
              vertical={true}
              spacing={12}
              hexpand={true}>
              <Meta isAvailable={isAvailable} />
              <Controls />
              <Progress />
            </box>
          </box>
        ))
      }
    </box>
  )
}

export default function(monitor: Gdk.Monitor) {
  return (
    <window
      namespace='astal_window_music'
      gdkmonitor={monitor}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.TOP}
      exclusivity={Astal.Exclusivity.NORMAL}
      defaultWidth={1}
      defaultHeight={1}
      visible={true}>
      <revealer
        revealChild={revealMusic()}
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
        transitionDuration={200}>
        <Music />
      </revealer>
    </window>
  )
}
