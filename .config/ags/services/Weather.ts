import { interval } from 'astal'
import { GObject, property, register } from 'astal/gobject'
import { fetch } from '@utils/fetch'

@register()
export default class Weather extends GObject.Object {
  declare private WEATHER_API_URL: string

  @property(Object) declare location: Location
  @property(Object) declare weather: WeatherData
  @property(Object) declare status: 'fetching' | 'fetched'

  public get_location() {
    if (this.location)
      return this.location
  }

  public get_weather() {
    if (this.weather)
      return this.weather
  }

  private async _get_location() {
    try {
      const locationResponse = await fetch('http://ip-api.com/json', { method: 'GET' })
      const location: LocationResponse = await locationResponse.json()

      if (location.status === 'fail')
        throw Error('Failed to fetch location')

      if (location.status === 'success') {
        this.location = {
          country: location.country,
          regionName: location.regionName,
          city: location.city,
          timezone: location.timezone,
          latitude: location.lat,
          longitude: location.lon
        }
      }
    } catch(err) {
      console.log(`Error while fetching location: ${err}`)
    }
  }

  private async _get_weather() {
    this.status = 'fetching'
    await this._get_location()

    try {
      const weatherResponse = await fetch(`https://api.open-meteo.com/v1/forecast?latitude=${this.location.latitude}&longitude=${this.location.longitude}&current=temperature_2m,relative_humidity_2m,precipitation,weather_code,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,wind_speed_80m&timeformat=unixtime&timezone=auto&forecast_days=1`, { method: 'GET' })
      const weather: WeatherResponse = await weatherResponse.json()

      this.weather = {
        current: {
          time: new Date(weather.current.time * 1000),
          temperature: weather.current.temperature_2m,
          humidity: weather.current.relative_humidity_2m,
          precipitation: weather.current.precipitation,
          readableWeather: this._get_readable_weather(weather.current.weather_code),
          weatherCode: weather.current.weather_code,
          windSpeed: weather.current.wind_speed_10m,
          icon: this._get_icon(weather.current.weather_code)
        },
        hourly: weather.hourly.time.map((time, i) => ({
          time: new Date(time * 1000),
          temperature: weather.hourly.temperature_2m[i],
          humidity: weather.hourly.relative_humidity_2m[i],
          weatherCode: weather.hourly.weather_code[i],
          windSpeed: weather.hourly.wind_speed_80m[i],
          readableWeather: this._get_readable_weather(weather.hourly.weather_code[i]),
          icon: this._get_icon(weather.hourly.weather_code[i])
        }))
      }

      this.status = 'fetched'
    } catch(err) {
      console.log(`Error while fetching weather: ${err}`)
    }
  }

  private _get_icon(weatherCode: WeatherCode) {
    switch (weatherCode) {
      case WeatherCode.CLEAR_SKY:
        return 'weather-clear-symbolic'
      case WeatherCode.CLOUDY:
        return 'weather-few-clouds-symbolic'
      case WeatherCode.FOGGY:
        return 'weather-fog-symbolic'
      case WeatherCode.DRIZZLE | WeatherCode.FREEZING_DRIZZLE:
        return 'weather-showers-scattered-symbolic'
      case WeatherCode.RAIN | WeatherCode.RAIN_SHOWERS | WeatherCode.FREEZING_RAIN:
        return 'weather-showers-symbolic'
      case WeatherCode.SNOW | WeatherCode.SNOW_GRAINS | WeatherCode.SNOW_SHOWERS:
        return 'weather-snow-symbolic'
      case WeatherCode.THUNDERSTORM | WeatherCode.THUNDERSTORM_HEAVY_HAIL:
        return 'weather-storm-symbolic'
      case WeatherCode.DEFAULT:
      default:
        return 'weather-overcast-symbolic'
    }
  }

