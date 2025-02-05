import { Variable } from 'astal'

import { revealPower } from '@windows/power/vars'

export const revealCalendar = Variable(false)

revealCalendar.subscribe(reveal => {
  if (reveal) {
    revealPower.set(false)
  }
})
