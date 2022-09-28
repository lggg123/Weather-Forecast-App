# app/services/weather_service.rb
# frozen_string_literal: true

require 'net/http'
require 'json'

# Service to get curent temperature from openweathermap.org api
class WeatherService
  attr_reader :zip, :country, :url, :weather_info

  def initialize(zip_code, country)
    @zip_code = zip_code
    @country = country
    @url = "https://api.openweathermap.org/data/2.5/weather?zip=#{zip_code},#{country}&units=imperial&appid=#{Rails.application.credentials[:open_weather_api_key]}"
    @weather_info = nil
  end

  def fetch_weather_info
    response = HTTParty.get(url)
    # puts response.body, response.code, response.message, response.headers.inspect
    JSON.parse(response.body)
  end

  # Processes the result for the weather service
  class Result
    attr_reader :current_temp, :min_temp, :max_temp, :weather_condition

    def initialize(weather_info)
      @current_temp = weather_info.dig('main', 'temp')
      @min_temp = weather_info.dig('main', 'temp_min')
      @max_temp = weather_info.dig('main', 'temp_max')
      @weather_condition = "#{weather_info['weather'].last['main']} - #{weather_info['weather'].last['description']}"
    end
  end
end
