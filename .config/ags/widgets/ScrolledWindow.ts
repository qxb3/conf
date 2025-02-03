import { Gtk, astalify, type ConstructProps } from 'astal/gtk4'

export type ScrolledWindowProps = ConstructProps<Gtk.ScrolledWindow, Gtk.ScrolledWindow.ConstructorProps>

const ScrolledWindow = astalify<Gtk.ScrolledWindow, Gtk.ScrolledWindow.ConstructorProps>(Gtk.ScrolledWindow, {})

export default ScrolledWindow
