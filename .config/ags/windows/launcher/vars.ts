import { Variable } from 'astal'
import { revealMusic } from '../music/vars'

export const revealApplauncher = Variable(false)

revealApplauncher.subscribe(reveal => {
  if (reveal) {
    revealMusic.set(false)
  }
})
