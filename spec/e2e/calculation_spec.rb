require 'rails_helper'
require 'airbnb_scraper'

describe 'Calculating the total by calling AirBnB' do
  context 'when all the params are present in our form' do
    it 'should return an integer from AirBnB' do
      # TODO: change this once you wire up the POST action and make sure that it
      # displays the difference
      output = AirbnbScraper.new('Corpus Christi, TX').rental_income!

      puts "AirBnB returned #{output}"

      expect(output).to be_a Integer
      expect(output).to be > 1
    end
  end
end
