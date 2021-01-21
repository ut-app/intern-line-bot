class FetchWeather
  require 'open-uri'
  require 'kconv'
  require 'rexml/document'

  API_KEY = ENV['OPEN_WEATHER_API_KEY']
  BASE_URL = "https://api.openweathermap.org/data/2.5/forecast?zip="
  
  def self.get_weather_message
    description_home = get_weather_description("251-0875")
    description_univ = get_weather_description("194-0013")

    "現在地の天気は#{description_home}\n大学付近の天気は#{description_univ}"
  end

  def self.get_weather_description(zip_code)
    url = BASE_URL + zip_code + ",jp&appid=" + API_KEY + "&mode=xml"
    xml = open(url).read.toutf8
    doc = REXML::Document.new(xml)
    xpath = 'weatherdata/forecast/time[1]/'
    weather_name = doc.elements[xpath + 'symbol'].attributes['name']

    case weather_name
    when "clear sky" || "few clouds"
      "晴れです。"
    when "scattered clouds" || "broken clouds" || "overcast clouds"
      "くもりです。"
    when "rain" || "thunderstorm" || "drizzle"
      "雨です。"
    when "snow"
      "雪です。"
    when "fog" || "mist" || "Haze"
      "霧です。"
    else
      "取得できません。"
    end
  end

end