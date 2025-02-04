import { Variable } from 'astal'

import { revealMusic } from '@windows/music/vars'
import { revealWallpapers } from '@windows/wallpapers/vars'
import { revealThemes } from '@windows/themes/vars'

export const revealApplauncher = Variable(false)

revealApplauncher.subscribe(reveal => {
  if (reveal) {
    revealMusic.set(false)
    revealWallpapers.set(false)
    revealThemes.set(false)
  }
})
