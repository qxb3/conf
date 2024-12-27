import { GObject, register, property } from 'astal/gobject'
import { exec, execAsync, monitorFile } from 'astal'

export interface BatteryLog {
  timestamp: Date
  battery_level: number
}

@register()
export default class BatteryLogs extends GObject.Object {
  declare private _logs: BatteryLog[]

  @property(String) declare logsPath: string

  @property(Object)
  get logs() {
    return this._logs
  }

  set logs(logs: BatteryLog[]) {
    this._logs = logs
  }

  get_logs() {
    return this.logs
  }

  constructor() {
    super()

    this.logsPath = `${HOME_DIR}/.cache/ags/battery.json`

    this._logs = this.get_logs_file()
    monitorFile(this.logsPath, () => {
      this._logs = this.get_logs_file()
      this.notify('logs')
    })
  }

  private get_logs_file() {
    const logsFile = exec(`cat ${this.logsPath}`)
    return JSON.parse(logsFile)
  }

  static get_default() {
    return new BatteryLogs()
  }
}
