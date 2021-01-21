class FetchWeather
  require 'open-uri'
  require 'kconv'
  require 'rexml/document'

  API_KEY = ENV["OPEN_WEATHER_API_KEY"]
  URL = "https://api.openweathermap.org/data/2.5/forecast?zip=251-0875,jp&appid=" + API_KEY + "&mode=xml"
  
  def self.get_weather_info
    xml = open(URL).read.toutf8
    doc = REXML::Document.new(xml)
    xpath = 'weatherdata/forecast/time[1]/'
    nowWearther = doc.elements[xpath + 'symbol'].attributes['name']
    weatherText = "取得できません"

    case nowWearther
    when "clear sky" || "few clouds" then
      weatherText = "現在地の天気は晴れです"
    when "scattered clouds" || "broken clouds" || "overcast clouds" then
      weatherText = "現在地の天気はくもりです"
    when "rain" || "thunderstorm" || "drizzle" then
      weatherText = "現在地の天気は雨です"
    when "snow" then
      weatherText = "現在地の天気は雪です"
    when "fog" || "mist" || "Haze" then
      weatherText = "現在地の天気は霧です"
    end

    return weatherText
  end

end