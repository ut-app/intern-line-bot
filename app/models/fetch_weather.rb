class FetchWeather
  require 'open-uri'

  API_KEY = ENV['OPEN_WEATHER_API_KEY']
  BASE_URI = "https://api.openweathermap.org/data/2.5/forecast"
  
  def self.get_weather_message(zip_code:)
    description = get_weather_description(zip_code: zip_code)

    <<~MESSAGE.chomp
      #{
        zip_code == "251-0875" ? "自宅の天気：" : "大学の天気："
      }
      #{description}
    MESSAGE
  end

  def self.get_weather_description(zip_code:)
    uri = URI(BASE_URI)
    uri.query = {
      zip: "#{zip_code},jp", appid: API_KEY
    }.to_param

    hash_object = JSON.parse(open(uri).read)
    list = hash_object["list"]
    weather_description = ""

    for index in 0..5
      weather_description += "\n#{WeatherResponse.new(list[index]).message}"
    end

    weather_description
  end
end