class FetchWeather
  require 'open-uri'
  require 'kconv'
  require "json"
  require 'date'

  API_KEY = ENV['OPEN_WEATHER_API_KEY']
  BASE_URL = "https://api.openweathermap.org/data/2.5/forecast?zip="
  
  def self.get_weather_message
    description_home = get_weather_description("251-0875")
    description_univ = get_weather_description("194-0013")

    "現在地の天気は#{description_home}\n\n大学付近の天気は#{description_univ}"
  end

  def self.get_weather_description(zip_code)
    url = BASE_URL + zip_code + ",jp&appid=" + API_KEY
    hash_object = JSON.parse(open(url).read)

    weather_description = ""
    list = hash_object["list"]

    for index in 0..5
      info = list[index]
      dt = info["dt"]
      main = info["main"]
      feels_like = main["feels_like"]
      weather = info["weather"][0]
      weather_name = weather["main"]
      
      weather_description += "\n#{get_time_text(dt)}・#{get_temperature_text(feels_like)}・#{get_weather_text(weather_name)}"
    end

    # puts weather_description
    weather_description
  end

  def self.get_time_text(dt)
    jpdt_from = dt
    datetime_from = Time.at(jpdt_from).to_datetime
    hour_from = datetime_from.hour

    jpdt_to = dt + 3 * 60 * 60
    datetime_to = Time.at(jpdt_to).to_datetime
    hour_to = datetime_to.hour

    "#{format("%02d", hour_from)}時-#{format("%02d", hour_to)}時"
  end

  def self.get_temperature_text(feels_like)
    "#{format("%.2f", feels_like - 273)}℃"
  end

  def self.get_weather_text(weather_name)
    case weather_name
    when "Clear"
      "晴れ"
    when "Clouds"
      "くもり"
    when "Rain" || "Squall"
      "雨"
    when "Snow"
      "雪"
    when "Mist" || "Smoke" || "Haze" || "Dust" || "Fog" || "Sand" || "Ash"
      "霧"
    when "Drizzle"
      "霧雨"
    when "Thunderstorm"
      "雷雨"
    when "Tornado"
      "竜巻"
    else
      "取得失敗"
    end
  end
end