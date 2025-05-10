import { exec } from 'astal'

const user = exec(`whoami`)
const homeDir = exec(`bash -c 'echo $HOME'`)

declare global {
  const USER: string
  const HOME_DIR: string
  const LOCAL_STATE: string
  const TMP: string

  const ANIMATION_SPEED: number
}

Object.assign(globalThis, {
  USER: user,
  HOME_DIR: homeDir,
  LOCAL_STATE: `${homeDir}/.local/state/theme`,
  TMP: `/tmp`,

  ANIMATION_SPEED: 250
})
