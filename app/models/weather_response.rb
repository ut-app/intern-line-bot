class WeatherResponse
  attr_accessor :res

  ABSOLUTE_TEMPERATURE = 273.freeze

  def initialize(res)
    self.res = res
  end

  def message
    feels_like = main["feels_like"]
    weather_name = weather["main"]
    text = "\n#{get_time_text(dt)}・#{get_temperature_text(feels_like)}・#{get_weather_text(weather_name)}"
  end

  private

  def dt
    res["dt"]
  end

  def main
    res["main"]
  end

  def weather
    res["weather"][0]
  end

  def get_time_text(dt)
    jpdt_from = dt
    datetime_from = Time.at(jpdt_from)

    # APIの仕様として3時間おきの天気を表示しているため、
    # 開始時刻を表すdtに3を足している
    jpdt_to = jpdt_from + 3 * 60 * 60
    datetime_to = Time.at(jpdt_to)

    "#{datetime_from.strftime("%H時")}-#{datetime_to.strftime("%H時")}"
  end

  def get_temperature_text(feels_like)
    "#{format("%.2f", feels_like - ABSOLUTE_TEMPERATURE)}℃"
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