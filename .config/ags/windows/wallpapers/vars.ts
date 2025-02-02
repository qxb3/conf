import { Variable } from 'astal'

import { revealApplauncher } from '@windows/launcher/vars'
import { revealMusic } from '@windows/music/vars'

export const revealWallpapers = Variable(false)

revealWallpapers.subscribe(reveal => {
  if (reveal) {
    revealApplauncher.set(false)
    revealMusic.set(false)
  }
})
