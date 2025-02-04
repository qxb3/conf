import { Variable } from 'astal'

import { revealApplauncher } from '@windows/launcher/vars'
import { revealMusic } from '@windows/music/vars'
import { revealWallpapers } from '@windows/wallpapers/vars'

export const revealThemes = Variable(false)

revealThemes.subscribe(reveal => {
  if (reveal) {
    revealApplauncher.set(false)
    revealMusic.set(false)
    revealWallpapers.set(false)
  }
})
