import Weather from '@services/Weather'
import { Astal, Gdk, Gtk } from 'astal/gtk3'

import { FloatingWindow } from '@widgets'
import { revealWeather } from './vars'
import { bind } from 'astal'

const weather = Weather.get_default()

function WeatherWin() {
  return (
    <box className='content'>
      {bind(weather, 'weather').as(weather => (
        <box
          vertical={true}
          spacing={8}>
          <box
            valign={Gtk.Align.CENTER}
            spacing={8}>
            <box spacing={8}>
              <icon
                className='weather_icon'
                icon={weather.current.icon}
                valign={Gtk.Align.CENTER}
              />

              <box className='temp_container'>
                <label
                  className='temp'
                  label={`${Math.round(weather.current.temperature)}`}
                  valign={Gtk.Align.CENTER}
                />

                <label
                  className='unit'
                  label='°C'
                  valign={Gtk.Align.START}
                />
              </box>
            </box>

            <box
              className='divider'
              hexpand={true}
            />

            <box
              className='details'
              halign={Gtk.Align.END}
              vertical={true}>
              <label
                className='title'
                label='Weather'
              />

              <label
                className='time'
                label={
                  weather.current.time.toLocaleTimeString([], {
                    hour: '2-digit',
                    minute: '2-digit'
                  })
                }
                xalign={1}
              />

              <label
                className='readable_weather'
                label={weather.current.readableWeather}
                xalign={1}
              />
            </box>
          </box>

          <box
            className='etc'
            vertical={true}>
            <label
              className='precitipation'
              label={`Precipitation: ${Math.round(weather.current.precipitation)}%`}
              xalign={0}
            />

            <label
              className='humidity'
              label={`Humidity: ${Math.round(weather.current.humidity)}%`}
              xalign={0}
            />

            <label
              className='wind_speed'
              label={`Wind: ${Math.round(weather.current.windSpeed)} km/h`}
              xalign={0}
            />
          </box>

          <box
            className='graph'
            css={`min-height: ${Math.max(...weather.hourly.map(w => (w.temperature / 100) * 250))}`}
            valign={Gtk.Align.END}
            homogeneous={true}
            spacing={4}>
            {weather.hourly.map(hourly => (
              <box
                vertical={true}
                valign={Gtk.Align.END}>
                <box
                  className='bar'
                  css={`min-height: ${Math.round((hourly.temperature / 100) * 250)}px;`}
                />
              </box>
            ))}
          </box>
        </box>
      ))}
    </box>
  )
}
export default function(gdkmonitor: Gdk.Monitor) {
  <FloatingWindow
    className='weather'
    title='Weather'
    gdkmonitor={gdkmonitor}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT}
    revealer={revealWeather}
    transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}>
    <WeatherWin />
  </FloatingWindow>
}
