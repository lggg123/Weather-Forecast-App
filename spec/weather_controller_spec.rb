# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherController, type: :controller do
  describe 'GET home' do
    it 'renders the home template' do
      get :home
      expect(response).to render_template('home')
    end
  end

  describe 'POST show' do
    it 'renders the show page' do
      stub = stub_request(:get,
                          "https://api.openweathermap.org/data/2.5/weather?zip=91723,US&units=imperial&appid=#{Rails.application.credentials[:open_weather_api_key]}").with(headers: {
                                                                                                                                                                              'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Ruby'
                                                                                                                                                                            })
             .to_return(status: 200, body: { weather: [{ main: 'cloudy', description: 'cloudy sky' }],
                                             main: { temp: '80.816', temp_min: '33.8',
                                                     temp_max: '89.6' } }.to_json, headers: {})
      post :show, params: { zip_code: '91723', country: 'US' }
      expect(assigns(:forecast).current_temp).to eq('80.816')
      expect(assigns(:forecast).min_temp).to eq('33.8')
      expect(assigns(:forecast).max_temp).to eq('89.6')
      expect(assigns(:forecast).weather_condition).to eq('cloudy - cloudy sky')
      expect(stub).to have_been_requested
    end
  end

  # cache test:
  # memory store is per process and therefore no conflicts in parallel tests

  describe 'cache test' do
    let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }
    let(:cache) { Rails.cache }

    before do
      allow(Rails).to receive(:cache).and_return(memory_store)
      # Rails.cache.clear
    end

    it 'cache used scenario' do
      stub = stub_request(:get, "https://api.openweathermap.org/data/2.5/weather?zip=91723,US&units=imperial&appid=#{Rails.application.credentials[:open_weather_api_key]}")
             .with(
               headers: {
                 'Accept' => '*/*',
                 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                 'User-Agent' => 'Ruby'
               }
             )
             .to_return(status: 200, body: { weather: [{ main: 'cloudy', description: 'cloudy sky' }],
                                             main: { temp: '80.816', temp_min: '33.8',
                                                     temp_max: '89.6' } }.to_json, headers: {})
      post :show, params: { zip_code: '91723', country: 'US' }

      cache_key = { zip_code: 91_723 }

      cached_result = cache.fetch(cache_key)

      expect(cached_result.current_temp).to eq('80.816')
      expect(cached_result.min_temp).to eq('33.8')
      expect(cached_result.max_temp).to eq('89.6')
      expect(cached_result.weather_condition).to eq('cloudy - cloudy sky')
    end
  end
end
