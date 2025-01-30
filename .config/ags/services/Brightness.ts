import { GObject, register, property } from 'astal/gobject'
import { exec, execAsync, monitorFile } from 'astal'

@register()
export default class Brightness extends GObject.Object {
  declare private _brightness: number

  @property(String) declare interface: string
  @property(String) declare interfacePath: string
  @property(Number) declare maxBrightness: number

  @property(Number)
  get brightness() {
    return this._brightness
  }

  set brightness(value: number) {
    value = Math.max(0, Math.min(value, 1))
    execAsync(`brightnessctl set ${value * 100}% -q`)
  }

  get_brightness() {
    return this.brightness
  }

  set_brightness(value: number) {
    this.brightness = value
  }

  constructor() {
    super()

    this.interface = exec(`sh -c 'ls -w1 /sys/class/backlight | head -1'`).trim()
    this.interfacePath =  `/sys/class/backlight/${this.interface}/brightness`
    this.maxBrightness = Number(exec(`brightnessctl max`))
    this._brightness = Number(exec(`brightnessctl get`)) / this.maxBrightness

    monitorFile(this.interfacePath, () => {
      this._brightness = Number(exec(`brightnessctl get`)) / this.maxBrightness
      this.notify('brightness')
    })
  }

  static get_default() {
    return new Brightness()
  }
}
