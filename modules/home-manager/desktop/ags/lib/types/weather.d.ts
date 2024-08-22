export type Weather = {
  location: Location;
  current: Current;
  forecast: Forecast;
}

export type Current = {
  last_updated_epoch?: number;
  last_updated?: string;
  temp: number;
  is_day: number;
  condition: Condition;
  wind: number;
  wind_degree: number;
  wind_dir: string;
  pressure: number;
  pecip: number;
  humidity: number;
  cloud: number;
  feelslike: number;
  windchill: number;
  heatindex: number;
  dewpoint: number;
  vis: number;
  uv: number;
  gust: number;
  time_epoch?: number;
  time?: string,
  snow?: number;
  will_it_rain?: number;
  chance_of_rain?: number;
  will_it_snow?: number;
  chance_of_snow?: number;
}

export type Condition = {
  text: string;
  icon: string;
  code: number;
}

export type Forecast = {
  forecast: Forecastday[];
}

export type Forecastday = {
  date: string;
  date_epoch: number;
  day: Day;
  astro: Astro;
  hour: Current[];
}

export type Astro = {
  sunrise: string;
  sunset: string;
  moonrise: string;
  moonset: string;
  moon_phase: string;
  moon_illumination: number;
  is_moon_up: number;
  is_sun_up: number;
}

export type Day = {
  maxtemp: number;
  mintemp: number;
  avgtemp: number;
  maxwind: number;
  totalprecip: number;
  totalsnow: number;
  avgvis: number;
  avghumidity: number;
  daily_will_it_rain: number;
  daily_chance_of_rain: number;
  daily_will_it_snow: number;
  daily_chance_of_snow: number;
  condition: Condition;
  uv: number;
}

export type Location = {
  name: string;
  region: string;
  country: string;
  lat: number;
  lon: number;
  tz_id: string;
  localtime_epoch: number;
  localtime: string;
}
