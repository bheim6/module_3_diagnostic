class SearchController < ApplicationController
  def index
    @nearest_stations = SearchController.stations({location: "80203", radius: 6.0, limit: 10, fuel_type: "ELEC,LPG"})
    binding.pry
  end

  def self.conn
    Farady.new(:url => 'https://developer.nrel.gov/api/alt-fuel-stations/v1/') do |f|
      f.adapter Faraday.default_adapter
      f.params[:api_key] = ENV['api_key']
      f.params[:format] = "json"
    end
  end

  def self.stations(filter)
    response = conn.get '/nearest', filter
    JSON.parse(response.body, symbolize_names: true)[:results]
  end
end
