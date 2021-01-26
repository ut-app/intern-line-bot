class WeatherResponse
  attr_accessor :res

  ABSOLUTE_TEMPERATURE = 273.freeze

  def initialize(res)
    self.res = res
  end

  def message
    "#{get_time_text(dt)}：#{get_temperature_text(feels_like)}・#{get_humidity_text(humidity)}・#{get_weather_text(weather_name)}"
  end

  private

  def dt
    @dt ||= res["dt"]
  end

  def main
    @main ||= res["main"]
  end

  def weather
    @weather ||= res["weather"][0]
  end

  def feels_like
    main["feels_like"]
  end

  def humidity
    main["humidity"]
  end

  def weather_name
    weather["main"]
  end

  def get_time_text(dt)
    jpdt_from = dt + 9 * 60 * 60
    datetime_from = Time.at(jpdt_from)
    datetime_from.strftime("%H時")
  end

  def get_temperature_text(feels_like)
    "#{format("%.2f", feels_like - ABSOLUTE_TEMPERATURE)}℃"
  end

  def get_humidity_text(humidity)
    "#{format("%02d", humidity)}％"
  end

  def get_weather_text(weather_name)
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