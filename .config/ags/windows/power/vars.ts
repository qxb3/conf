import { revealCalendar } from '@windows/calendar/vars'
import { Variable } from 'astal'

export const revealPower = Variable(false)

revealPower.subscribe(reveal => {
  if (reveal) {
    revealCalendar.set(false)
  }
})
