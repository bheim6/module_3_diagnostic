class SearchController < ApplicationController
  def index
    @nearest_stations = SearchController.stations
    binding.pry
  end

  def self.conn
    Faraday.new(:url => 'https://developer.nrel.gov') do |f|
      f.adapter Faraday.default_adapter
      f.params[:api_key] = ENV['api_key']
      f.params[:format] = "json"
      f.params[:loaction] = "80203"
      f.params[:radius] = 6.0
      f.params[:limit] = 10
      f.params[:fuel_type] = "ELEC,LPG"
    end
  end

  def self.stations
    response = conn.get '/api/alt-fuel-stations/v1/nearest'
    JSON.parse(response.body, symbolize_names: true)[:results]
  end
end
