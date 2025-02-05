import { FlowBox } from '@widgets'

import { Gdk, Gtk } from 'astal/gtk4'
import { Variable } from 'astal'
import { revealCalendar } from '@windows/calendar/vars'

export default function Calendar() {
  const currentDate = new Date()

  const pageDate = Variable(currentDate)
  const grid = Variable(
    generateGridDates(
      currentDate.getMonth() + 1,
      currentDate.getFullYear()
    )
  )

  pageDate.subscribe(pageDate => {
    grid.set(
      generateGridDates(
        pageDate.getMonth() + 1,
        pageDate.getFullYear()
      )
    )
  })

  revealCalendar.subscribe(reveal => {
    if (!reveal) {
      pageDate.set(currentDate)
    }
  })

  return (
    <box
      cssClasses={['calendar_widget']}
      vertical={true}
      spacing={8}
      onDestroy={() => {
        pageDate.drop()
        grid.drop()
      }}>
      <box hexpand={true}>
        <label
          cssClasses={['month_year']}
          label={
            pageDate(date =>
              `${date.toLocaleDateString('en-US', { month: 'long', year: 'numeric' })}`
            )
          }
        />

        <box
          spacing={16}
          hexpand={true}
          halign={Gtk.Align.END}>
          <button
            cssClasses={['control']}
            cursor={Gdk.Cursor.new_from_name('pointer', null)}
            onClicked={() => {
              const prevDate = new Date(pageDate.get())
              prevDate.setMonth(prevDate.getMonth() - 1)

              pageDate.set(prevDate)
            }}>
            <label label='<' />
          </button>

          <button
            cssClasses={['control']}
            cursor={Gdk.Cursor.new_from_name('pointer', null)}
            onClicked={() => {
              const nextDate = new Date(pageDate.get())
              nextDate.setMonth(nextDate.getMonth() + 1)

              pageDate.set(nextDate)
            }}>
            <label label='>' />
          </button>
        </box>
      </box>

      <box
        spacing={8}
        hexpand={true}
        vexpand={true}
        homogeneous={true}>
        {['Mon', 'Thu', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map(day =>
          <label
            cssClasses={['day_name']}
            label={day}
          />
        )}
      </box>

      <box cssClasses={['divider']} />

      <FlowBox
        maxChildrenPerLine={7}
        columnSpacing={8}
        rowSpacing={8}
        homogeneous={true}
        hexpand={true}>
        {grid(grid =>
          grid.map(weeks =>
            weeks.map(day =>
              <label
                cssClasses={
                  !day.inCurrent
                    ? day.date.getFullYear() === currentDate.getFullYear() &&
                      day.date.getMonth() === currentDate.getMonth() &&
                      day.date.getDate() === currentDate.getDate()
                        ? ['today', 'not_incurrent', 'day']
                        : ['not_incurrent', 'day']
                    : day.date.getFullYear() === currentDate.getFullYear() &&
                      day.date.getMonth() === currentDate.getMonth() &&
                      day.date.getDate() === currentDate.getDate()
                        ? ['today', 'day']
                        : ['day']
                }
                label={day.date.getDate().toString()}
              />
            )
          )
        )}
      </FlowBox>
    </box>
  )
}

function generateGridDates(month: number, year: number) {
  function daysInMonth(month: number, year: number): Date[] {
    const days = []
    const lastDay = new Date(year, month, 0).getDate()

    for (let i = 1; i <= lastDay; i++) {
      days.push(new Date(year, month - 1, i))
    }

    return days
  }

  const firstDayOfMonth = new Date(year, month - 1, 1)
  const lastDayOfMonth = new Date(year, month, 0)

  const weekStart = 1
  const daysOfWeek = 7

  const firstWeekDay = (firstDayOfMonth.getDay() - weekStart + daysOfWeek) % daysOfWeek
  const lastWeekDay = (lastDayOfMonth.getDay() - weekStart + daysOfWeek) % daysOfWeek

  const prevMonth = (month - 1) > 0 ? month - 1 : 12
  const nextMonth = (month + 1) <= 12 ? month + 1 : 1
  const prevYear = (month - 1) > 0 ? year : year - 1
  const nextYear = (month + 1) <= 12 ? year : year + 1

  const prevMonthDays = daysInMonth(prevMonth, prevYear)
  const nextMonthDays = daysInMonth(nextMonth, nextYear)

  const leadingDays = firstWeekDay
  const trailingDays = (daysOfWeek - 1 - lastWeekDay)

  const days = []

  if (leadingDays > 0) {
    days.push(
      ...prevMonthDays.slice(-leadingDays)
        .map(date => ({ inCurrent: false, date }))
    )
  }

  days.push(
    ...daysInMonth(month, year)
      .map(date => ({ inCurrent: true, date }))
  )

  if (trailingDays > 0) {
    days.push(
      ...nextMonthDays.slice(0, trailingDays)
        .map(date => ({ inCurrent: false, date }))
    )
  }

  while (days.length < 6 * daysOfWeek) {
    if (days.length < 3 * daysOfWeek) {
      days.unshift(
        ...prevMonthDays.slice(-(6 * daysOfWeek - days.length))
          .map(date => ({ inCurrent: false, date }))
      )
    } else {
      days.push(
        ...nextMonthDays.slice(0, 6 * daysOfWeek - days.length)
          .map(date => ({ inCurrent: false, date }))
      )
    }
  }

  const weeks = []
  for (let i = 0; i < days.length; i += daysOfWeek) {
    weeks.push(days.slice(i, i + daysOfWeek))
  }

  return weeks
}