  private _get_readable_weather(weatherCode: WeatherCode) {
    switch (weatherCode) {
      case WeatherCode.CLEAR_SKY:
        return 'Clear Sky'
      case WeatherCode.CLOUDY:
        return 'Cloudy'
      case WeatherCode.FOGGY:
        return 'Foggy'
      case WeatherCode.DRIZZLE | WeatherCode.FREEZING_DRIZZLE:
        return 'Drizzle'
      case WeatherCode.RAIN | WeatherCode.RAIN_SHOWERS | WeatherCode.FREEZING_RAIN:
        return 'Rain'
      case WeatherCode.SNOW | WeatherCode.SNOW_GRAINS | WeatherCode.SNOW_SHOWERS:
        return 'Snow'
      case WeatherCode.THUNDERSTORM | WeatherCode.THUNDERSTORM_HEAVY_HAIL:
        return 'Thunderstorm'
      case WeatherCode.DEFAULT:
      default:
        return 'N/A'
    }
  }

  constructor() {
    super()

    // Default values

    this.location = {
      country: 'N/A',
      regionName: 'N/A',
      city: 'N/A',
      timezone: 'N/A',
      latitude: 0,
      longitude: 0
    }

    this.weather = {
      current: {
        time: new Date(),
        temperature: 0,
        humidity: 0,
        precipitation: 0,
        weatherCode: 0,
        windSpeed: 0,
        readableWeather: this._get_readable_weather(WeatherCode.DEFAULT),
        icon: this._get_icon(WeatherCode.DEFAULT)
      },
      hourly: Array.from({ length: 24 }).map(() => ({
        time: new Date(),
        temperature: 1,
        humidity: 0,
        weatherCode: 0,
        windSpeed: 0,
        readableWeather: this._get_readable_weather(WeatherCode.DEFAULT),
        icon: this._get_icon(WeatherCode.DEFAULT)
      }))
    }

    this._get_weather()
    interval(600000, () => {
      this._get_weather()
    })
  }

  static get_default() {
    return new Weather()
  }
}

export type Location = {
  country: string
  regionName: string
  city: string
  timezone: string
  latitude: number
  longitude: number
}

type LocationResponse = {
  status: 'success' | 'fail'
  country: string
  countryCode: string
  region: string
  regionName: string
  city: string
  zip: string
  lat: number
  lon: number
  timezone: string
  isp: string
  org: string
  as: string
  query: string
}

export type WeatherData = {
  current: {
    time: Date
    temperature: number
    humidity: number
    precipitation: number
    readableWeather: string
    weatherCode: number
    windSpeed: number
    icon: string
  }
  hourly: {
    time: Date
    temperature: number
    humidity: number
    readableWeather: string
    weatherCode: number
    windSpeed: number
    icon: string
  }[]
}

type WeatherResponse = {
  latitude: number
  longitude: number
  generationtime_ms: number
  utc_offset_seconds: number
  timezone: string
  timezone_abbreviation: string
  elevation: number
  current_units: {
    time: string
    interval: string
    temperature_2m: string
    relative_humidity_2m: string
    precipitation: string
    weather_code: string
    wind_speed_10m: string
  }
  current: {
    time: number
    interval: number
    temperature_2m: number
    relative_humidity_2m: number
    precipitation: number
    weather_code: number
    wind_speed_10m: number
  }
  hourly_units: {
    time: string
    temperature_2m: string
    relative_humidity_2m: string
    apparent_temperature: string
    weather_code: string
    wind_speed_80m: string
  }
  hourly: {
    time: number[]
    temperature_2m: number[]
    relative_humidity_2m: number[]
    apparent_temperature: number[]
    weather_code: number[]
    wind_speed_80m: number[]
  }
}

export enum WeatherCode {
  DEFAULT                   = -1,
  CLEAR_SKY                 = 0,
  CLOUDY                    = 1  | 2 | 3,
  FOGGY                     = 45 | 48,
  DRIZZLE                   = 51 | 53 | 55,
  FREEZING_DRIZZLE          = 56 | 57,
  RAIN                      = 61 | 63 | 65,
  FREEZING_RAIN             = 66 | 67,
  SNOW                      = 71 | 73 | 75,
  SNOW_GRAINS               = 77,
  RAIN_SHOWERS              = 80 | 81 | 82,
  SNOW_SHOWERS              = 85 | 86,
  THUNDERSTORM              = 95,
  THUNDERSTORM_HEAVY_HAIL   = 96 | 99,
}
