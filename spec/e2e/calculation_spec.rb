require 'rails_helper'

describe 'Calculating the total by calling AirBnB' do
  context 'when all the params are present in our form' do
    let(:page) { CalculationNewPage.new }
    let(:long_term_rent) { 100_000 }

    before do
      page.visit_page
      page.set_long_term_rent_to long_term_rent
      page.set_address_to 'Prague, Czech Republic'
      page.click_submit
    end

    it 'should display the output' do
      expect(page).to have_long_term_rent_display_of(long_term_rent)
      expect(page).to have_airbnb_rent_display

      expect(page.airbnb_rent_param.to_i).to be > 1
      expect(page.airbnb_rent_param.to_i).to be_a Integer
    end
  end
end
