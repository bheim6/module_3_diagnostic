require 'rails_helper'

RSpec.feature "Search alternative fuel stations by zip code" do
  scenario "Search for stations with zip 80203" do
    # As a user
    # When I visit "/"
    visit '/'
    # And I fill in the search form with 80203
    fill_in "q", with: "80203"
    # And I click "Locate"
    click_on "Locate"
    # Then I should be on page "/search" with parameters visible in the url
    expect(current_path).to eq(search_path)
    # Then I should see a list of the 10 closest stations within 6 miles sorted by distance
    expect(page).to have_content(10)
    # And the stations should be limited to Electric and Propane
    expect(page).to have_content("Electric Propane")
    # And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times
    expect(page).to include?("Name, Address, Fuel Type, Dist, Access Times")
  end
end
