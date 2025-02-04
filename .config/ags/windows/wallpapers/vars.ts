import { Variable } from 'astal'

import { revealApplauncher } from '@windows/launcher/vars'
import { revealMusic } from '@windows/music/vars'
import { revealThemes } from '@windows/themes/vars'

export const revealWallpapers = Variable(false)

revealWallpapers.subscribe(reveal => {
  if (reveal) {
    revealApplauncher.set(false)
    revealMusic.set(false)
    revealThemes.set(false)
  }
})
