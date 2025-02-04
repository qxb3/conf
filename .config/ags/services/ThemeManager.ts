import { exec, execAsync, monitorFile, readFile } from 'astal'
import GObject, { GLib, property, register } from 'astal/gobject'

export enum Themes {
  PINK,
  GREEN
}

export interface Theme {
  name: string
}

@register()
export default class ThemeManager extends GObject.Object {
  declare private _currentTheme: Themes

  @property(String) declare path: string

  constructor() {
    super()

    this.path = `${GLib.get_user_state_dir()}/retro`
    this._currentTheme = this.readTheme()

    monitorFile(`${this.path}/theme_changed`, () => {
      this._currentTheme = this.readTheme()
      this.emit('changed')
      this.notify('changed')
    })
  }

  @property(Object)
  get currentTheme() {
    return this._currentTheme
  }

  set currentTheme(theme: Themes) {
    exec(`bash -c "${SRC}/themes/sync.sh ${this.toString(theme)}"`)
    execAsync(`notify-send -a 'retro' 'Themes' 'Successfuly changed the theme to ${this.currentTheme.toString().toLowerCase()}. Restart the session to update the gtk theme.'`)

    this._currentTheme = theme
  }

  get_theme() {
    return this.currentTheme
  }

  set_theme(theme: Themes) {
    this.currentTheme = theme
  }

  toString(theme: Themes) {
    switch (theme) {
      case Themes.PINK:
        return 'pink'
      case Themes.GREEN:
        return 'green'
    }
  }

  fromString(theme: string): Themes {
    switch (theme) {
      case 'pink':
        return Themes.PINK
      case 'green':
        return Themes.GREEN
    }

    throw Error('ThemeManager: unknown theme')
  }

  private readTheme(): Themes {
    const file = readFile(`${this.path}/theme_name`).trim()
    return this.fromString(file)
  }

  static get_default() {
    return new ThemeManager()
  }
}
