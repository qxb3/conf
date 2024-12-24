import { exec } from 'astal'

const user = exec(`whoami`)
const homeDir = exec(`bash -c 'echo $HOME'`)
const distro = exec(`bash -c "grep ^PRETTY_NAME /etc/os-release | cut -d '=' -f 2"`)
                .replaceAll('"', '')

export interface UserSettings {
  terminal: string
  codeEditor: string
  browser: string
  animationSpeed: number,
  notifPopupTimeout: number
}

declare global {
  const USER: string
  const HOME_DIR: string
  const DISTRO: string
  const TMP: string

  const USER_SETTINGS: UserSettings

  // Debug
  const DEBUG_WIDGET: (color: string) => string
}

Object.assign(globalThis, {
  USER: user,
  HOME_DIR: homeDir,
  DISTRO: distro,
  TMP: `/tmp`,

  USER_SETTINGS: {
    terminal: 'kitty',
    codeEditor: 'nvim',
    browser: 'firefox',
    animationSpeed: 300,
    notifPopupTimeout: 5000
  },

  DEBUG_WIDGET: (color: string) => {
    return `background-color: ${color};`
  }
})
