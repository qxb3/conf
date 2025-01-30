import { Variable } from 'astal'
import { revealApplauncher } from '../launcher/vars'

export const revealMusic = Variable(false)

revealMusic.subscribe(reveal => {
  if (reveal) {
    revealApplauncher.set(false)
  }
})
