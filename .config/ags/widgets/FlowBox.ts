import { Gtk, astalify, type ConstructProps } from 'astal/gtk4'

export type FlowBoxProps = ConstructProps<Gtk.FlowBox, Gtk.FlowBox.ConstructorProps>

const FlowBox = astalify<Gtk.FlowBox, Gtk.FlowBox.ConstructorProps>(Gtk.FlowBox, {})

export default FlowBox
