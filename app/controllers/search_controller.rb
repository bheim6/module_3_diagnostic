class SearchController < ApplicationController
  def index
    @nearest_stations = stations
    binding.pry
  end

  def conn
    Faraday.new(:url => "https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json?location='80203'&radius=6.0&limit=10&fuel_type=ELEC,LPG&api_key=35363WNH5zjZuW1znKhT6vFU3Zwr6ShzFi9ZaiR7&format=JSON") do |f|
      f.adapter Faraday.default_adapter
      # f.params[:api_key] = ENV['api_key']
      # f.params[:format] = "JSON"
      # f.params[:location] = "80203"
      # f.params[:radius] = 6.0
      # f.params[:limit] = 10
      # f.params[:fuel_type] = "ELEC,LPG"
    end
  end

  def stations
    response = conn
    JSON.parse(response.body, symbolize_names: true)[:results]
  end
end
