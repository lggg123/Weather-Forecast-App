# frozen_string_literal: true

require 'test_helper'

class WeatherControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get weather_home_url
    assert_response :success
  end
end
