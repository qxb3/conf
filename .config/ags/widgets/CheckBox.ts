import { astalify, Gtk, type ConstructProps } from 'astal/gtk3'
import { GObject } from 'astal'

export default class CheckButton extends astalify(Gtk.CheckButton) {
  static { GObject.registerClass(this) }

  constructor(props: ConstructProps<CheckButton, Gtk.CheckButton.ConstructorProps>) {
    super(props as any)
  }
}
