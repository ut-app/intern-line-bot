class FetchWeather
  require 'open-uri'

  API_KEY = ENV['OPEN_WEATHER_API_KEY']
  BASE_URI = "https://api.openweathermap.org/data/2.5/forecast"
  
  def self.get_weather_message
    description_home = get_weather_description(zip_code: "251-0875")
    description_univ = get_weather_description(zip_code: "194-0013")

    <<~MESSAGE
      現在地の天気：
      #{description_home}

      大学付近の天気：
      #{description_univ}
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
      weather_description += WeatherResponse.new(list[index]).message
    end

    weather_description
  end
end