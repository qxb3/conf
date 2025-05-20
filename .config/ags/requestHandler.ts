import { revealLauncher } from './windows/launcher/vars'

export default function(request: string, res: (response: any) => void) {
  switch (request) {
    case 'toggle-launcher':
      revealLauncher.set(!revealLauncher.get())
      return res('toggled.')
    case 'close-launcher':
      revealLauncher.set(false)
      return res('closed.')
    case 'open-launcher':
      revealLauncher.set(true)
      return res('opened.')

    default:
      return res('unknown request.')
  }
}
