import { revealDesktop } from './windows/desktop/vars'
import { revealApplauncher } from './windows/launcher/vars'
import { revealMusic } from './windows/music/vars'
import { revealPower } from './windows/power/vars'

export default function(req: string, res: (response: any) => void) {
  let args = req.split(':')

  if (args[0] === 'toggle') {
    switch (args[1]) {
      case 'desktop':
        revealDesktop.set(!revealDesktop.get())
        res(`toggled ${args[1]}`)
        break

      case 'launcher':
        revealApplauncher.set(!revealApplauncher.get())
        res(`toggled ${args[1]}`)
        break
      case 'music':
        revealMusic.set(!revealMusic.get())
        res(`toggled: ${args[1]}`)
        break

      case 'power':
        revealPower.set(!revealPower.get())
        res(`toggled: ${args[1]}`)
        break
      default:
        res(`unknown window: ${args[1]}`)
        break
    }
  }

  res(`unknown command: ${args[0]}`)
}
