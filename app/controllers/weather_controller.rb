# frozen_string_literal: true

# Controller to create the home route for the weather.
class WeatherController < ApplicationController
  def home; end

  def show
    cache_key = { zip_code: params[:zip_code] }
    @cached_data = Rails.cache.exist?(cache_key)
    @forecast = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
      weather_service = WeatherService.new(params[:zip_code], params[:country])
      WeatherService::Result.new(weather_service.fetch_weather_info)
    end
  end
end
