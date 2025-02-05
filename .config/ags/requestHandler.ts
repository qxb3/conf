import { revealDesktop } from '@windows/desktop/vars'
import { revealApplauncher } from '@windows/launcher/vars'
import { revealMusic } from '@windows/music/vars'
import { revealPower } from '@windows/power/vars'
import { revealThemes } from '@windows/themes/vars'
import { revealWallpapers } from '@windows/wallpapers/vars'

export default function(req: string, res: (response: any) => void) {
  let args = req.split(':')

  if (args[0] === 'toggle') {
    switch (args[1]) {
      case 'desktop':
        revealDesktop.set(!revealDesktop.get())
        return res(`toggled ${args[1]}`)

      case 'launcher':
        revealApplauncher.set(!revealApplauncher.get())
        return res(`toggled ${args[1]}`)
      case 'music':
        revealMusic.set(!revealMusic.get())
        return res(`toggled: ${args[1]}`)
      case 'wallpapers':
        revealWallpapers.set(!revealWallpapers.get())
        return res(`toggled: ${args[1]}`)
      case 'themes':
        revealThemes.set(!revealThemes.get())
        return res(`toggled: ${args[1]}`)

      case 'power':
        revealPower.set(!revealPower.get())
        return res(`toggled: ${args[1]}`)
      default:
        return res(`unknown window: ${args[1]}`)
    }
  }

  return res(`unknown command: ${args[0]}`)
}
