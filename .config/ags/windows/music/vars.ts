import { Variable } from 'astal'

import { revealApplauncher } from '@windows/launcher/vars'
import { revealWallpapers } from '@windows/wallpapers/vars'
import { revealThemes } from '@windows/themes/vars'

export const revealMusic = Variable(false)

revealMusic.subscribe(reveal => {
  if (reveal) {
    revealApplauncher.set(false)
    revealWallpapers.set(false)
    revealThemes.set(false)
  }
})
