import { Astal } from 'astal/gtk3'
import { GLib } from 'astal'

export function isIcon(icon: string) {
  !!Astal.Icon.lookup_icon(icon)
}

export function fileExists(path: string) {
  GLib.file_test(path, GLib.FileTest.EXISTS)
}
