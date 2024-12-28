import { Astal, Gdk, Gtk } from 'astal/gtk3'
import { Binding, Variable } from 'astal'

export default function FloatingWindow(props: {
  className: string | Binding<string>,
  title: string | Binding<string>,
  gdkmonitor: Gdk.Monitor,
  anchor: Astal.WindowAnchor | Binding<Astal.WindowAnchor>,
  revealer: Variable<boolean>,
  transitionType: Gtk.RevealerTransitionType,
  keymode?: Astal.Keymode | Binding<Astal.Keymode | undefined> | undefined,
  onKeyPressEvent?: ((self: Gtk.Window, event: Gdk.Event) => unknown) | undefined,
  child?: JSX.Element | Binding<JSX.Element> | Binding<Array<JSX.Element>>
  children?: Array<JSX.Element> | Binding<Array<JSX.Element>>
}) {
  const {
    className,
    title,
    gdkmonitor,
    anchor,
    transitionType,
    revealer,
    keymode,
    onKeyPressEvent,
    child,
    children
  } = props

  return (
    <window
      namespace='astal_window_floating'
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.NORMAL}
      layer={Astal.Layer.TOP}
      anchor={anchor}
      keymode={keymode}
      onKeyPressEvent={onKeyPressEvent}>
      <revealer
        revealChild={revealer()}
        transitionType={transitionType}
        transitionDuration={USER_SETTINGS.animationSpeed}>
        <box
          className={`floating_window ${className}`}
          vertical={true}>
          <box className='title_bar'>
            <overlay>
              <label
                className='title'
                label={title}
                hexpand={true}
              />

              <box
                className='buttons'
                spacing={8}
                halign={Gtk.Align.END}
                valign={Gtk.Align.CENTER}
                hexpand={true}>
                {Array.from({ length: 3 }).map(() => (
                  <button
                    className='button'
                    cursor='pointer'
                    onClick={() => {
                      revealer.set(
                        !revealer.get()
                      )
                    }}>
                  </button>
                ))}
            </box>
            </overlay>
          </box>

          {child ?? children}
        </box>
      </revealer>
    </window>
  )
}
