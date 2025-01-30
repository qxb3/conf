import { revealMusic } from "./windows/music/vars"

export default function(req: string, res: (response: any) => void) {
  let args = req.split(':')

  if (args[0] === 'toggle') {
    switch (args[1]) {
      case 'music':
        revealMusic.set(!revealMusic.get())
        res(`toggled: ${args[1]}`)
        break
      default:
        res(`unknown window: ${args[1]}`)
        break
    }
  }

  res(`unknown command: ${args[0]}`)
}
